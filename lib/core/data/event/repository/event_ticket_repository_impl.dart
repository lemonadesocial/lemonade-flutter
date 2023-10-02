import 'package:app/core/data/event/dtos/event_list_ticket_types_dto/event_list_ticket_types_dto.dart';
import 'package:app/core/data/event/dtos/event_ticket_dto/event_ticket_dto.dart';
import 'package:app/core/data/event/dtos/event_tickets_pricing_info_dto/event_tickets_pricing_info_dto.dart';
import 'package:app/core/data/event/gql/event_tickets_mutation.dart';
import 'package:app/core/data/event/gql/event_tickets_query.dart';
import 'package:app/core/domain/event/entities/event_list_ticket_types.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/domain/event/input/assign_tickets_input/assign_tickets_input.dart';
import 'package:app/core/domain/event/input/calculate_tickets_pricing_input/calculate_tickets_pricing_input.dart';
import 'package:app/core/domain/event/input/get_event_list_ticket_types_input/get_event_list_ticket_types_input.dart';
import 'package:app/core/domain/event/input/get_tickets_input/get_tickets_input.dart';
import 'package:app/core/domain/event/input/redeem_tickets_input/redeem_tickets_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: EventTicketRepository)
class EventTicketRepositoryImpl implements EventTicketRepository {
  final _client = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, EventTicketsPricingInfo>> calculateTicketsPricing({
    required CalculateTicketsPricingInput input,
  }) async {
    final result = await _client.query(
      QueryOptions(
        document: calculateTicketsPricingInfoQuery,
        variables: input.toJson(),
        fetchPolicy: FetchPolicy.networkOnly,
        parserFn: (data) => EventTicketsPricingInfo.fromDto(
          EventTicketsPricingInfoDto.fromJson(data['calculateTicketsPricing']),
        ),
      ),
    );

    if (result.hasException) return Left(Failure());
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, EventListTicketTypesResponse>>
      getEventListTicketTypesResponse({
    required GetEventListTicketTypesResponseInput input,
  }) async {
    final result = await _client.query(
      QueryOptions(
        document: getEventListTicketTypesResponseQuery,
        variables: {'input': input.toJson()},
        fetchPolicy: FetchPolicy.networkOnly,
        parserFn: (data) => EventListTicketTypesResponse.fromDto(
          EventListTicketTypesResponseDto.fromJson(data['listTicketTypes']),
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
        variables: {
          'input': input.toJson(),
        },
        parserFn: (data) => List.from(data['redeemTickets'] ?? [])
            .map((item) => EventTicket.fromDto(EventTicketDto.fromJson(item)))
            .toList(),
      ),
    );

    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, bool>> assignTickets({
    required AssignTicketsInput input,
  }) async {
    final result = await _client.mutate(
      MutationOptions(
        document: assignTicketsMutation,
        variables: {
          'input': input.toJson(),
        },
        parserFn: (data) => data['assignTickets'] ?? false,
      ),
    );

    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, List<EventTicket>>> getTickets({
    required GetTicketsInput input,
  }) async {
    final result = await _client.query(
      QueryOptions(
        document: getTicketsQuery,
        variables: input.toJson(),
        fetchPolicy: FetchPolicy.networkOnly,
        parserFn: (data) => List.from(data['getTickets'] ?? [])
            .map((item) => EventTicket.fromDto(EventTicketDto.fromJson(item)))
            .toList(),
      ),
    );

    if (result.hasException) return Left(Failure());
    return Right(result.parsedData!);
  }
}
