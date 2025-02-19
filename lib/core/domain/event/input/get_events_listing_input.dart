import 'package:app/core/domain/event/event_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_events_listing_input.freezed.dart';
part 'get_events_listing_input.g.dart';

@freezed
abstract class GetEventsInput with _$GetEventsInput {
  const factory GetEventsInput({
    @JsonKey(includeIfNull: false) String? search,
    @JsonKey(includeIfNull: false) bool? highlight,
    @JsonKey(includeIfNull: false) String? accepted,
    @JsonKey(includeIfNull: false) int? skip,
    @JsonKey(includeIfNull: false) int? limit,
  }) = _GetEventsInput;

  factory GetEventsInput.fromJson(Map<String, dynamic> json) =>
      _$GetEventsInputFromJson(json);
}

@freezed
abstract class GetHomeEventsInput with _$GetHomeEventsInput {
  const factory GetHomeEventsInput({
    @JsonKey(includeIfNull: false) String? query,
    @JsonKey(includeIfNull: false) int? skip,
    @JsonKey(includeIfNull: false) int? limit,
    @Default(0) @JsonKey(includeIfNull: false) double? latitude,
    @Default(0) @JsonKey(includeIfNull: false) double? longitude,
    @Default(EventTense.Future) EventTense tense,
  }) = _GetHomeEventsInput;

  factory GetHomeEventsInput.fromJson(Map<String, dynamic> json) =>
      _$GetHomeEventsInputFromJson(json);
}

@freezed
abstract class GetHostingEventsInput with _$GetHostingEventsInput {
  const factory GetHostingEventsInput({
    @JsonKey(includeIfNull: false) String? id,
    @JsonKey(includeIfNull: false) FilterEventInput? state,
    @JsonKey(includeIfNull: false) int? skip,
    @JsonKey(includeIfNull: false) int? limit,
    @JsonKey(includeIfNull: false) bool? draft,
  }) = _GetHostingEventsInput;

  factory GetHostingEventsInput.fromJson(Map<String, dynamic> json) =>
      _$GetHostingEventsInputFromJson(json);
}

@freezed
abstract class FilterEventInput with _$FilterEventInput {
  const factory FilterEventInput({
    @JsonKey(includeIfNull: false) EventState? eq,
    @JsonKey(name: 'in', includeIfNull: false) List<EventState>? include,
    @JsonKey(name: 'nin', includeIfNull: false) List<EventState>? notInclude,
  }) = _FilterEventInput;

  factory FilterEventInput.fromJson(Map<String, dynamic> json) =>
      _$FilterEventInputFromJson(json);
}

@freezed
abstract class GetUpcomingEventsInput with _$GetUpcomingEventsInput {
  const factory GetUpcomingEventsInput({
    @JsonKey(includeIfNull: false) String? id,
    @JsonKey(includeIfNull: false) int? skip,
    @JsonKey(includeIfNull: false) int? limit,
    @JsonKey(includeIfNull: false) bool? host,
  }) = _GetUpcomingEventsInput;

  factory GetUpcomingEventsInput.fromJson(Map<String, dynamic> json) =>
      _$GetUpcomingEventsInputFromJson(json);
}

@freezed
abstract class GetPastEventsInput with _$GetPastEventsInput {
  const factory GetPastEventsInput({
    @JsonKey(includeIfNull: false) String? id,
    @JsonKey(includeIfNull: false) int? skip,
    @JsonKey(includeIfNull: false) int? limit,
  }) = _GetPastEventsInput;

  factory GetPastEventsInput.fromJson(Map<String, dynamic> json) =>
      _$GetPastEventsInputFromJson(json);
}
