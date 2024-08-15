import 'package:app/core/service/feature_manager/feature_visibility_strategy.dart';

class FeatureManager {
  final FeatureVisibilityStrategy strategy;

  FeatureManager(this.strategy);

  bool get canShowFeature => strategy.canShowFeature;
}
