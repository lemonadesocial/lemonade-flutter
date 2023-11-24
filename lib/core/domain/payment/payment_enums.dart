import 'package:json_annotation/json_annotation.dart';
import 'package:app/core/constants/web3/chains.dart';

enum PaymentProvider {
  @JsonValue('stripe')
  stripe,
  @JsonValue('safe')
  safe
}

enum PaymentAccountType {
  @JsonValue('ethereum')
  ethereum,
  @JsonValue('digital')
  digital
}

enum PaymentState {
  @JsonValue('created')
  created,
  @JsonValue('failed')
  failed,
  @JsonValue('succeeded')
  succeeded,
  @JsonValue('initialized')
  initialized
}

enum PaymentCardBrand { visa, mastercard }
