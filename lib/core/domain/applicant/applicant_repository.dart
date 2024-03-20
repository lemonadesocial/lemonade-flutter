import 'package:app/core/domain/applicant/entities/applicant.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ApplicantRepository {
  Future<Either<Failure, Applicant>> getApplicantInfo({
    required String userId,
    required String eventId,
  });
}
