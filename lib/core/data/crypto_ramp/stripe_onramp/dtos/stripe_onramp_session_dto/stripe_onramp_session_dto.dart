import 'package:freezed_annotation/freezed_annotation.dart';

part 'stripe_onramp_session_dto.g.dart';
part 'stripe_onramp_session_dto.freezed.dart';

@freezed
class StripeOnrampSessionDto with _$StripeOnrampSessionDto {
  factory StripeOnrampSessionDto({
    String? id,
    bool? livemode,
    String? status,
    @JsonKey(name: 'client_secret') String? clientSecret,
    @JsonKey(name: 'publishable_key') String? publishableKey,
  }) = _StripeOnrampSessionDto;

  factory StripeOnrampSessionDto.fromJson(Map<String, dynamic> json) =>
      _$StripeOnrampSessionDtoFromJson(json);
}
