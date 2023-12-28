import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_stripe_onramp_session_input.g.dart';
part 'create_stripe_onramp_session_input.freezed.dart';

@freezed
class CreateStripeOnrampSessionInput with _$CreateStripeOnrampSessionInput {
  factory CreateStripeOnrampSessionInput({
    @JsonKey(name: "destination_amount") double? destinationAmount,
    @JsonKey(name: "destination_currency") String? destinationCurrency,
    @JsonKey(name: "destination_network") String? destinationNetwork,
    @JsonKey(name: "source_currency") String? sourceCurrency,
    @JsonKey(name: "wallet_address") String? walletAddress,
  }) = _CreateStripeOnrampSessionInput;

  factory CreateStripeOnrampSessionInput.fromJson(Map<String, dynamic> json) =>
      _$CreateStripeOnrampSessionInputFromJson(json);
}
