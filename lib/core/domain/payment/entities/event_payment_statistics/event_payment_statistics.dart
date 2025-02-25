import 'package:app/core/data/payment/dtos/event_payment_statistics_dto/event_payment_statistics_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_payment_statistics.freezed.dart';
part 'event_payment_statistics.g.dart';

@freezed
class EventPaymentStatistics with _$EventPaymentStatistics {
  factory EventPaymentStatistics({
    int? totalPayments,
    PaymentStatistics? stripePayments,
    CryptoPaymentStatistics? cryptoPayments,
  }) = _EventPaymentStatistics;

  factory EventPaymentStatistics.fromDto(EventPaymentStatisticsDto dto) =>
      EventPaymentStatistics(
        totalPayments: dto.totalPayments,
        stripePayments: dto.stripePayments != null
            ? PaymentStatistics.fromDto(dto.stripePayments!)
            : null,
        cryptoPayments: dto.cryptoPayments != null
            ? CryptoPaymentStatistics.fromDto(dto.cryptoPayments!)
            : null,
      );

  factory EventPaymentStatistics.fromJson(Map<String, dynamic> json) =>
      _$EventPaymentStatisticsFromJson(json);
}

@freezed
class PaymentStatistics with _$PaymentStatistics {
  factory PaymentStatistics({
    int? count,
    List<PaymentRevenue>? revenue,
  }) = _PaymentStatistics;

  factory PaymentStatistics.fromDto(PaymentStatisticsDto dto) =>
      PaymentStatistics(
        count: dto.count,
        revenue: dto.revenue?.map((e) => PaymentRevenue.fromDto(e)).toList(),
      );

  factory PaymentStatistics.fromJson(Map<String, dynamic> json) =>
      _$PaymentStatisticsFromJson(json);
}

@freezed
class PaymentRevenue with _$PaymentRevenue {
  factory PaymentRevenue({
    String? currency,
    String? formattedTotalAmount,
  }) = _PaymentRevenue;

  factory PaymentRevenue.fromDto(PaymentRevenueDto dto) => PaymentRevenue(
        currency: dto.currency,
        formattedTotalAmount: dto.formattedTotalAmount,
      );

  factory PaymentRevenue.fromJson(Map<String, dynamic> json) =>
      _$PaymentRevenueFromJson(json);
}

@freezed
class CryptoPaymentStatistics with _$CryptoPaymentStatistics {
  factory CryptoPaymentStatistics({
    int? count,
    List<PaymentRevenue>? revenue,
    List<CryptoPaymentNetworkStatistics>? networks,
  }) = _CryptoPaymentStatistics;

  factory CryptoPaymentStatistics.fromDto(CryptoPaymentStatisticsDto dto) =>
      CryptoPaymentStatistics(
        count: dto.count,
        revenue: dto.revenue?.map((e) => PaymentRevenue.fromDto(e)).toList(),
        networks: dto.networks
            ?.map((e) => CryptoPaymentNetworkStatistics.fromDto(e))
            .toList(),
      );

  factory CryptoPaymentStatistics.fromJson(Map<String, dynamic> json) =>
      _$CryptoPaymentStatisticsFromJson(json);
}

@freezed
class CryptoPaymentNetworkStatistics with _$CryptoPaymentNetworkStatistics {
  factory CryptoPaymentNetworkStatistics({
    String? chainId,
    int? count,
  }) = _CryptoPaymentNetworkStatistics;

  factory CryptoPaymentNetworkStatistics.fromDto(
    CryptoPaymentNetworkStatisticsDto dto,
  ) =>
      CryptoPaymentNetworkStatistics(
        chainId: dto.chainId,
        count: dto.count,
      );

  factory CryptoPaymentNetworkStatistics.fromJson(Map<String, dynamic> json) =>
      _$CryptoPaymentNetworkStatisticsFromJson(json);
}
