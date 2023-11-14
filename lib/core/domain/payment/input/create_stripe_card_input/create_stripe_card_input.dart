import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_stripe_card_input.freezed.dart';
part 'create_stripe_card_input.g.dart';

@freezed
class CreateStripeCardInput with _$CreateStripeCardInput {
  factory CreateStripeCardInput({
    required String paymentAccount,
    required String paymentMethod,
  }) = _CreateStripeCardInput;

  factory CreateStripeCardInput.fromJson(Map<String, dynamic> json) =>
      _$CreateStripeCardInputFromJson(json);
}
