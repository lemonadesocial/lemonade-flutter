import 'package:app/core/domain/lens/entities/lens_account.dart';
import 'package:app/core/domain/lens/entities/lens_auth.dart';
import 'package:app/core/domain/lens/entities/lens_create_account.dart';
import 'package:app/core/domain/lens/entities/lens_switch_account.dart';
import 'package:app/core/domain/lens/entities/lens_transaction.dart';
import 'package:app/core/domain/lens/lens_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/lens/auth/mutation/authenticate.graphql.dart';
import 'package:app/graphql/lens/auth/mutation/authentication_challenge.graphql.dart';
import 'package:app/graphql/lens/auth/query/accounts_available.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:app/graphql/lens/account/mutation/lens_switch_account.graphql.dart';
import 'package:app/graphql/lens/transaction/query/lens_transaction_status.graphql.dart';
import 'package:app/graphql/lens/account/mutation/lens_create_account.graphql.dart';
import 'package:app/graphql/lens/account/query/lens_get_account.graphql.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LensRepository)
class LensRepositoryImpl implements LensRepository {
  final _client = getIt<LensGQL>().client;

  @override
  Future<Either<Failure, List<LensAccount>>> getAvailableAccounts({
    required Variables$Query$LensAccountsAvailable input,
  }) async {
    final result = await _client.query$LensAccountsAvailable(
      Options$Query$LensAccountsAvailable(
        variables: input,
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException || result.parsedData?.accountsAvailable == null) {
      return Left(Failure());
    }

    final rawAccounts = result.parsedData!.accountsAvailable.items
        .map(
          (item) => item.when(
            accountOwned: (accountOwned) => accountOwned.account,
            accountManaged: (accountManaged) => null,
            orElse: () => null,
          ),
        )
        .where((item) => item != null);

    return Right(
      rawAccounts
          .map(
            (e) => LensAccount.fromJson(e!.toJson()),
          )
          .toList(),
    );
  }

  @override
  Future<Either<Failure, LensAccount>> getAccount({
    required Variables$Query$Account input,
  }) async {
    final result =
        await _client.query$Account(Options$Query$Account(variables: input));
    if (result.hasException || result.parsedData?.account == null) {
      return Left(Failure.withGqlException(result.exception));
    }

    return Right(
      LensAccount.fromJson(
        result.parsedData!.account!.toJson(),
      ),
    );
  }

  @override
  Future<Either<Failure, LensAuthenticationResult>> authenticate({
    required Variables$Mutation$LensAuthenticate input,
  }) async {
    final result = await _client.mutate$LensAuthenticate(
      Options$Mutation$LensAuthenticate(
        variables: input,
      ),
    );
    if (result.hasException || result.parsedData?.authenticate == null) {
      return Left(Failure());
    }

    return Right(
      result.parsedData!.authenticate.when(
        orElse: () => const LensAuthenticationResult.wrongSignerError(
          reason: 'Unknown error',
        ),
        authenticationTokens: (tokens) => LensAuthenticationResult.tokens(
          accessToken: tokens.accessToken,
          refreshToken: tokens.refreshToken,
        ),
        wrongSignerError: (error) => LensAuthenticationResult.wrongSignerError(
          reason: error.reason,
        ),
        expiredChallengeError: (error) =>
            LensAuthenticationResult.expiredChallengeError(
          reason: error.reason,
        ),
        forbiddenError: (error) => LensAuthenticationResult.forbiddenError(
          reason: error.reason,
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, LensAuthenticationChallenge>> challenge({
    required Variables$Mutation$LensAuthenticationChallenge input,
  }) async {
    final result = await _client.mutate$LensAuthenticationChallenge(
      Options$Mutation$LensAuthenticationChallenge(
        variables: input,
      ),
    );
    if (result.hasException || result.parsedData?.challenge == null) {
      return Left(Failure());
    }

    return Right(
      LensAuthenticationChallenge(
        id: result.parsedData!.challenge.id,
        text: result.parsedData!.challenge.text,
      ),
    );
  }

  @override
  Future<Either<Failure, LensCreateAccountWithUsernameResult>>
      createAccountWithUsername({
    required Variables$Mutation$LensCreateAccountWithUsername input,
  }) async {
    final response = await _client.mutate$LensCreateAccountWithUsername(
      Options$Mutation$LensCreateAccountWithUsername(
        variables: input,
      ),
    );
    if (response.hasException ||
        response.parsedData?.createAccountWithUsername == null) {
      return Left(Failure.withGqlException(response.exception!));
    }
    final result = response.parsedData!.createAccountWithUsername.maybeWhen(
      orElse: () => null,
      createAccountResponse: (data) =>
          LensCreateAccountWithUsernameResult.createAccountResponse(
        hash: data.hash,
      ),
      usernameTaken: (data) =>
          LensCreateAccountWithUsernameResult.usernameTaken(
        ownedBy: data.ownedBy,
        reason: data.reason,
      ),
      namespaceOperationValidationFailed: (data) =>
          LensCreateAccountWithUsernameResult
              .namespaceOperationValidationFailed(reason: data.reason),
      transactionWillFail: (data) =>
          LensCreateAccountWithUsernameResult.transactionWillFail(
        reason: data.reason,
      ),
      selfFundedTransactionRequest: (data) =>
          LensCreateAccountWithUsernameResult.selfFundedTransactionRequest(
        reason: data.reason,
      ),
      sponsoredTransactionRequest: (data) =>
          LensCreateAccountWithUsernameResult.sponsoredTransactionRequest(
        reason: data.reason,
      ),
    );

    if (result == null) {
      return Left(Failure(message: 'Unknown error'));
    }

    return Right(result);
  }

  @override
  Future<Either<Failure, LensSwitchAccountResult>> switchAccount({
    required Variables$Mutation$SwitchAccount input,
  }) async {
    final response = await _client
        .mutate$SwitchAccount(Options$Mutation$SwitchAccount(variables: input));
    if (response.hasException || response.parsedData?.switchAccount == null) {
      return Left(Failure.withGqlException(response.exception!));
    }
    final result = response.parsedData!.switchAccount.maybeWhen(
      orElse: () => null,
      authenticationTokens: (data) => LensSwitchAccountResult.tokens(
        accessToken: data.accessToken,
        refreshToken: data.refreshToken,
      ),
      forbiddenError: (data) =>
          LensSwitchAccountResult.forbiddenError(reason: data.reason),
    );

    if (result == null) {
      return Left(Failure(message: 'Unknown error'));
    }

    return Right(result);
  }

  @override
  Future<Either<Failure, LensTransactionStatusResult>> transactionStatus({
    required Variables$Query$TransactionStatus input,
  }) async {
    final response = await _client.query$TransactionStatus(
      Options$Query$TransactionStatus(
        variables: input,
      ),
    );
    if (response.hasException ||
        response.parsedData?.transactionStatus == null) {
      return Left(Failure.withGqlException(response.exception!));
    }
    final result = response.parsedData!.transactionStatus.maybeWhen(
      orElse: () => null,
      pendingTransactionStatus: (data) =>
          const LensTransactionStatusResult.pendingTransactionStatus(),
      finishedTransactionStatus: (data) =>
          LensTransactionStatusResult.finishedTransactionStatus(
        blockTimestamp: data.blockTimestamp,
      ),
      failedTransactionStatus: (data) =>
          LensTransactionStatusResult.failedTransactionStatus(
        reason: data.reason,
        blockTimestamp: data.blockTimestamp,
      ),
      notIndexedYetStatus: (data) =>
          LensTransactionStatusResult.notIndexedYetStatus(
        reason: data.reason,
      ),
    );

    if (result == null) {
      return Left(Failure(message: 'Unknown error'));
    }

    return Right(result);
  }
}
