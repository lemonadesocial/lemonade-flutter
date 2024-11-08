import 'dart:io';

import 'package:app/core/utils/map_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MapOptionBottomSheet extends StatelessWidget {
  final double lat;
  final double lng;
  const MapOptionBottomSheet({
    super.key,
    required this.lat,
    required this.lng,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: GeoAppOption.values.map((option) {
          if (Platform.isAndroid && option == GeoAppOption.apple) {
            return const SizedBox.shrink();
          }
          return ListTile(
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop();
              launchUrl(
                MapUtils.createCoordinatesUri(
                  lat,
                  lng,
                  option: option,
                ),
                mode: LaunchMode.externalApplication,
              );
            },
            title: Text(StringUtils.capitalize(option.name)),
          );
        }).toList(),
      ),
    );
  }
}
