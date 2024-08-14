import 'package:app/core/domain/event/entities/event_user_role.dart';
import 'package:app/core/service/feature_manager/feature_manager.dart';
import 'package:app/core/service/feature_manager/role_based_feature_visibility_strategy.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:flutter/material.dart';

mixin FeatureVisibilityMixin<T extends StatefulWidget> on State<T> {
  late FeatureManager featureManager;

  @override
  void initState() {
    super.initState();
    final strategy = RoleBasedFeatureVisibilityStrategy();
    featureManager = FeatureManager(strategy);
  }

  bool canShowFeature({
    required EventUserRole? eventUserRole,
    required Enum$FeatureCode featureCode,
  }) {
    return featureManager.canShowFeature(
      eventUserRole: eventUserRole,
      featureCode: featureCode,
    );
  }
}
