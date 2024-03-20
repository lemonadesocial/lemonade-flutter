import 'package:app/core/domain/applicant/applicant_repository.dart';
import 'package:app/core/domain/applicant/entities/applicant.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:app/graphql/backend/applicant/query/get_applicants_info.graphql.dart';

@LazySingleton(as: ApplicantRepository)
class ApplicantRepositoryImpl implements ApplicantRepository {
  final _gqlClient = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, Applicant>> getApplicantInfo({
    required List<String> usersId,
    required String eventId,
  }) async {
    final result = await _gqlClient.query$GetApplicantsInfo(
      Options$Query$GetApplicantsInfo(
        variables: Variables$Query$GetApplicantsInfo(
          users: usersId,
          event: eventId,
        ),
      ),
    );

    if (result.hasException) {
      return Left(Failure.withGqlException(result.exception));
    }
    if (result.parsedData!.getApplicantsInfo.isEmpty) {
      return Left(Failure());
    }
    return Right(
      Applicant.fromJson(
        result.parsedData!.getApplicantsInfo.first.toJson(),
      ),
    );
  }
}
