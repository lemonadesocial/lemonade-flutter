import 'package:intl/intl.dart';

enum DistanceUnit { kilometer, meter }

class DisplayDistance {
  DisplayDistance({
    required this.text,
    required this.unit,
  });

  final String text;
  final DistanceUnit unit;
}

class BadgeUtils {
  static DisplayDistance getDisplayDistance({required num distanceInMeter}) {
    final distanceInKm = distanceInMeter / 1000;
    String displayDistance;
    if (distanceInKm >= 1) {
      displayDistance = NumberFormat.compact().format(distanceInKm);
    } else {
      displayDistance = NumberFormat('##.##').format(distanceInMeter);
    }
    return DisplayDistance(
        text: displayDistance, unit: distanceInKm >= 1 ? DistanceUnit.kilometer : DistanceUnit.meter,);
  }
}
