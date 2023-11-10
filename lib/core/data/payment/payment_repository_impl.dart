import 'package:app/core/data/event/gql/event_tickets_query.dart';
import 'package:app/core/data/payment/dtos/payment_card_dto/payment_card_dto.dart';
import 'package:app/core/data/payment/dtos/payment_dto/payment_dto.dart';
import 'package:app/core/data/payment/payment_mutation.dart';
import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/domain/payment/entities/payment_card/payment_card.dart';
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
  Future<Either<Failure, PaymentCard>> createNewCard({
    required String userId,
    required String tokenId,
  }) async {
    // TODO: Temporary disable until BE deploy
    return const Right(
      PaymentCard(
        id: '',
        last4: '4242',
        brand: 'Visa',
        providerId: '1234',
      ),
    );
    // final result = await _client.mutate(
    //   MutationOptions(
    //     document: createNewCardMutation,
    //     variables: {
    //       'payment_account': userId,
    //       'payment_method': tokenId,
    //     },
    //     parserFn: (data) => PaymentCard.fromDto(
    //       PaymentCardDto.fromJson(data['createStripeCard']),
    //     ),
    //   ),
    // );
    // if (result.hasException) {
    //   return Left(Failure.withGqlException(result.exception));
    // }
    // return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, List<PaymentCard>>> getListCard() async {
    final result = await _client.query(
      QueryOptions(
        document: getListCardQuery,
        variables: const {
          'skip': 0,
          'limit': 20,
          'provider': 'local',
        },
        parserFn: (data) => List.from(data['getStripeCards'] ?? [])
            .map(
              (item) => PaymentCard.fromDto(
                PaymentCardDto.fromJson(item),
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
