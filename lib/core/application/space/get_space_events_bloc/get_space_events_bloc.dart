import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/backend/event/query/get_events.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_space_events_bloc.freezed.dart';

@freezed
class GetSpaceEventsEvent with _$GetSpaceEventsEvent {
  const factory GetSpaceEventsEvent.fetch({
    required Variables$Query$GetEvents input,
  }) = _Fetch;
}

@freezed
class GetSpaceEventsState with _$GetSpaceEventsState {
  const factory GetSpaceEventsState.initial() = _Initial;
  const factory GetSpaceEventsState.loading() = _Loading;
  const factory GetSpaceEventsState.success({
    required List<Event> events,
  }) = _Success;
  const factory GetSpaceEventsState.failure(Failure failure) = _Failure;
}

class GetSpaceEventsBloc
    extends Bloc<GetSpaceEventsEvent, GetSpaceEventsState> {
  GetSpaceEventsBloc() : super(const GetSpaceEventsState.loading()) {
    on<_Fetch>(_onFetch);
  }
  Future<void> _onFetch(_Fetch event, Emitter emit) async {
    emit(const GetSpaceEventsState.loading());

    final result = await getIt<AppGQL>().client.query$GetEvents(
          Options$Query$GetEvents(
            variables: event.input,
          ),
        );

    if (result.hasException || result.parsedData?.events == null) {
      emit(
        GetSpaceEventsState.failure(
          Failure.withGqlException(result.exception),
        ),
      );
      return;
    }

    final events = (result.parsedData?.events ?? [])
        .map((e) => Event.fromDto(EventDto.fromJson(e.toJson())))
        .toList();

    emit(GetSpaceEventsState.success(events: events));
  }
}
