import 'package:app/core/domain/event/entities/event_user_role.dart';
import 'package:app/core/service/feature_manager/feature_visibility_strategy.dart';
import 'package:app/graphql/backend/schema.graphql.dart';

class UserRoleFeatureVisibilityStrategy implements FeatureVisibilityStrategy {
  final EventUserRole? eventUserRole;
  final List<Enum$RoleCode>? roleCodes;

  UserRoleFeatureVisibilityStrategy({
    required this.eventUserRole,
    required this.roleCodes,
  });

  @override
  bool get canShowFeature {
    if (eventUserRole == null ||
        roleCodes == null ||
        roleCodes?.isEmpty == true) {
      return false;
    }
    for (final role in (eventUserRole!.roles ?? [])) {
      final roleCode = role.roleExpanded?.code;
      if ((roleCodes ?? []).contains(roleCode)) {
        return true;
      }
    }
    return false;
  }
}
