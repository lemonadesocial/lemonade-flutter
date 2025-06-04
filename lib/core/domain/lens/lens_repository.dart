import 'package:app/core/domain/lens/entities/lens_account.dart';
import 'package:app/core/domain/lens/entities/lens_auth.dart';
import 'package:app/core/domain/lens/entities/lens_create_account.dart';
import 'package:app/core/domain/lens/entities/lens_create_post.dart';
import 'package:app/core/domain/lens/entities/lens_create_username.dart';
import 'package:app/core/domain/lens/entities/lens_feed.dart';
import 'package:app/core/domain/lens/entities/lens_switch_account.dart';
import 'package:app/core/domain/lens/entities/lens_transaction.dart';
import 'package:app/core/failure.dart';
import 'package:app/graphql/lens/auth/mutation/authenticate.graphql.dart';
import 'package:app/graphql/lens/auth/mutation/authentication_challenge.graphql.dart';
import 'package:app/graphql/lens/auth/query/accounts_available.graphql.dart';
import 'package:app/graphql/lens/account/mutation/lens_switch_account.graphql.dart';
import 'package:app/graphql/lens/feed/mutation/lens_create_feed.graphql.dart';
import 'package:app/graphql/lens/feed/query/lens_get_feed.graphql.dart';
import 'package:app/graphql/lens/namespace/mutation/lens_create_username.graphql.dart';
import 'package:app/graphql/lens/post/mutation/lens_create_post.graphql.dart';
import 'package:app/graphql/lens/transaction/query/lens_transaction_status.graphql.dart';
import 'package:app/graphql/lens/account/mutation/lens_create_account.graphql.dart';
import 'package:app/graphql/lens/account/query/lens_get_account.graphql.dart';
import 'package:dartz/dartz.dart';

abstract class LensRepository {
  Future<Either<Failure, LensAuthenticationChallenge>> challenge({
    required Variables$Mutation$LensAuthenticationChallenge input,
  });

  Future<Either<Failure, LensAuthenticationResult>> authenticate({
    required Variables$Mutation$LensAuthenticate input,
  });

  Future<Either<Failure, List<LensAccount>>> getAvailableAccounts({
    required Variables$Query$LensAccountsAvailable input,
  });

  Future<Either<Failure, LensAccount>> getAccount({
    required Variables$Query$Account input,
  });

  Future<Either<Failure, LensCreateAccountWithUsernameResult>>
      createAccountWithUsername({
    required Variables$Mutation$LensCreateAccountWithUsername input,
  });

  Future<Either<Failure, LensSwitchAccountResult>> switchAccount({
    required Variables$Mutation$SwitchAccount input,
  });

  Future<Either<Failure, LensTransactionStatusResult>> transactionStatus({
    required Variables$Query$TransactionStatus input,
  });

  Future<Either<Failure, LensPostResult>> createPost({
    required Variables$Mutation$LensCreatePost input,
  });

  Future<Either<Failure, LensTransactionStatusResult>> createFeed({
    required Variables$Mutation$LensCreateFeed input,
  });

  Future<Either<Failure, LensFeed>> getFeed({
    required Variables$Query$LensGetFeed input,
  });

  Future<Either<Failure, LensCreateUsernameResult>> createUsername({
    required Variables$Mutation$LensCreateUsername input,
  });
}
