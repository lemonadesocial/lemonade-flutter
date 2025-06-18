import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lens_create_username.freezed.dart';
part 'lens_create_username.g.dart';

@freezed
sealed class LensCreateUsernameResult with _$LensCreateUsernameResult {
  const factory LensCreateUsernameResult.createUsernameResponse({
    required String hash,
  }) = CreateUsernameResponse;

  const factory LensCreateUsernameResult.usernameTaken({
    required String ownedBy,
    required String reason,
  }) = UsernameTaken;

  const factory LensCreateUsernameResult.namespaceOperationValidationFailed({
    required String reason,
  }) = NamespaceOperationValidationFailed;

  const factory LensCreateUsernameResult.transactionWillFail({
    required String reason,
  }) = TransactionWillFail;

  @JsonSerializable(explicitToJson: true)
  const factory LensCreateUsernameResult.selfFundedTransactionRequest({
    String? reason,
    Enum$SelfFundedFallbackReason? selfFundedReason,
    Eip712TransactionRequest? raw,
  }) = LensSelfFundedTransactionRequest;

  @JsonSerializable(explicitToJson: true)
  const factory LensCreateUsernameResult.sponsoredTransactionRequest({
    required String reason,
    Eip712TransactionRequest? eip712TransactionRequest,
  }) = SponsoredTransactionRequest;

  factory LensCreateUsernameResult.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$LensCreateUsernameResultFromJson(json);
}

@freezed
class Eip712TransactionRequest with _$Eip712TransactionRequest {
  const factory Eip712TransactionRequest({
    int? type,
    String? to,
    String? from,
    int? nonce,
    int? gasLimit,
    String? maxFeePerGas,
    String? maxPriorityFeePerGas,
    String? data,
    String? value,
    int? chainId,
  }) = _Eip712TransactionRequest;

  factory Eip712TransactionRequest.fromJson(Map<String, dynamic> json) =>
      _$Eip712TransactionRequestFromJson(json);
}
