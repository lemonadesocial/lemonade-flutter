import 'package:injectable/injectable.dart';
import 'package:app/core/domain/space/space_repository.dart';

@LazySingleton(as: SpaceRepository)
class SpaceRepositoryImpl implements SpaceRepository {}
