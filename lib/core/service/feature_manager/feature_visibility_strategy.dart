import 'package:app/core/domain/event/entities/event_user_role.dart';
import 'package:app/graphql/backend/schema.graphql.dart';

abstract class FeatureVisibilityStrategy {
  bool shouldShowFeature({
    Enum$FeatureCode featureCode,
    EventUserRole? eventUserRole,
  });
}
