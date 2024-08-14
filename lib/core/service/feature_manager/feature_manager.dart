import 'package:app/core/domain/event/entities/event_user_role.dart';
import 'package:app/core/service/feature_manager/feature_visibility_strategy.dart';
import 'package:app/graphql/backend/schema.graphql.dart';

class FeatureManager {
  final FeatureVisibilityStrategy strategy;

  FeatureManager(this.strategy);

  bool canShowFeature({
    required EventUserRole? eventUserRole,
    required List<Enum$FeatureCode> featureCodes,
  }) {
    return strategy.canShowFeature(
      eventUserRole: eventUserRole,
      featureCodes: featureCodes,
    );
  }
}
