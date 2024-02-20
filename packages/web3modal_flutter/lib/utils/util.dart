import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:web3modal_flutter/constants/eth_constants.dart';

class Util {
  static String shorten(String value, {bool short = false}) {
    return short && value.length > 8 ? '${value.substring(0, 8)}..' : value;
  }

  static String truncate(String value, {int length = 4}) {
    if (value.length <= length) {
      return value;
    }

    return '${value.substring(0, length)}...${value.substring(value.length - length)}';
  }

  static List<Color> get defaultAvatarColors => [
        Color(0xFFf5ccfc),
        Color(0xFFdba4f5),
        Color(0xFF9a8ee8),
        Color(0xFF6493da),
        Color(0xFF6ebdea),
      ];

  static List<Color> generateAvatarColors(String? address) {
    if ((address ?? '').isEmpty) {
      return defaultAvatarColors;
    }

    try {
      final hash = address!.toLowerCase().replaceFirst('0x', '');
      final baseColor = hash.substring(0, 6);
      final rgbColor = _hexToRgb(baseColor);

      final List<Color> colors = [];

      for (int i = 0; i < 5; i += 1) {
        final tintedColor = _tintColor(rgbColor, 0.15 * i);
        colors.add(
          Color.fromRGBO(
            tintedColor[0],
            tintedColor[1],
            tintedColor[2],
            1.0,
          ),
        );
      }

      return colors;
    } catch (e) {
      return defaultAvatarColors;
    }
  }

  static List<int> _hexToRgb(String hex) {
    final bigint = int.parse(hex, radix: 16);

    final r = (bigint >> 16) & 255;
    final g = (bigint >> 8) & 255;
    final b = bigint & 255;

    return [r, g, b];
  }

  static List<int> _tintColor(List<int> rgb, double tint) {
    final tintedR = (rgb[0] + (255 - rgb[0]) * tint).round();
    final tintedG = (rgb[1] + (255 - rgb[1]) * tint).round();
    final tintedB = (rgb[2] + (255 - rgb[2]) * tint).round();

    return [tintedR, tintedG, tintedB];
  }

  static Set<String> getChainsFromNamespace(Map<String, RequiredNamespace> ns) {
    return ns[EthConstants.namespace]?.chains?.toSet() ?? {};
  }

  static Set<String> getMethodsFromNamespace(
      Map<String, RequiredNamespace> ns) {
    return ns[EthConstants.namespace]?.methods.toSet() ?? {};
  }

  static Set<String> getEventsFromNamespace(Map<String, RequiredNamespace> ns) {
    return ns[EthConstants.namespace]?.events.toSet() ?? {};
  }
}
