import 'package:app/core/data/report/mutations/report_mutation.dart';
import 'package:app/core/domain/report/input/report_input.dart';
import 'package:app/core/domain/report/report_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ReportRepository)
class ReportRepositoryImpl implements ReportRepository {
  final _client = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, bool>> reportEvent({
    required ReportInput input,
  }) async {
    final result = await _client.mutate(
      MutationOptions(
        document: reportEventMutation,
        variables: input.toJson(),
      ),
    );
    if (result.hasException) {
      return Left(Failure());
    }

    return const Right(true);
  }

  @override
  Future<Either<Failure, bool>> reportPost({
    required ReportInput input,
  }) async {
    final result = await _client.mutate(
      MutationOptions(
        document: reportPostMutation,
        variables: input.toJson(),
      ),
    );
    if (result.hasException) {
      return Left(Failure());
    }
    return const Right(true);
  }
}
