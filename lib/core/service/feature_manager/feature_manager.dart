import 'package:app/core/domain/event/entities/event_user_role.dart';
import 'package:app/core/service/feature_manager/feature_visibility_strategy.dart';
import 'package:app/graphql/backend/schema.graphql.dart';

class FeatureManager {
  final FeatureVisibilityStrategy strategy;

  FeatureManager(this.strategy);

  bool shouldShowFeature({
    required EventUserRole? eventUserRole,
    required Enum$FeatureCode featureCode,
  }) {
    return strategy.shouldShowFeature(
      eventUserRole: eventUserRole,
      featureCode: featureCode,
    );
  }
}
