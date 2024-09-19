import 'package:freezed_annotation/freezed_annotation.dart';

part 'stripe_connected_account_dto.freezed.dart';
part 'stripe_connected_account_dto.g.dart';

@freezed
class StripeConnectedAccountDto with _$StripeConnectedAccountDto {
  factory StripeConnectedAccountDto({
    @JsonKey(name: 'account_id') String? accountId,
    bool? connected,
  }) = _StripeConnectedAccountDto;

  factory StripeConnectedAccountDto.fromJson(Map<String, dynamic> json) =>
      _$StripeConnectedAccountDtoFromJson(json);
}
