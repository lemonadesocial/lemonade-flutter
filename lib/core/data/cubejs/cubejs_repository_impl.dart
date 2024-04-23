import 'package:app/core/domain/cubejs/cubejs_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/backend/tokens/mutation/generateCubejsToken.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CubeJsRepository)
class CubeJsRepositoryImpl implements CubeJsRepository {
  final _client = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, String>> generateCubejsToken({
    required String eventId,
  }) async {
    final result = await _client.mutate$GenerateCubejsToken(
      Options$Mutation$GenerateCubejsToken(
        variables: Variables$Mutation$GenerateCubejsToken(
          events: [
            eventId,
          ],
        ),
      ),
    );
    if (result.hasException || result.parsedData?.generateCubejsToken == null) {
      return Left(Failure());
    }
    return Right(result.parsedData!.generateCubejsToken);
  }
}
