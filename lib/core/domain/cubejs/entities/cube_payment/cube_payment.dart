import 'package:freezed_annotation/freezed_annotation.dart';

part 'cube_payment.freezed.dart';
part 'cube_payment.g.dart';

@freezed
class CubePaymentMember with _$CubePaymentMember {
  factory CubePaymentMember({
    @JsonKey(name: "Tickets.type") String? ticketType,
    @JsonKey(name: 'Payments.count') int? count,
    @JsonKey(name: 'Payments.totalAmount') String? totalAmount,
    @JsonKey(name: 'Payments.stampsSucceeded') DateTime? stampsSucceeded,
    @JsonKey(name: 'Payments.amount') String? amount,
    @JsonKey(name: 'Payments.currency') String? currency,
    @JsonKey(name: 'Payments.kind') String? kind,
  }) = _CubePaymentMember;

  factory CubePaymentMember.fromJson(Map<String, dynamic> json) =>
      _$CubePaymentMemberFromJson(json);
}
