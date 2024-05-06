import 'package:app/core/data/user/dtos/user_service_offer_dto/user_service_offer_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_service_offer.freezed.dart';
part 'user_service_offer.g.dart';

@freezed
class UserServiceOffer with _$UserServiceOffer {
  const UserServiceOffer._();

  factory UserServiceOffer({
    String? id,
    String? title,
  }) = _UserServiceOffer;

  factory UserServiceOffer.fromDto(UserServiceOfferDto dto) => UserServiceOffer(
        id: dto.id,
        title: dto.title,
      );

  factory UserServiceOffer.fromJson(Map<String, dynamic> json) =>
      _$UserServiceOfferFromJson(json);
}
