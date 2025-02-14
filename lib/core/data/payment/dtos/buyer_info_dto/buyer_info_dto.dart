import 'package:freezed_annotation/freezed_annotation.dart';

part 'buyer_info_dto.freezed.dart';
part 'buyer_info_dto.g.dart';

@freezed
class BuyerInfoDto with _$BuyerInfoDto {
  factory BuyerInfoDto({
    String? name,
    String? email,
  }) = _BuyerInfoDto;

  factory BuyerInfoDto.fromJson(Map<String, dynamic> json) =>
      _$BuyerInfoDtoFromJson(json);
}
