import 'package:app/core/data/badge/dtos/badge_dtos.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/user/entities/user.dart';

class Badge {
  Badge({
    this.id,
    this.city,
    this.country,
    this.claimable,
    this.distance,
    this.list,
    this.listExpanded,
    this.contract,
    this.network,
  });

  factory Badge.fromDto(BadgeDto dto) => Badge(
        id: dto.id,
        city: dto.city,
        country: dto.country,
        claimable: dto.claimable,
        distance: dto.distance,
        list: dto.list,
        listExpanded: dto.listExpanded != null ? BadgeList.fromDto(dto.listExpanded!) : null,
        contract: dto.contract,
        network: dto.network,
      );
  final String? id;
  final String? city;
  final String? country;
  final bool? claimable;
  final double? distance;
  final String? list;
  final BadgeList? listExpanded;
  final String? contract;
  final String? network;
}

class BadgeList {
  BadgeList({
    this.id,
    this.imageUrl,
    this.title,
    this.user,
    this.userExpanded,
  });

  factory BadgeList.empty() => BadgeList(
    id: '',
  );

  factory BadgeList.fromDto(BadgeListDto dto) => BadgeList(
        id: dto.id,
        imageUrl: dto.imageUrl,
        title: dto.title,
        user: dto.user,
        userExpanded: dto.userExpanded != null ? User.fromDto(dto.userExpanded!) : null,
      );
  final String? id;
  final String? imageUrl;
  final String? title;
  final String? user;
  final User? userExpanded;
}

class BadgeCity {
  BadgeCity({
    this.city,
    this.country,
  });

  factory BadgeCity.fromDto(BadgeCityDto dto) => BadgeCity(
        city: dto.city,
        country: dto.country,
      );
  final String? city;
  final String? country;
}

class BadgeLocation {
  BadgeLocation({
    this.badgeCity,
    this.isMyLocation = false,
    this.geoPoint,
  });

  factory BadgeLocation.city({
    required BadgeCity city,
  }) =>
      BadgeLocation(
        badgeCity: city,
      );

  factory BadgeLocation.myLocation({
    required GeoPoint geoPoint,
  }) =>
      BadgeLocation(
        isMyLocation: true,
        geoPoint: geoPoint,
      );

  final BadgeCity? badgeCity;
  final bool isMyLocation;
  final GeoPoint? geoPoint;

  @override
  bool operator ==(Object other) {
    if(identical(this, other)) return true;

    return other is BadgeLocation &&
        other.badgeCity?.city == badgeCity?.city &&
        other.badgeCity?.country == badgeCity?.country &&
        other.isMyLocation == isMyLocation &&
        other.geoPoint?.lat == geoPoint?.lat &&
        other.geoPoint?.lng == geoPoint?.lng;
  }

  @override
  int get hashCode => badgeCity.hashCode ^ isMyLocation.hashCode ^ geoPoint.hashCode;
}
