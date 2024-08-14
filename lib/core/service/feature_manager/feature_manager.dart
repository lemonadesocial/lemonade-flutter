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

  bool canShowDashboard({
    required EventUserRole? eventUserRole,
  }) {
    return strategy.canShowFeature(
      eventUserRole: eventUserRole,
      featureCodes: [
        Enum$FeatureCode.DataDashboardInsights,
        Enum$FeatureCode.DataDashboardRewards,
        Enum$FeatureCode.DataDashboardRevenue,
      ],
    );
  }

  bool canShowGuestList({
    required EventUserRole? eventUserRole,
  }) {
    return strategy.canShowFeature(
      eventUserRole: eventUserRole,
      featureCodes: [Enum$FeatureCode.GuestListDashboard],
    );
  }

  bool canShowEventSettings({
    required EventUserRole? eventUserRole,
  }) {
    return strategy.canShowFeature(
      eventUserRole: eventUserRole,
      featureCodes: [Enum$FeatureCode.EventSettings],
    );
  }

  bool canShowTicketSettings({
    required EventUserRole? eventUserRole,
  }) {
    return strategy.canShowFeature(
      eventUserRole: eventUserRole,
      featureCodes: [Enum$FeatureCode.TicketingSettings],
    );
  }

  bool canShowPromotion({
    required EventUserRole? eventUserRole,
  }) {
    return strategy.canShowFeature(
      eventUserRole: eventUserRole,
      featureCodes: [Enum$FeatureCode.PromotionCodes],
    );
  }

  bool canShowPoap({
    required EventUserRole? eventUserRole,
  }) {
    return strategy.canShowFeature(
      eventUserRole: eventUserRole,
      featureCodes: [Enum$FeatureCode.POAPdata],
    );
  }

  bool canShowCheckin({
    required EventUserRole? eventUserRole,
  }) {
    return strategy.canShowFeature(
      eventUserRole: eventUserRole,
      featureCodes: [Enum$FeatureCode.CheckIn],
    );
  }
}
