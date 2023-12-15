import 'package:app/core/data/common/dtos/common_dtos.dart';
import 'package:app/core/domain/user/entities/user.dart';

class Address {
  Address({
    this.id,
    this.street1,
    this.street2,
    this.city,
    this.region,
    this.postal,
    this.country,
    this.title,
    this.latitude,
    this.longitude,
    this.recipientName,
  });
  final String? id;
  final String? street1;
  final String? street2;
  final String? city;
  final String? region;
  final String? postal;
  final String? country;
  final String? title;
  final double? latitude;
  final double? longitude;
  final String? recipientName;

  static Address fromDto(AddressDto dto) {
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
}

class DbFile {
  DbFile({
    this.id,
    this.url,
    this.owner,
    this.bucket,
    this.ownerExpanded,
    this.stamp,
    this.likes,
    this.liked,
    this.description,
    this.key,
    this.type,
  });
  final String? id;
  final String? url;
  final String? owner;
  final String? bucket;
  final User? ownerExpanded;
  final String? stamp;
  final int? likes;
  final bool? liked;
  final String? description;
  final String? key;
  final String? type;

  static DbFile fromDto(DbFileDto dto) {
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
}

class GeoPoint {
  GeoPoint({
    required this.lat,
    required this.lng,
  });
  final double lat;
  final double lng;
}
