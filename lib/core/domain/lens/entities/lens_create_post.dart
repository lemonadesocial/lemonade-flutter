import 'package:freezed_annotation/freezed_annotation.dart';

part 'lens_create_post.freezed.dart';
part 'lens_create_post.g.dart';

@freezed
class LensPostUnsatisfiedRule with _$LensPostUnsatisfiedRule {
  const factory LensPostUnsatisfiedRule({
    String? reason,
    String? message,
  }) = _LensPostUnsatisfiedRule;

  factory LensPostUnsatisfiedRule.fromJson(Map<String, dynamic> json) =>
      _$LensPostUnsatisfiedRuleFromJson(json);
}

@freezed
class LensPostUnsatisfiedRulesList with _$LensPostUnsatisfiedRulesList {
  const factory LensPostUnsatisfiedRulesList({
    List<LensPostUnsatisfiedRule>? required,
    List<LensPostUnsatisfiedRule>? anyOf,
  }) = _LensPostUnsatisfiedRulesList;

  factory LensPostUnsatisfiedRulesList.fromJson(Map<String, dynamic> json) =>
      _$LensPostUnsatisfiedRulesListFromJson(json);
}

@Freezed(unionKey: '__typename')
sealed class LensPostResult with _$LensPostResult {
  @FreezedUnionValue("PostResponse")
  const factory LensPostResult.response({
    String? hash,
  }) = LensPostResultResponse;

  @FreezedUnionValue("PostOperationValidationFailed")
  const factory LensPostResult.operationValidationFailed({
    String? reason,
    LensPostUnsatisfiedRulesList? unsatisfiedRules,
  }) = LensPostResultOperationValidationFailed;

  @FreezedUnionValue("SponsoredTransactionRequest")
  const factory LensPostResult.sponsoredTransactionRequest({
    String? reason,
  }) = LensPostResultSponsoredTransactionRequest;

  @FreezedUnionValue("SelfFundedTransactionRequest")
  const factory LensPostResult.selfFundedTransactionRequest({
    String? reason,
  }) = LensPostResultSelfFundedTransactionRequest;

  @FreezedUnionValue("TransactionWillFail")
  const factory LensPostResult.transactionWillFail({
    String? reason,
  }) = LensPostResultTransactionWillFail;

  factory LensPostResult.fromJson(Map<String, dynamic> json) =>
      _$LensPostResultFromJson(json);
}
