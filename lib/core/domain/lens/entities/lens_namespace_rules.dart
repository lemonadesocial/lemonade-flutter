import 'package:freezed_annotation/freezed_annotation.dart';

part 'lens_namespace_rules.freezed.dart';
part 'lens_namespace_rules.g.dart';

@freezed
class LensPricePerLength with _$LensPricePerLength {
  const factory LensPricePerLength({
    required int length,
    required String price,
  }) = _LensPricePerLength;

  factory LensPricePerLength.fromJson(Map<String, dynamic> json) =>
      _$LensPricePerLengthFromJson(json);
}

@freezed
class LensUsernamePricePerLengthRule with _$LensUsernamePricePerLengthRule {
  const factory LensUsernamePricePerLengthRule({
    required String tokenSymbol,
    required String tokenAddress,
    required List<LensPricePerLength> pricePerLength,
  }) = _LensUsernamePricePerLengthRule;

  factory LensUsernamePricePerLengthRule.fromJson(Map<String, dynamic> json) =>
      _$LensUsernamePricePerLengthRuleFromJson(json);
}
