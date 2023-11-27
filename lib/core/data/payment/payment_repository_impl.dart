import 'package:app/core/data/payment/dtos/payment_dto/payment_dto.dart';
import 'package:app/core/data/payment/dtos/stripe_card_dto/stripe_card_dto.dart';
import 'package:app/core/data/payment/gql/stripe_card/stripe_card_mutation.dart';
import 'package:app/core/data/payment/gql/stripe_card/stripe_card_query.dart';
import 'package:app/core/data/payment/payment_mutation.dart';
import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/domain/payment/entities/payment_card/payment_card.dart';
import 'package:app/core/domain/payment/input/create_stripe_card_input/create_stripe_card_input.dart';
import 'package:app/core/domain/payment/input/get_stripe_cards_input/get_stripe_cards_input.dart';
import 'package:app/core/domain/payment/input/update_payment_input/update_payment_input.dart';
import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

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
}
