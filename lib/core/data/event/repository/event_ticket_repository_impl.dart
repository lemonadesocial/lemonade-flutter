import 'package:app/core/data/event/dtos/buy_tickets_response_dto/buy_tickets_response_dto.dart';
import 'package:app/core/data/event/dtos/event_currency_dto/event_currency_dto.dart';
import 'package:app/core/data/event/dtos/event_ticket_types_dto/event_ticket_types_dto.dart';
import 'package:app/core/data/event/dtos/event_ticket_dto/event_ticket_dto.dart';
import 'package:app/core/data/event/dtos/event_tickets_pricing_info_dto/event_tickets_pricing_info_dto.dart';
import 'package:app/core/data/event/dtos/redeem_tickets_response_dto/redeem_tickets_response_dto.dart';
import 'package:app/core/data/event/gql/event_tickets_mutation.dart';
import 'package:app/core/data/event/gql/event_tickets_query.dart';
import 'package:app/core/domain/event/entities/buy_tickets_response.dart';
import 'package:app/core/domain/event/entities/event_currency.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/domain/event/entities/redeem_tickets_response.dart';
import 'package:app/core/domain/event/input/assign_tickets_input/assign_tickets_input.dart';
import 'package:app/core/domain/event/input/buy_tickets_input/buy_tickets_input.dart';
import 'package:app/core/domain/event/input/calculate_tickets_pricing_input/calculate_tickets_pricing_input.dart';
import 'package:app/core/domain/event/input/get_event_currencies_input/get_event_currencies_input.dart';
import 'package:app/core/domain/event/input/get_event_ticket_types_input/get_event_ticket_types_input.dart';
import 'package:app/core/domain/event/input/get_tickets_input/get_tickets_input.dart';
import 'package:app/core/domain/event/input/redeem_tickets_input/redeem_tickets_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/backend/event/mutation/create_event_ticket_type.graphql.dart';
import 'package:app/graphql/backend/event/mutation/create_tickets.graphql.dart';
import 'package:app/graphql/backend/event/mutation/delete_event_ticket_type.graphql.dart';
import 'package:app/graphql/backend/event/mutation/update_event_ticket_type.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
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
        variables: {'input': input.toJson()},
        fetchPolicy: FetchPolicy.networkOnly,
        parserFn: (data) {
          return EventTicketsPricingInfo.fromDto(
            EventTicketsPricingInfoDto.fromJson(
              data['calculateTicketsPricing'],
            ),
          );
        },
      ),
    );

    if (result.hasException) return Left(Failure());
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, EventTicketTypesResponse>> getEventTicketTypes({
    required GetEventTicketTypesInput input,
  }) async {
    final result = await _client.query(
      QueryOptions(
        document: getEventTicketTypesQuery,
        variables: {
          'input': input.toJson(),
        },
        fetchPolicy: FetchPolicy.networkOnly,
        parserFn: (data) => EventTicketTypesResponse.fromDto(
          EventTicketTypesResponseDto.fromJson(data['getEventTicketTypes']),
        ),
      ),
    );

    if (result.hasException) return Left(Failure());
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, RedeemTicketsResponse>> redeemTickets({
    required RedeemTicketsInput input,
  }) async {
    final result = await _client.mutate(
      MutationOptions(
        document: redeemTicketsMutation,
        variables: {
          'input': input.toJson(),
        },
        parserFn: (data) => RedeemTicketsResponse.fromDto(
          RedeemTicketsResponseDto.fromJson(data['redeemTickets'] ?? []),
        ),
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

  @override
  Future<Either<Failure, BuyTicketsResponse>> buyTickets({
    required BuyTicketsInput input,
  }) async {
    final result = await _client.query(
      QueryOptions(
        document: buyTicketsMutation,
        variables: {
          'input': input.toJson(),
        },
        fetchPolicy: FetchPolicy.networkOnly,
        parserFn: (data) => BuyTicketsResponse.fromDto(
          BuyTicketsResponseDto.fromJson(
            data['buyTickets'],
          ),
        ),
      ),
    );

    if (result.hasException) return Left(Failure());
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, List<EventCurrency>>> getEventCurrencies({
    required GetEventCurrenciesInput input,
    FetchPolicy? fetchPolicy,
  }) async {
    final result = await _client.query(
      QueryOptions(
        document: getEventCurrenciesQuery,
        variables: input.toJson(),
        fetchPolicy: fetchPolicy,
        parserFn: (data) => List.from(data['getEventCurrencies'] ?? [])
            .map(
              (item) => EventCurrency.fromDto(
                EventCurrencyDto.fromJson(item),
              ),
            )
            .toList(),
      ),
    );

    if (result.hasException) return Left(Failure());
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, EventTicketType>> createEventTicketType({
    required Input$EventTicketTypeInput input,
  }) async {
    final result = await _client.mutate$CreateEventTicketType(
      Options$Mutation$CreateEventTicketType(
        variables: Variables$Mutation$CreateEventTicketType(
          input: input,
        ),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException || result.parsedData == null) {
      return Left(Failure());
    }
    return Right(
      EventTicketType.fromDto(
        EventTicketTypeDto.fromJson(
          result.parsedData!.createEventTicketType.toJson(),
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, EventTicketType>> updateEventTicketType({
    required String ticketTypeId,
    required Input$EventTicketTypeInput input,
  }) async {
    final result = await _client.mutate$UpdateEventTicketType(
      Options$Mutation$UpdateEventTicketType(
        variables: Variables$Mutation$UpdateEventTicketType(
          id: ticketTypeId,
          input: input,
        ),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException || result.parsedData == null) {
      return Left(Failure());
    }
    return Right(
      EventTicketType.fromDto(
        EventTicketTypeDto.fromJson(
          result.parsedData!.updateEventTicketType.toJson(),
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, bool>> deleteEventTicketType({
    required String ticketTypeId,
    required String eventId,
  }) async {
    final result = await _client.mutate$DeleteEventTicketType(
      Options$Mutation$DeleteEventTicketType(
        variables: Variables$Mutation$DeleteEventTicketType(
          event: eventId,
          id: ticketTypeId,
        ),
      ),
    );

    if (result.hasException || result.parsedData == null) {
      return Left(Failure());
    }

    return Right(
      result.parsedData?.deleteEventTicketType ?? false,
    );
  }

  @override
  Future<Either<Failure, List<EventTicket>>> createTickets({
    required Variables$Mutation$CreateTickets input,
  }) async {
    final result = await _client.mutate$CreateTickets(
      Options$Mutation$CreateTickets(
        variables: input,
      ),
    );

    if (result.hasException || result.parsedData == null) {
      return Left(Failure());
    }

    return Right(
      (result.parsedData?.createTickets ?? [])
          .map(
            (item) => EventTicket.fromDto(
              EventTicketDto.fromJson(item.toJson()),
            ),
          )
          .toList(),
    );
  }
}
