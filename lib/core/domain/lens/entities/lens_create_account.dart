import 'package:freezed_annotation/freezed_annotation.dart';

part 'lens_create_account.freezed.dart';
part 'lens_create_account.g.dart';

@freezed
sealed class LensCreateAccountWithUsernameResult
    with _$LensCreateAccountWithUsernameResult {
  const factory LensCreateAccountWithUsernameResult.createAccountResponse({
    required String hash,
  }) = CreateAccountResponse;

  const factory LensCreateAccountWithUsernameResult.usernameTaken({
    required String ownedBy,
    required String reason,
  }) = UsernameTaken;

  const factory LensCreateAccountWithUsernameResult.namespaceOperationValidationFailed({
    required String reason,
  }) = NamespaceOperationValidationFailed;

  const factory LensCreateAccountWithUsernameResult.transactionWillFail({
    required String reason,
  }) = TransactionWillFail;

  const factory LensCreateAccountWithUsernameResult.selfFundedTransactionRequest({
    required String reason,
  }) = SelfFundedTransactionRequest;

  const factory LensCreateAccountWithUsernameResult.sponsoredTransactionRequest({
    required String reason,
  }) = SponsoredTransactionRequest;

  factory LensCreateAccountWithUsernameResult.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$LensCreateAccountWithUsernameResultFromJson(json);
}
