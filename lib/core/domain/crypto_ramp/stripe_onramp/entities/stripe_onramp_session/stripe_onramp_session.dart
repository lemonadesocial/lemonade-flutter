import 'package:app/core/data/crypto_ramp/stripe_onramp/dtos/stripe_onramp_session_dto/stripe_onramp_session_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stripe_onramp_session.freezed.dart';

@freezed
class StripeOnrampSession with _$StripeOnrampSession {
  StripeOnrampSession._();

  factory StripeOnrampSession({
    String? id,
    bool? livemode,
    String? status,
    String? clientSecret,
    String? publishableKey,
  }) = _StripeOnrampSession;

  factory StripeOnrampSession.fromDto(StripeOnrampSessionDto dto) =>
      StripeOnrampSession(
        id: dto.id,
        livemode: dto.livemode,
        status: dto.status,
        clientSecret: dto.clientSecret,
        publishableKey: dto.publishableKey,
      );
}
