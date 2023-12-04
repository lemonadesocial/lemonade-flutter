import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_event_currencies_input.freezed.dart';
part 'get_event_currencies_input.g.dart';

@freezed
class GetEventCurrenciesInput with _$GetEventCurrenciesInput {
  factory GetEventCurrenciesInput({
    required String id,
    @Default(true) bool? used,
  }) = _GetEventCurrenciesInput;

  factory GetEventCurrenciesInput.fromJson(Map<String, dynamic> json) =>
      _$GetEventCurrenciesInputFromJson(json);
}
