import 'package:app/core/domain/event/entities/event_user_role.dart';
import 'package:app/graphql/backend/schema.graphql.dart';

// Strategy for event only
abstract class EventFeatureVisibilityStrategy {
  bool canShowFeature({
    EventUserRole? eventUserRole,
    List<Enum$FeatureCode>? featureCodes,
  });
}
