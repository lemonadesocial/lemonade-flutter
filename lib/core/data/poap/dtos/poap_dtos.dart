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