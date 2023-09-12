import 'package:app/core/data/event/dtos/event_ticket_pricing_dto/event_ticket_pricing_dto.dart';
import 'package:app/core/data/event/event_mutation.dart';
import 'package:app/core/data/event/event_query.dart';
import 'package:app/core/data/payment/dtos/payment_dtos.dart';
import 'package:app/core/domain/event/entities/event_ticket_pricing.dart';
import 'package:app/core/domain/event/input/get_event_ticket_pricing_input/get_event_ticket_pricing_input.dart';
import 'package:app/core/domain/event/input/redeem_event_ticket_input/redeem_event_ticket_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: EventTicketRepository)
class EventTicketRepositoryImpl implements EventTicketRepository {
  final _client = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, EventTicketPricing>> getEventTicketPricing({
    required GetEventTicketPricingInput input,
  }) async {
    final result = await _client.query(
      QueryOptions(
        document: getEventTicketPricingQuery,
        variables: input.toJson(),
        parserFn: (data) => EventTicketPricing.fromDto(
          EventTicketPricingDto.fromJson(data['getEventTicketPricing']),
        ),
      ),
    );

    if (result.hasException) return Left(Failure());
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, Payment>> redeemEventTickets({
    required RedeemEventTicketInput input,
  }) async {
    final result = await _client.mutate(
      MutationOptions(
        document: redeemEventTicketsMutation,
        variables: input.toJson(),
        parserFn: (data) =>
            Payment.fromDto(PaymentDto.fromJson(data['redeemEventTickets'])),
      ),
    );

    if (result.hasException) return Left(Failure());
    return Right(result.parsedData!);
  }
}
