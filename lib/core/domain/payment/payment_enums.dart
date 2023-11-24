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

enum SupportedPaymentNetwork {
  @JsonValue("5")
  ethereumGoerli(value: "5"),

  @JsonValue("80001")
  polygonMumbai(value: "80001"),

  @JsonValue("1")
  ethereum(value: "1"),

  @JsonValue("137")
  polygon(value: "137");

  final String value;

  const SupportedPaymentNetwork({
    required this.value,
  });
}

enum Currency {
  USD,
  AED,
  AFN,
  ALL,
  AMD,
  ANG,
  AOA,
  ARS,
  AUD,
  AWG,
  AZN,
  BAM,
  BBD,
  BDT,
  BGN,
  BIF,
  BMD,
  BND,
  BOB,
  BRL,
  BSD,
  BWP,
  BYN,
  BZD,
  CAD,
  CDF,
  CHF,
  CLP,
  CNY,
  COP,
  CRC,
  CVE,
  CZK,
  DJF,
  DKK,
  DOP,
  DZD,
  EGP,
  ETB,
  EUR,
  FJD,
  FKP,
  GBP,
  GEL,
  GIP,
  GMD,
  GNF,
  GTQ,
  GYD,
  HKD,
  HNL,
  HTG,
  HUF,
  IDR,
  ILS,
  INR,
  ISK,
  JMD,
  KES,
  KGS,
  KHR,
  KMF,
  KRW,
  KYD,
  KZT,
  LAK,
  LBP,
  LKR,
  LRD,
  LSL,
  MAD,
  MDL,
  MGA,
  MKD,
  MMK,
  MNT,
  MOP,
  MUR,
  MVR,
  MWK,
  MXN,
  MYR,
  MZN,
  NAD,
  NGN,
  NIO,
  NOK,
  NPR,
  NZD,
  PAB,
  PEN,
  PGK,
  PHP,
  PKR,
  PLN,
  PYG,
  QAR,
  RON,
  RSD,
  RUB,
  RWF,
  SAR,
  SBD,
  SCR,
  SEK,
  SGD,
  SHP,
  SLE,
  SOS,
  SRD,
  STD,
  SZL,
  THB,
  TJS,
  TOP,
  TRY,
  TTD,
  TWD,
  TZS,
  UAH,
  UYU,
  UZS,
  WST,
  XCD,
  YER,
  ZAR,
  ZMW,
  JPY,
  UGX,
  VND,
  VUV,
  XAF,
  XOF,
  XPF,
  BHD,
  JOD,
  KWD,
  OMR,
  TND,
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
  D2COI,
  @JsonValue('BLUE')
  BLUE,
}
