// import 'package:app/core/domain/event/entities/event_user_role.dart';
import 'package:app/core/service/feature_manager/feature_visibility_strategy.dart';
import 'package:app/graphql/backend/schema.graphql.dart';

class EventRoleBasedEventFeatureVisibilityStrategy
    implements FeatureVisibilityStrategy {
  // final EventUserRole? eventUserRole;
  final List<Enum$FeatureCode>? featureCodes;

  EventRoleBasedEventFeatureVisibilityStrategy({
    // required this.eventUserRole,
    required this.featureCodes,
  });

  // static const Map<Enum$FeatureCode, List<Enum$RoleCode>> _featureRoleMappings =
  //     {
  //   Enum$FeatureCode.DataDashboardInsights: [
  //     Enum$RoleCode.Host,
  //     Enum$RoleCode.Cohost,
  //     Enum$RoleCode.Manager,
  //     Enum$RoleCode.Marketing,
  //     Enum$RoleCode.DataAnalyst,
  //   ],
  //   Enum$FeatureCode.DataDashboardRewards: [
  //     Enum$RoleCode.Host,
  //     Enum$RoleCode.Cohost,
  //     Enum$RoleCode.Manager,
  //     Enum$RoleCode.Marketing,
  //     Enum$RoleCode.DataAnalyst,
  //   ],
  //   Enum$FeatureCode.DataDashboardRevenue: [
  //     Enum$RoleCode.Host,
  //     Enum$RoleCode.Cohost,
  //     Enum$RoleCode.Manager,
  //     Enum$RoleCode.Marketing,
  //     Enum$RoleCode.DataAnalyst,
  //   ],
  //   Enum$FeatureCode.CSVExportGuestList: [
  //     Enum$RoleCode.Host,
  //     Enum$RoleCode.Cohost,
  //     Enum$RoleCode.Manager,
  //     Enum$RoleCode.Sales,
  //     Enum$RoleCode.Marketing,
  //     Enum$RoleCode.DataAnalyst,
  //   ],
  //   Enum$FeatureCode.GuestListDashboard: [
  //     Enum$RoleCode.Host,
  //     Enum$RoleCode.Cohost,
  //     Enum$RoleCode.Manager,
  //   ],
  //   Enum$FeatureCode.EventSettings: [
  //     Enum$RoleCode.Host,
  //     Enum$RoleCode.Cohost,
  //     Enum$RoleCode.Manager,
  //   ],
  //   Enum$FeatureCode.TicketingSettings: [
  //     Enum$RoleCode.Host,
  //     Enum$RoleCode.Cohost,
  //     Enum$RoleCode.Manager,
  //   ],
  //   Enum$FeatureCode.EmailManager: [
  //     Enum$RoleCode.Host,
  //     Enum$RoleCode.Cohost,
  //     Enum$RoleCode.Manager,
  //     Enum$RoleCode.Marketing,
  //   ],
  //   Enum$FeatureCode.PromotionCodes: [
  //     Enum$RoleCode.Host,
  //     Enum$RoleCode.Cohost,
  //     Enum$RoleCode.Manager,
  //     Enum$RoleCode.Sales,
  //   ],
  //   Enum$FeatureCode.POAPdata: [
  //     Enum$RoleCode.Host,
  //     Enum$RoleCode.Cohost,
  //   ],
  //   Enum$FeatureCode.CheckIn: [
  //     Enum$RoleCode.Host,
  //     Enum$RoleCode.Cohost,
  //     Enum$RoleCode.Manager,
  //     Enum$RoleCode.Promoter,
  //   ],
  //   Enum$FeatureCode.EAS: [
  //     Enum$RoleCode.Host,
  //   ],
  // };

  @override
  bool get canShowFeature {
    // if (eventUserRole == null ||
    //     featureCodes == null ||
    //     featureCodes!.isEmpty) {
    //   return false;
    // }

    // for (final role in (eventUserRole!.roles ?? [])) {
    //   final roleCode = role.roleExpanded?.code;
    //   final featuresExpanded = role.roleExpanded?.featuresExpanded ?? [];

    //   for (final featureCode in featureCodes!) {
    //     final allowedRoles = _featureRoleMappings[featureCode] ?? [];
    //     if (allowedRoles.contains(roleCode)) {
    //       final featureEnabled = featuresExpanded.any(
    //         (feature) =>
    //             feature?.code == featureCode && feature?.featureEnable == true,
    //       );
    //       if (featureEnabled) {
    //         return true;
    //       }
    //     }
    //   }
    // }

    // return false;
    return true;
  }
}
