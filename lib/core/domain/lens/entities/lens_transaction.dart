import 'package:freezed_annotation/freezed_annotation.dart';

part 'lens_transaction.freezed.dart';
part 'lens_transaction.g.dart';

@freezed
sealed class LensTransactionStatusResult with _$LensTransactionStatusResult {
  const factory LensTransactionStatusResult.pendingTransactionStatus() =
      PendingTransactionStatus;

  const factory LensTransactionStatusResult.finishedTransactionStatus({
    required DateTime blockTimestamp,
  }) = FinishedTransactionStatus;

  const factory LensTransactionStatusResult.failedTransactionStatus({
    required String reason,
    required DateTime blockTimestamp,
  }) = FailedTransactionStatus;

  const factory LensTransactionStatusResult.notIndexedYetStatus({
    required String reason,
  }) = NotIndexedYetStatus;

  factory LensTransactionStatusResult.fromJson(Map<String, dynamic> json) =>
      _$LensTransactionStatusResultFromJson(json);
}
