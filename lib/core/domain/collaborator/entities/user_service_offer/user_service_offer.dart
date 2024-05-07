import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_service_offer.freezed.dart';
part 'user_service_offer.g.dart';

@freezed
class UserServiceOffer with _$UserServiceOffer {
  factory UserServiceOffer({
    String? id,
    String? title,
  }) = _UserServiceOffer;

  factory UserServiceOffer.fromJson(Map<String, dynamic> json) =>
      _$UserServiceOfferFromJson(json);
}
