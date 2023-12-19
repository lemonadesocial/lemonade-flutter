import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_init_safe_transaction_input.freezed.dart';
part 'get_init_safe_transaction_input.g.dart';

@freezed
class GetInitSafeTransactionInput with _$GetInitSafeTransactionInput {
  factory GetInitSafeTransactionInput({
    required List<String> owners,
    required int threshold,
    required String network,
  }) = _GetInitSafeTransactionInput;

  factory GetInitSafeTransactionInput.fromJson(Map<String, dynamic> json) =>
      _$GetInitSafeTransactionInputFromJson(json);
}
