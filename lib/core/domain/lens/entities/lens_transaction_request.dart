import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lens_transaction_request.freezed.dart';
part 'lens_transaction_request.g.dart';

@freezed
class LensPaymasterParams with _$LensPaymasterParams {
  const factory LensPaymasterParams({
    String? paymaster,
    String? paymasterInput,
  }) = _LensPaymasterParams;

  factory LensPaymasterParams.fromJson(Map<String, dynamic> json) =>
      _$LensPaymasterParamsFromJson(json);
}

@freezed
class LensEip712Meta with _$LensEip712Meta {
  @JsonSerializable(explicitToJson: true)
  const factory LensEip712Meta({
    String? gasPerPubdata,
    List<String>? factoryDeps,
    String? customSignature,
    LensPaymasterParams? paymasterParams,
  }) = _LensCustomData;

  factory LensEip712Meta.fromJson(Map<String, dynamic> json) =>
      _$LensEip712MetaFromJson(json);
}

@freezed
class LensEip712TransactionRequest with _$LensEip712TransactionRequest {
  @JsonSerializable(explicitToJson: true)
  const factory LensEip712TransactionRequest({
    int? type,
    String? to,
    String? from,
    int? nonce,
    int? gasLimit,
    String? maxPriorityFeePerGas,
    String? maxFeePerGas,
    String? data,
    String? value,
    int? chainId,
    LensEip712Meta? customData,
  }) = _LensEip712TransactionRequest;

  factory LensEip712TransactionRequest.fromJson(Map<String, dynamic> json) =>
      _$LensEip712TransactionRequestFromJson(json);
}

@freezed
class LensEip1559TransactionRequest with _$LensEip1559TransactionRequest {
  @JsonSerializable(explicitToJson: true)
  const factory LensEip1559TransactionRequest({
    int? type,
    String? to,
    String? from,
    int? nonce,
    int? gasLimit,
    String? maxPriorityFeePerGas,
    String? maxFeePerGas,
    String? data,
    String? value,
    int? chainId,
  }) = _LensEip1559TransactionRequest;

  factory LensEip1559TransactionRequest.fromJson(Map<String, dynamic> json) =>
      _$LensEip1559TransactionRequestFromJson(json);
}

@freezed
class LensSponsoredTransactionRequest with _$LensSponsoredTransactionRequest {
  const factory LensSponsoredTransactionRequest({
    String? reason,
    Enum$SponsoredFallbackReason? sponsoredReason,
    LensEip712TransactionRequest? raw,
  }) = _LensSponsoredTransactionRequest;

  factory LensSponsoredTransactionRequest.fromJson(Map<String, dynamic> json) =>
      _$LensSponsoredTransactionRequestFromJson(json);
}

@freezed
class LensSelfFundedTransactionRequest with _$LensSelfFundedTransactionRequest {
  const factory LensSelfFundedTransactionRequest({
    String? reason,
    Enum$SelfFundedFallbackReason? selfFundedReason,
    LensEip1559TransactionRequest? raw,
  }) = _LensSelfFundedTransactionRequest;
}

@freezed
class LensTransactionWillFail with _$LensTransactionWillFail {
  const factory LensTransactionWillFail({
    String? reason,
  }) = _LensTransactionWillFail;

  factory LensTransactionWillFail.fromJson(Map<String, dynamic> json) =>
      _$LensTransactionWillFailFromJson(json);
}
