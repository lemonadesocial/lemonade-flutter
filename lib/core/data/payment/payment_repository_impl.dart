import 'package:app/core/data/event/gql/event_tickets_query.dart';
import 'package:app/core/data/payment/dtos/payment_card_dto/payment_card_dto.dart';
import 'package:app/core/domain/payment/entities/payment_card_entity/payment_card_entity.dart';
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
  Future<Either<Failure, bool>> createNewCard() async {
    return right(true);
  }

  @override
  Future<Either<Failure, dynamic>> createNewPayment() {
    // TODO: implement createNewPayment
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PaymentCardEntity>>> getListCard() async {
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
              (item) => PaymentCardEntity.fromDto(
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
  Future<Either<Failure, String>> getPublishableKey() async {
    return Right('');
  }
}
