import 'package:app/core/domain/event/entities/event_user_role.dart';
import 'package:app/graphql/backend/schema.graphql.dart';

class EventUserRoleUtils {
  static bool hasSalesRole({required EventUserRole? eventUserRole}) {
    return eventUserRole?.roles
            ?.any((role) => role.roleExpanded?.code == Enum$RoleCode.Sales) ??
        false;
  }

  static bool hasPromotionCodeFeature({
    required EventUserRole? eventUserRole,
  }) {
    final roles = eventUserRole?.roles ?? [];
    for (var role in roles) {
      final featuresExpanded = role.roleExpanded?.featuresExpanded ?? [];
      for (var feature in featuresExpanded) {
        if (feature?.code == Enum$FeatureCode.PromotionCodes &&
            feature?.featureEnable == true) {
          return true;
        }
      }
    }
    return false;
  }
}
