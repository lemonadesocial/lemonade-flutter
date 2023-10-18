import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_input.freezed.dart';
part 'report_input.g.dart';

@freezed
class ReportInput with _$ReportInput {
  factory ReportInput({
    required String id,
    required String reason,
  }) = _ReportInput;

  factory ReportInput.fromJson(Map<String, dynamic> json) =>
      _$ReportInputFromJson(json);
}
