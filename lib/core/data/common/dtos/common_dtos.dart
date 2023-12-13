import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_dtos.freezed.dart';
part 'common_dtos.g.dart';

@freezed
class AddressDto with _$AddressDto {
  @JsonSerializable(explicitToJson: true)
  const factory AddressDto({
    @JsonKey(name: 'street_1') String? street1,
    @JsonKey(name: 'street_2') String? street2,
    String? city,
    String? region,
    String? postal,
    String? country,
    String? title,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'recipient_name', includeIfNull: false)
    String? recipientName,
  }) = _AddressDto;

  factory AddressDto.fromJson(Map<String, dynamic> json) =>
      _$AddressDtoFromJson(json);
}

@freezed
class DbFileDto with _$DbFileDto {
  @JsonSerializable(explicitToJson: true)
  const factory DbFileDto({
    @JsonKey(name: '_id', includeIfNull: false) String? id,
    String? url,
    String? owner,
    String? bucket,
    UserDto? ownerExpanded,
    String? stamp,
    int? likes,
    bool? liked,
    String? description,
    String? key,
    String? type,
  }) = _DbFileDto;

  factory DbFileDto.fromJson(Map<String, dynamic> json) =>
      _$DbFileDtoFromJson(json);
}
