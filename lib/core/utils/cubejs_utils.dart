import 'package:app/core/domain/cubejs/entities/cube_payment/cube_payment.dart';

class CubeJsUtils {
  static int calculateTotalTicketSold(List<CubePaymentMember> payments) {
    return payments.fold(
      0,
      (previousValue, element) => previousValue + (element.count ?? 0),
    );
  }

  static BigInt calculateTotalAmount(List<CubePaymentMember> payments) {
    return payments.fold(
      BigInt.zero,
      (previousValue, element) =>
          previousValue +
          (BigInt.tryParse(element.totalAmount ?? '') ?? BigInt.zero),
    );
  }

  static Map<String, Map<String, List<CubePaymentMember>>>
      groupPaymentsByTicketTypeAndCurrency(List<CubePaymentMember> payments) {
    Map<String, Map<String, List<CubePaymentMember>>> result = {};

    for (var payment in payments) {
      final ticketType = payment.ticketType;
      final currency = payment.currency as String;

      // Initialize the outer map if not exists
      result[ticketType ?? ''] ??= {};

      // Initialize the inner map if not exists
      result[ticketType]?[currency] ??= [];

      // Add the payment to the inner list
      result[ticketType]?[currency]?.add(payment);
    }

    return result;
  }

  static Map<String, Map<String, List<CubePaymentMember>>>
      groupPaymentsByPaymentKindAndCurrency(List<CubePaymentMember> payments) {
    Map<String, Map<String, List<CubePaymentMember>>> result = {};

    for (var payment in payments) {
      final paymentKind = payment.kind;
      final currency = payment.currency as String;

      // Initialize the outer map if not exists
      result[paymentKind ?? ''] ??= {};

      // Initialize the inner map if not exists
      result[paymentKind]?[currency] ??= [];

      // Add the payment to the inner list
      result[paymentKind]?[currency]?.add(payment);
    }

    return result;
  }
}
