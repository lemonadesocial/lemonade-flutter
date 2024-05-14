import 'package:app/core/data/common/dtos/common_dtos.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'common.freezed.dart';
part 'common.g.dart';

@freezed
class Address with _$Address {
  Address._();

  factory Address({
    String? id,
    String? street1,
    String? street2,
    String? city,
    String? region,
    String? postal,
    String? country,
    String? title,
    double? latitude,
    double? longitude,
    String? recipientName,
  }) = _Address;

  factory Address.fromDto(AddressDto dto) {
    return Address(
      id: dto.id,
      street1: dto.street1,
      street2: dto.street2,
      city: dto.city,
      region: dto.region,
      postal: dto.postal,
      country: dto.country,
      title: dto.title,
      latitude: dto.latitude,
      longitude: dto.longitude,
      recipientName: dto.recipientName,
    );
  }

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

@freezed
class DbFile with _$DbFile {
  factory DbFile({
    String? id,
    String? url,
    String? owner,
    String? bucket,
    User? ownerExpanded,
    String? stamp,
    int? likes,
    bool? liked,
    String? description,
    String? key,
    String? type,
  }) = _DbFile;

  factory DbFile.fromDto(DbFileDto dto) {
    return DbFile(
      id: dto.id,
      url: dto.url,
      owner: dto.owner,
      bucket: dto.bucket,
      ownerExpanded:
          dto.ownerExpanded != null ? User.fromDto(dto.ownerExpanded!) : null,
      stamp: dto.stamp,
      likes: dto.likes,
      liked: dto.liked,
      description: dto.description,
      key: dto.key,
      type: dto.type,
    );
  }

  factory DbFile.fromJson(Map<String, dynamic> json) => _$DbFileFromJson(json);
}

class GeoPoint {
  GeoPoint({
    required this.lat,
    required this.lng,
  });
  final double lat;
  final double lng;
}

@freezed
class Currency with _$Currency {
  factory Currency({
    String? code,
    double? decimals,
  }) = _Currency;

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);
}
