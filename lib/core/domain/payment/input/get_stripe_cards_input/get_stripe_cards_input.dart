import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_stripe_cards_input.freezed.dart';
part 'get_stripe_cards_input.g.dart';

@freezed
class GetStripeCardsInput with _$GetStripeCardsInput {
  factory GetStripeCardsInput({
    required int limit,
    required int skip,
    required String paymentAccount,
  }) = _GetStripeCardsInput;

  factory GetStripeCardsInput.fromJson(Map<String, dynamic> json) =>
      _$GetStripeCardsInputFromJson(json);
}
