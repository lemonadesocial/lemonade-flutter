import 'package:app/core/data/payment/dtos/buyer_info_dto/buyer_info_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'buyer_info.freezed.dart';
part 'buyer_info.g.dart';

@freezed
class BuyerInfo with _$BuyerInfo {
  factory BuyerInfo({
    String? name,
    String? email,
  }) = _BuyerInfo;

  factory BuyerInfo.fromDto(BuyerInfoDto dto) => BuyerInfo(
        name: dto.name,
        email: dto.email,
      );

  factory BuyerInfo.fromJson(Map<String, dynamic> json) =>
      _$BuyerInfoFromJson(json);
}
