import 'package:app/core/domain/poap/poap_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'poap_dtos.freezed.dart';
part 'poap_dtos.g.dart';

class PoapViewSupplyDto {
  PoapViewSupplyDto({
    required this.claimedQuantity,
    required this.quantity,
  });

  factory PoapViewSupplyDto.fromJson(List<dynamic>? data) {
    if (data == null || data.length < 2) {
      return PoapViewSupplyDto(
        claimedQuantity: 0,
        quantity: 0,
      );
    }

    return PoapViewSupplyDto(
      claimedQuantity: num.tryParse(data[0])?.toInt() ?? 0,
      quantity: num.tryParse(data[1])?.toInt() ?? 0,
    );
  }

  final int claimedQuantity;
  final int quantity;
}

class PoapViewCheckHasClaimedDto {
  PoapViewCheckHasClaimedDto({
    required this.claimed,
  });

  factory PoapViewCheckHasClaimedDto.fromJson(List<dynamic>? data) {
    return PoapViewCheckHasClaimedDto(
      claimed: bool.tryParse(data?[0]) ?? false,
    );
  }

  final bool claimed;
}

@freezed
class ClaimDto with _$ClaimDto {
  const factory ClaimDto({
    @JsonKey(name: '_id') String? id,
    String? network,
    ClaimState? state,
    String? errorMessage,
    ClaimArgsDto? args,
    String? address,
    String? tokenId,
  }) = _ClaimDto;

  factory ClaimDto.fromJson(Map<String, dynamic> json) => _$ClaimDtoFromJson(json);
}

@freezed
class ClaimArgsDto with _$ClaimArgsDto {
  const factory ClaimArgsDto({
    String? claimer,
    String? tokenURI,
  }) = _ClaimArgsDto;

  factory ClaimArgsDto.fromJson(Map<String, dynamic> json) => _$ClaimArgsDtoFromJson(json);
}

@freezed
class PoapPolicyNodeDto with _$PoapPolicyNodeDto {
  const factory PoapPolicyNodeDto({
    required String value,
    @JsonKey(defaultValue: <PoapPolicyNodeDto>[]) List<PoapPolicyNodeDto>? children,
  }) = _PoapPolicyNodeDto;

  factory PoapPolicyNodeDto.fromJson(Map<String, dynamic> json) => _$PoapPolicyNodeDtoFromJson(json);
}

@freezed
class PoapPolicyErrorDto with _$PoapPolicyErrorDto {
  const factory PoapPolicyErrorDto({
    String? message,
    String? path,
  }) = _PoapPolicyErrorDto;

  factory PoapPolicyErrorDto.fromJson(Map<String, dynamic> json) => _$PoapPolicyErrorDtoFromJson(json);
}

@freezed
class PoapPolicyResultDto with _$PoapPolicyResultDto {
  factory PoapPolicyResultDto({
    bool? boolean,
    PoapPolicyNodeDto? node,
    @JsonKey(defaultValue: <PoapPolicyErrorDto>[]) List<PoapPolicyErrorDto>? errors,
  }) = _PoapPolicyResultDto;

  factory PoapPolicyResultDto.fromJson(Map<String, dynamic> json) => _$PoapPolicyResultDtoFromJson(json);
}

@freezed
class PoapPolicyDto with _$PoapPolicyDto {
  factory PoapPolicyDto({
    @JsonKey(name: '_id') String? id,
    String? network,
    String? address,
    PoapPolicyNodeDto? node,
    PoapPolicyResultDto? result,
  }) = _PoapPolicyDto;

  factory PoapPolicyDto.fromJson(Map<String, dynamic> json) => _$PoapPolicyDtoFromJson(json);
}
