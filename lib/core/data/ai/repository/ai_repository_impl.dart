import 'package:app/core/data/ai/dtos/ai_dtos.dart';
import 'package:app/core/data/ai/query/ai_query.dart';
import 'package:app/core/domain/ai/ai_entities.dart';
import 'package:app/core/domain/ai/ai_repository.dart';
import 'package:app/core/domain/ai/input/get_ai_config_input/get_ai_config_input.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AIRepository)
class AIRepositoryImpl implements AIRepository {
  final client = getIt<AIGQL>().client;

  @override
  Future<Either<Failure, Config>> getAIConfig({
    required GetAIConfigInput input,
  }) async {
    final result = await client.query<Config>(
      QueryOptions(
        document: getConfigDetail,
        variables: input.toJson(),
        fetchPolicy: FetchPolicy.networkOnly,
        parserFn: (data) => Config.fromDto(
          ConfigDto.fromJson(data['config']),
        ),
      ),
    );
    if (result.hasException) return Left(Failure());
    return Right(result.parsedData!);
  }
}
