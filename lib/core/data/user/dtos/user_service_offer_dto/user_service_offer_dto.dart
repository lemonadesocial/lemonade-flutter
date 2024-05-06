import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_service_offer_dto.freezed.dart';
part 'user_service_offer_dto.g.dart';

@freezed
class UserServiceOfferDto with _$UserServiceOfferDto {
  factory UserServiceOfferDto({
    @JsonKey(name: '_id') String? id,
    String? title,
  }) = _UserServiceOfferDto;

  factory UserServiceOfferDto.fromJson(Map<String, dynamic> json) =>
      _$UserServiceOfferDtoFromJson(json);
}
