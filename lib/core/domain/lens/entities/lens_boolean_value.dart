import 'package:freezed_annotation/freezed_annotation.dart';

part 'lens_boolean_value.freezed.dart';
part 'lens_boolean_value.g.dart';

@Freezed()
abstract class LensBooleanValue with _$LensBooleanValue {
  const LensBooleanValue._();

  factory LensBooleanValue({
    bool? onChain,
    bool? optimistic,
  }) = _LensBooleanValue;

  factory LensBooleanValue.fromJson(Map<String, dynamic> json) =>
      _$LensBooleanValueFromJson(json);
}
