import 'package:app/core/data/event/dtos/event_payment_dto/event_payment_dto.dart';
import 'package:app/core/data/event/gql/event_payment_query.dart';
import 'package:app/core/domain/event/entities/event_payment.dart';
import 'package:app/core/domain/event/input/get_event_payments_input/get_event_payments_input.dart';
import 'package:app/core/domain/event/repository/event_payment_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class EventPaymentRepositoryImpl implements EventPaymentRepository {
  final client = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, List<EventPayment>>> getEventPayments({
    required GetEventPaymentsInput input,
  }) async {
    final result = await client.query(
      QueryOptions(
        document: getEventPaymentsQuery,
        variables: input.toJson(),
        parserFn: (data) => List.from(data['getPayments'])
            .map(
              (item) => EventPayment.fromDto(EventPaymentDto.fromJson(item)),
            )
            .toList(),
      ),
    );
    if (result.hasException) return Left(Failure());
    return Right(result.parsedData ?? []);
  }
}
