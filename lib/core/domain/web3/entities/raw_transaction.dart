import 'package:freezed_annotation/freezed_annotation.dart';

part 'raw_transaction.freezed.dart';
part 'raw_transaction.g.dart';

@freezed
class RawTransaction with _$RawTransaction {
  factory RawTransaction({
    String? to,
    String? value,
    String? data,
  }) = _RawTransaction;

  factory RawTransaction.fromJson(Map<String, dynamic> json) =>
      _$RawTransactionFromJson(json);
}
