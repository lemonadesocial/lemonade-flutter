import 'package:app/core/data/badge/dtos/badge_dtos.dart';
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
        country: dto.city,
      );
  final String? city;
  final String? country;
}
