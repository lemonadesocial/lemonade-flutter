import 'package:app/core/domain/event/event_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_events_listing_input.freezed.dart';
part 'get_events_listing_input.g.dart';

@freezed
abstract class GetEventsInput with _$GetEventsInput {
  const factory GetEventsInput({
    @Default('') String query,
    @Default(false) bool highlight,
    @Default('') String accepted,
    @Default(100) int limit,
    @Default(0) int skip,
  }) = _GetEventsInput;

  factory GetEventsInput.fromJson(Map<String, dynamic> json) => _$GetEventsInputFromJson(json);
}

@freezed
abstract class GetHomeEventsInput with _$GetHomeEventsInput {
  const factory GetHomeEventsInput({
    @Default('') String query,
    @Default(100) int limit,
    @Default(0) double latitude,
    @Default(0) double longitude,
    @Default(EventTense.Future) EventTense tense,
  }) = _GetHomeEventsInput;

  factory GetHomeEventsInput.fromJson(Map<String, dynamic> json) => _$GetHomeEventsInputFromJson(json);
}

@freezed
abstract class GetHostingEventsInput with _$GetHostingEventsInput {
  const factory GetHostingEventsInput({
    required String id,
    FilterEventInput? state,
    @Default(100) int limit,
    @Default(0) skip,
    @Default(-1) order,
  }) = _GetHostingEventsInput;

  factory GetHostingEventsInput.fromJson(Map<String, dynamic> json) => _$GetHostingEventsInputFromJson(json);
}

@freezed
abstract class FilterEventInput with _$FilterEventInput {
  const factory FilterEventInput({
    EventState? eq,
    @JsonKey(name: 'in') List<EventState>? include,
    @JsonKey(name: 'nin') List<EventState>? notInclude,
  }) = _FilterEventInput;
  
  factory FilterEventInput.fromJson(Map<String, dynamic> json) => _$FilterEventInputFromJson(json);
}
