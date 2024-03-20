import 'package:app/core/domain/applicant/entities/applicant.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ApplicantRepository {
  Future<Either<Failure, Applicant>> getApplicantInfo({
    required List<String> usersId,
    required String eventId,
  });
}
