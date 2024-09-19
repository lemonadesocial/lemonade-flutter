import 'package:app/core/data/payment/dtos/stripe_connected_account_dto/stripe_connected_account_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stripe_connected_account.freezed.dart';
part 'stripe_connected_account.g.dart';

@freezed
class StripeConnectedAccount with _$StripeConnectedAccount {
  const StripeConnectedAccount._();

  factory StripeConnectedAccount({
    String? accountId,
    bool? connected,
  }) = _StripeConnectedAccount;

  factory StripeConnectedAccount.fromDto(StripeConnectedAccountDto dto) =>
      StripeConnectedAccount(
        accountId: dto.accountId,
        connected: dto.connected,
      );

  factory StripeConnectedAccount.fromJson(Map<String, dynamic> json) =>
      _$StripeConnectedAccountFromJson(json);
}
