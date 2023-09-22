import 'package:app/core/data/event/dtos/event_list_ticket_types_dto/event_list_ticket_types_dto.dart';
import 'package:app/core/data/event/dtos/event_ticket_dto/event_ticket_dto.dart';
import 'package:app/core/data/event/dtos/event_ticket_pricing_dto/event_ticket_pricing_dto.dart';
import 'package:app/core/data/event/gql/event_query.dart';
import 'package:app/core/data/event/gql/event_tickets_mutation.dart';
import 'package:app/core/domain/event/entities/event_list_ticket_types.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/event/entities/event_ticket_pricing.dart';
import 'package:app/core/domain/event/input/get_event_list_ticket_types_input/get_event_list_ticket_types_input.dart';
import 'package:app/core/domain/event/input/get_event_ticket_pricing_input/get_event_ticket_pricing_input.dart';
import 'package:app/core/domain/event/input/redeem_tickets_input/redeem_tickets_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
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
  Future<Either<Failure, EventListTicketTypes>> getEventListTicketTypes({
    required GetEventListTicketTypesInput input,
  }) async {
    final result = await _client.query(
      QueryOptions(
        document: getEventTicketPricingQuery,
        variables: input.toJson(),
        parserFn: (data) => EventListTicketTypes.fromDto(
          EventListTicketTypesDto.fromJson(data['listTicketTypes']),
        ),
      ),
    );

    if (result.hasException) return Left(Failure());
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, List<EventTicket>>> redeemTickets({
    required RedeemTicketsInput input,
  }) async {
    final result = await _client.mutate(
      MutationOptions(
        document: redeemTicketsMutation,
        variables: input.toJson(),
        parserFn: (data) => List.from(data['redeemTickets'] ?? [])
            .map((item) => EventTicket.fromDto(EventTicketDto.fromJson(item)))
            .toList(),
      ),
    );

    if (result.hasException) return Left(Failure());
    return Right(result.parsedData!);
  }
}
