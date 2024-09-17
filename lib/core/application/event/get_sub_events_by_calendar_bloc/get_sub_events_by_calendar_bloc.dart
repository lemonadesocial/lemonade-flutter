import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/backend/event/query/get_events.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:collection/collection.dart';
import 'package:app/core/utils/list/unique_list_extension.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rxdart/rxdart.dart';

part 'get_sub_events_by_calendar_bloc.freezed.dart';

class GetSubEventsByCalendarBloc
    extends Bloc<GetSubEventsByCalendarEvent, GetSubEventsByCalendarState> {
  final _client = getIt<AppGQL>().client;
  final String parentEventId;
  GetSubEventsByCalendarBloc({
    required this.parentEventId,
  }) : super(
          GetSubEventsByCalendarState(
            selectedDate: DateTime.now().toLocal().withoutTime,
            events: [],
            eventsGroupByDate: <DateTime, List<Event>>{},
            selectedHosts: [],
            selectedTags: [],
            isLoading: false,
          ),
        ) {
    on<_GetSubEventsByCalendarEventOnDateChanged>(
      _onDateChanged,
      transformer: (events, mapper) => events
          .debounceTime(
            const Duration(
              milliseconds: 200,
            ),
          )
          .switchMap(mapper),
    );
    on<_GetSubEventsByCalendarEventOnFetch>(_onFetch);
    on<_GetSubEventsByCalendarEventOnFilterUpdate>(_onFilterUpdate);
  }

  void _onDateChanged(
    _GetSubEventsByCalendarEventOnDateChanged event,
    Emitter emit,
  ) {
    DateTime selectedDate = event.selectedDate;
    final lastSelectedDate = state.selectedDate;
    if (DateUtils.isSameMonth(lastSelectedDate, selectedDate)) {
      emit(state.copyWith(selectedDate: selectedDate));
      return;
    }
    emit(state.copyWith(selectedDate: selectedDate));
    add(GetSubEventsByCalendarEvent.fetch());
  }

  void _onFilterUpdate(
    _GetSubEventsByCalendarEventOnFilterUpdate event,
    Emitter emit,
  ) {
    emit(
      state.copyWith(
        selectedHosts: event.selectedHosts ?? state.selectedHosts,
        selectedTags: event.selectedTags ?? state.selectedTags,
      ),
    );
  }

  Future<void> _onFetch(
    _GetSubEventsByCalendarEventOnFetch event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    int dayInMonth = DateUtils.getDaysInMonth(
      state.selectedDate.year,
      state.selectedDate.month,
    );
    final result = await _client.query$GetEvents(
      Options$Query$GetEvents(
        fetchPolicy: FetchPolicy.networkOnly,
        variables: Variables$Query$GetEvents(
          limit: 100,
          subevent_parent: parentEventId,
          // TODO: to be confirmed with PO
          // unpublished: true,
          startFrom:
              DateTime(state.selectedDate.year, state.selectedDate.month, 1)
                  .toUtc(),
          startTo: DateTime(
            state.selectedDate.year,
            state.selectedDate.month,
            dayInMonth,
            23,
            59,
          ).toUtc(),
        ),
      ),
    );
    if (result.hasException) {
      emit(
        state.copyWith(
          isLoading: false,
          failure: Failure(
            message: result.exception.toString(),
          ),
        ),
      );
      return;
    }
    final responsedEvents = (result.parsedData?.events ?? [])
        .map(
          (item) => Event.fromDto(
            EventDto.fromJson(item.toJson()),
          ),
        )
        .toList();
    final newEvents = [...state.events, ...responsedEvents].unique(
      (item) => item.id,
    );
    var eventsGroupByDate = _groupEventsByDate(newEvents);
    emit(
      state.copyWith(
        isLoading: false,
        failure: null,
        eventsGroupByDate: eventsGroupByDate,
        events: newEvents,
      ),
    );
  }

  Map<DateTime, List<Event>> _groupEventsByDate(List<Event> events) {
    return events.where((element) => element.start != null).groupListsBy(
          (element) => DateTime(
            element.start!.toLocal().year,
            element.start!.toLocal().month,
            element.start!.toLocal().day,
          ).withoutTime,
        );
  }
}

@freezed
class GetSubEventsByCalendarEvent with _$GetSubEventsByCalendarEvent {
  factory GetSubEventsByCalendarEvent.dateChanged({
    required DateTime selectedDate,
  }) = _GetSubEventsByCalendarEventOnDateChanged;
  factory GetSubEventsByCalendarEvent.fetch() =
      _GetSubEventsByCalendarEventOnFetch;
  factory GetSubEventsByCalendarEvent.updateFilter({
    List<String>? selectedTags,
    List<String>? selectedHosts,
  }) = _GetSubEventsByCalendarEventOnFilterUpdate;
}

@freezed
class GetSubEventsByCalendarState with _$GetSubEventsByCalendarState {
  factory GetSubEventsByCalendarState({
    required DateTime selectedDate,
    required List<Event> events,
    required Map<DateTime, List<Event>> eventsGroupByDate,
    required List<String> selectedHosts,
    required List<String> selectedTags,
    required bool isLoading,
    Failure? failure,
  }) = _GetSubEventsByCalendarState;
}
