import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_payment_statistics_dto.freezed.dart';
part 'event_payment_statistics_dto.g.dart';

@freezed
class EventPaymentStatisticsDto with _$EventPaymentStatisticsDto {
  factory EventPaymentStatisticsDto({
    @JsonKey(name: 'total_payments') int? totalPayments,
    @JsonKey(name: 'stripe_payments') PaymentStatisticsDto? stripePayments,
    @JsonKey(name: 'crypto_payments')
    CryptoPaymentStatisticsDto? cryptoPayments,
  }) = _EventPaymentStatisticsDto;

  factory EventPaymentStatisticsDto.fromJson(Map<String, dynamic> json) =>
      _$EventPaymentStatisticsDtoFromJson(json);
}

@freezed
class PaymentStatisticsDto with _$PaymentStatisticsDto {
  factory PaymentStatisticsDto({
    int? count,
    List<PaymentRevenueDto>? revenue,
  }) = _PaymentStatisticsDto;

  factory PaymentStatisticsDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentStatisticsDtoFromJson(json);
}

@freezed
class PaymentRevenueDto with _$PaymentRevenueDto {
  factory PaymentRevenueDto({
    String? currency,
    @JsonKey(name: 'formatted_total_amount') String? formattedTotalAmount,
  }) = _PaymentRevenueDto;

  factory PaymentRevenueDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentRevenueDtoFromJson(json);
}

@freezed
class CryptoPaymentStatisticsDto with _$CryptoPaymentStatisticsDto {
  factory CryptoPaymentStatisticsDto({
    int? count,
    List<PaymentRevenueDto>? revenue,
    List<CryptoPaymentNetworkStatisticsDto>? networks,
  }) = _CryptoPaymentStatisticsDto;

  factory CryptoPaymentStatisticsDto.fromJson(Map<String, dynamic> json) =>
      _$CryptoPaymentStatisticsDtoFromJson(json);
}

@freezed
class CryptoPaymentNetworkStatisticsDto
    with _$CryptoPaymentNetworkStatisticsDto {
  factory CryptoPaymentNetworkStatisticsDto({
    @JsonKey(name: 'chain_id') String? chainId,
    int? count,
  }) = _CryptoPaymentNetworkStatisticsDto;

  factory CryptoPaymentNetworkStatisticsDto.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CryptoPaymentNetworkStatisticsDtoFromJson(json);
}
