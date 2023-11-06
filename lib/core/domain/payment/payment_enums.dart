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
  MATIC
}
