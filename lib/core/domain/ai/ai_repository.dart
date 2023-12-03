import 'package:app/core/domain/ai/ai_entities.dart';
import 'package:app/core/domain/ai/input/get_ai_config_input/get_ai_config_input.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AIRepository {
  Future<Either<Failure, Config>> getAIConfig({
    required GetAIConfigInput input,
  });
}
