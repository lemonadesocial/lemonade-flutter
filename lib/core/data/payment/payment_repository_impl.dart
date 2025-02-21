import 'package:app/core/data/payment/dtos/payment_account_dto/payment_account_dto.dart';
import 'package:app/core/data/payment/dtos/payment_dto/payment_dto.dart';
import 'package:app/core/data/payment/dtos/stripe_card_dto/stripe_card_dto.dart';
import 'package:app/core/data/payment/gql/stripe_card/stripe_card_mutation.dart';
import 'package:app/core/data/payment/gql/stripe_card/stripe_card_query.dart';
import 'package:app/core/data/payment/payment_mutation.dart';
import 'package:app/core/data/payment/payment_query.dart';
import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/entities/payment_card/payment_card.dart';
import 'package:app/core/domain/payment/input/create_payment_account_input/create_payment_account_input.dart';
import 'package:app/core/domain/payment/input/create_stripe_card_input/create_stripe_card_input.dart';
import 'package:app/core/domain/payment/input/get_payment_accounts_input/get_payment_accounts_input.dart';
import 'package:app/core/domain/payment/input/get_payment_input/get_payment_input.dart';
import 'package:app/core/domain/payment/input/get_stripe_cards_input/get_stripe_cards_input.dart';
import 'package:app/core/domain/payment/input/update_payment_input/update_payment_input.dart';
import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/backend/payment/mutation/mail_ticket_payment_receipt.graphql.dart';
import 'package:app/graphql/backend/payment/query/get_new_payment.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:app/core/data/payment/dtos/event_payment_statistics_dto/event_payment_statistics_dto.dart';
import 'package:app/core/domain/payment/entities/event_payment_statistics/event_payment_statistics.dart';
import 'package:app/graphql/backend/payment/query/get_event_payment_statistics.graphql.dart';
import 'package:graphql/client.dart';
import 'package:app/graphql/backend/payment/query/list_event_payments.graphql.dart';
import 'package:app/core/data/payment/dtos/list_event_payments_response_dto/list_event_payments_response_dto.dart';
import 'package:app/core/domain/payment/entities/list_event_payments_response/list_event_payments_response.dart';

@LazySingleton(as: PaymentRepository)
class PaymentRepositoryImpl extends PaymentRepository {
  final _client = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, PaymentCard>> createStripeCard({
    required CreateStripeCardInput input,
  }) async {
    final result = await _client.mutate(
      MutationOptions(
        document: createStripeCardMutation,
        variables: input.toJson(),
        parserFn: (data) => PaymentCard.fromDto(
          StripeCardDto.fromJson(data['createStripeCard']),
        ),
      ),
    );
    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, List<PaymentCard>>> getStripeCards({
    required GetStripeCardsInput input,
  }) async {
    final result = await _client.query(
      QueryOptions(
        document: getStripeCardsQuery,
        variables: input.toJson(),
        fetchPolicy: FetchPolicy.networkOnly,
        parserFn: (data) => List.from(
          data['getStripeCards'] ?? [],
        )
            .map(
              (item) => PaymentCard.fromDto(
                StripeCardDto.fromJson(item),
              ),
            )
            .toList(),
      ),
    );

    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, Payment?>> getPayment({
    required GetPaymentInput input,
  }) async {
    final result = await _client.mutate(
      MutationOptions(
        document: getPaymentQuery,
        variables: input.toJson(),
        fetchPolicy: FetchPolicy.networkOnly,
        parserFn: (data) => data['getNewPayment'] != null
            ? Payment.fromDto(
                PaymentDto.fromJson(
                  data['getNewPayment'],
                ),
              )
            : null,
      ),
    );

    if (result.hasException) return Left(Failure());
    return Right(result.parsedData);
  }

  @override
  Future<Either<Failure, Payment?>> updatePayment({
    required UpdatePaymentInput input,
  }) async {
    final result = await _client.mutate(
      MutationOptions(
        document: updatePaymentMutation,
        variables: {
          'input': input.toJson(),
        },
        fetchPolicy: FetchPolicy.networkOnly,
        parserFn: (data) => data['updatePayment'] != null
            ? Payment.fromDto(
                PaymentDto.fromJson(
                  data['updatePayment'],
                ),
              )
            : null,
      ),
    );

    if (result.hasException) return Left(Failure());
    return Right(result.parsedData);
  }

  @override
  Future<Either<Failure, List<PaymentAccount>>> getPaymentAccounts({
    required GetPaymentAccountsInput input,
  }) async {
    final result = await _client.query(
      QueryOptions(
        document: getPaymentAccountsQuery,
        variables: input.toJson(),
        fetchPolicy: FetchPolicy.networkOnly,
        parserFn: (data) => List.from(data['listNewPaymentAccounts'] ?? [])
            .map(
              (item) => PaymentAccount.fromDto(
                PaymentAccountDto.fromJson(item),
              ),
            )
            .toList(),
      ),
    );
    if (result.hasException) return Left(Failure());
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, PaymentAccount>> createPaymentAccount({
    required CreatePaymentAccountInput input,
  }) async {
    final result = await _client.mutate(
      MutationOptions(
        document: createPaymentAccountMutation,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          'input': input.toJson(),
        },
        parserFn: (data) => PaymentAccount.fromDto(
          PaymentAccountDto.fromJson(data['createNewPaymentAccount']),
        ),
      ),
    );
    if (result.hasException) return Left(Failure());
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, bool>> mailTicketPaymentReciept({
    required String ticketId,
  }) async {
    final result = await _client.mutate$MailTicketPaymentReceipt(
      Options$Mutation$MailTicketPaymentReceipt(
        variables: Variables$Mutation$MailTicketPaymentReceipt(
          ticket: ticketId,
        ),
      ),
    );

    if (result.hasException || result.parsedData == null) {
      return Left(Failure());
    }

    return Right(result.parsedData?.mailTicketPaymentReceipt ?? false);
  }

  @override
  Future<Either<Failure, EventPaymentStatistics>> getEventPaymentStatistics({
    required String eventId,
  }) async {
    final result = await _client.query$GetEventPaymentStatistics(
      Options$Query$GetEventPaymentStatistics(
        variables: Variables$Query$GetEventPaymentStatistics(
          event: eventId,
        ),
      ),
    );

    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }

    final data = result.parsedData?.getEventPaymentStatistics;
    if (data == null) {
      return Left(Failure());
    }
    final dto = EventPaymentStatisticsDto.fromJson(data.toJson());
    return Right(EventPaymentStatistics.fromDto(dto));
  }

  @override
  Future<Either<Failure, ListEventPaymentsResponse>> listEventPayments({
    required Variables$Query$ListEventPayments input,
  }) async {
    final result = await _client.query$ListEventPayments(
      Options$Query$ListEventPayments(
        variables: input,
      ),
    );

    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }

    final data = result.parsedData?.listEventPayments;
    if (data == null) {
      return Left(Failure());
    }

    final dto = ListEventPaymentsResponseDto.fromJson(data.toJson());
    return Right(ListEventPaymentsResponse.fromDto(dto));
  }

  @override
  Future<Either<Failure, Payment>> getNewPayment({
    required Variables$Query$GetNewPayment input,
  }) async {
    final result = await _client.query$GetNewPayment(
      Options$Query$GetNewPayment(
        variables: input,
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException || result.parsedData?.getNewPayment == null) {
      return Left(Failure());
    }

    return Right(
      Payment.fromDto(
        PaymentDto.fromJson(
          result.parsedData!.getNewPayment!.toJson(),
        ),
      ),
    );
  }
}
