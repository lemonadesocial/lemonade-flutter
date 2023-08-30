import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_event_detail_input.freezed.dart';
part 'get_event_detail_input.g.dart';

@freezed
class GetEventDetailInput with _$GetEventDetailInput {
  const factory GetEventDetailInput({
    required String id,
  }) = _GetEventDetailInput;

  factory GetEventDetailInput.fromJson(Map<String, dynamic> json) => _$GetEventDetailInputFromJson(json);
}