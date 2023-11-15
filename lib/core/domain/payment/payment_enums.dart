import 'package:json_annotation/json_annotation.dart';

enum Currency {
  @JsonValue('AUD')
  AUD,
  @JsonValue('CAD')
  CAD,
  @JsonValue('EUR')
  EUR,
  @JsonValue('GBP')
  GBP,
  @JsonValue('INR')
  INR,
  @JsonValue('USD')
  USD,
  @JsonValue('CRC')
  CRC,
  // Blockchain Currency
  @JsonValue('USDT')
  USDT,
  @JsonValue('USDC')
  USDC,
  @JsonValue('ETH')
  ETH,
  @JsonValue('MATIC')
  MATIC,
  @JsonValue('TCOI')
  TCOI,
  @JsonValue('D2COI')
  D2COI
}

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
