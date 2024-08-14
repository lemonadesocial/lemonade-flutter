import 'package:app/core/domain/event/entities/event_user_role.dart';
import 'package:app/core/service/feature_manager/feature_visibility_strategy.dart';
import 'package:app/graphql/backend/schema.graphql.dart';

class EventRoleBasedFeatureVisibilityStrategy
    implements FeatureVisibilityStrategy {
  static const Map<Enum$FeatureCode, List<Enum$RoleCode>> _featureRoleMappings =
      {
    Enum$FeatureCode.DataDashboardInsights: [
      Enum$RoleCode.Host,
      Enum$RoleCode.Cohost,
      Enum$RoleCode.Manager,
      Enum$RoleCode.Marketing,
      Enum$RoleCode.DataAnalyst,
    ],
    Enum$FeatureCode.DataDashboardRewards: [
      Enum$RoleCode.Host,
      Enum$RoleCode.Cohost,
      Enum$RoleCode.Manager,
      Enum$RoleCode.Marketing,
      Enum$RoleCode.DataAnalyst,
    ],
    Enum$FeatureCode.DataDashboardRevenue: [
      Enum$RoleCode.Host,
      Enum$RoleCode.Cohost,
      Enum$RoleCode.Manager,
      Enum$RoleCode.Marketing,
      Enum$RoleCode.DataAnalyst,
    ],
    Enum$FeatureCode.CSVExportGuestList: [
      Enum$RoleCode.Host,
      Enum$RoleCode.Cohost,
      Enum$RoleCode.Manager,
      Enum$RoleCode.Sales,
      Enum$RoleCode.Marketing,
      Enum$RoleCode.DataAnalyst,
    ],
    Enum$FeatureCode.GuestListDashboard: [
      Enum$RoleCode.Host,
      Enum$RoleCode.Cohost,
      Enum$RoleCode.Manager,
    ],
    Enum$FeatureCode.EventSettings: [
      Enum$RoleCode.Host,
      Enum$RoleCode.Cohost,
      Enum$RoleCode.Manager,
    ],
    Enum$FeatureCode.TicketingSettings: [
      Enum$RoleCode.Host,
      Enum$RoleCode.Cohost,
      Enum$RoleCode.Manager,
    ],
    Enum$FeatureCode.EmailManager: [
      Enum$RoleCode.Host,
      Enum$RoleCode.Cohost,
      Enum$RoleCode.Manager,
      Enum$RoleCode.Marketing,
    ],
    Enum$FeatureCode.PromotionCodes: [
      Enum$RoleCode.Host,
      Enum$RoleCode.Cohost,
      Enum$RoleCode.Manager,
      Enum$RoleCode.Sales,
    ],
    Enum$FeatureCode.POAPdata: [
      Enum$RoleCode.Host,
      Enum$RoleCode.Cohost,
    ],
    Enum$FeatureCode.CheckIn: [
      Enum$RoleCode.Host,
      Enum$RoleCode.Cohost,
      Enum$RoleCode.Manager,
      Enum$RoleCode.Promoter,
    ],
    Enum$FeatureCode.EAS: [
      Enum$RoleCode.Host,
    ],
  };
  @override
  bool canShowFeature({
    EventUserRole? eventUserRole,
    List<Enum$FeatureCode>? featureCodes,
  }) {
    if (eventUserRole == null) return true;

    final roles = eventUserRole.roles ?? [];
    if (roles.isEmpty) return false;

    // Precompute allowed roles for each feature code to reduce repetitive lookups
    final featureRoleMappings = {
      for (var featureCode in featureCodes!)
        featureCode: _featureRoleMappings[featureCode] ?? [],
    };

    for (var role in roles) {
      final roleCode = role.roleExpanded?.code;
      final featuresExpanded = role.roleExpanded?.featuresExpanded ?? [];

      for (var featureCode in featureCodes) {
        final allowedRoles = featureRoleMappings[featureCode]!;
        if (!allowedRoles.contains(roleCode)) continue;

        final featureEnabled = featuresExpanded.any(
          (feature) =>
              feature?.code == featureCode && (feature?.featureEnable ?? false),
        );

        if (featureEnabled) return true;
      }
    }

    return false;
  }
}
