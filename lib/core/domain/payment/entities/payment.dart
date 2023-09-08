import 'package:app/core/data/payment/dtos/payment_dtos.dart';
import 'package:app/core/domain/payment/payment_enums.dart';

class Payment {
  Payment({this.id, this.amount, this.currency});

  final String? id;
  final double? amount;
  final Currency? currency;

  factory Payment.fromDto(PaymentDto dto) => Payment(
        amount: dto.amount,
        id: dto.id,
        currency: dto.currency,
      );
}
