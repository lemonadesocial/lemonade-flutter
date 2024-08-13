import 'package:app/core/domain/event/entities/event_user_role.dart';
import 'package:app/core/service/feature_manager/feature_visibility_strategy.dart';
import 'package:app/graphql/backend/schema.graphql.dart';

class RoleBasedFeatureVisibilityStrategy implements FeatureVisibilityStrategy {
  @override
  bool shouldShowFeature({
    Enum$FeatureCode? featureCode,
    EventUserRole? eventUserRole,
  }) {
    if (eventUserRole == null) {
      return true;
    }
    final roles = eventUserRole.roles ?? [];
    for (var role in roles) {
      final featuresExpanded = role.roleExpanded?.featuresExpanded ?? [];
      for (var featureExpanded in featuresExpanded) {
        if (featureExpanded?.code == featureCode) {
          return featureExpanded?.featureEnable ?? true;
        }
      }
    }
    return true;
  }
}
