import 'dart:math';

import 'package:app/core/config.dart';
import 'package:app/core/presentation/widgets/map/map_option_bottom_sheet.dart';
import 'package:app/theme/color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

enum GeoAppOption {
  google,
  apple,
  waze,
}

class MapUtils {
  static String createGoogleMapsURL({
    double lat = 0.0,
    double lng = 0.0,
    bool attended = false,
    bool small = false,
    bool dark = true,
  }) {
    int z = attended ? 20 : 12;
    if (small) z = 18;
    final latOff = Random().nextDouble() * 0.01;
    final lngOff = Random().nextDouble() * 0.01;
    final latFinal = attended ? lat : latOff + lat;
    final lngFinal = attended ? lng : lngOff + lng;
    const darkTheme =
        '&style=feature:all|element:labels.text.fill|color:0x000000|lightness:40&style=feature:all|element:labels.text.stroke|visibility:on|color:0x000000|lightness:16&style=feature:all|element:labels.icon|visibility:on|color:0x000000|lightness:16&style=feature:administrative|element:geometry.fill|color:0x000000|lightness:12&style=feature:administrative|element:geometry.stroke|color:0x000000|lightness:18|weight:1.2&style=feature:landscape|element:geometry|color:0x000000|lightness:10&style=feature:poi|element:geometry|color:0x000000|lightness:12&style=feature:road.highway|element:geometry.fill|color:0x000000|lightness:16&style=feature:road.highway|element:geometry.stroke|color:0x000000|lightness:18|weight:0.2&style=feature:road.arterial|element:geometry|color:0x000000|lightness:18&style=feature:road.local|element:geometry|color:0x000000|lightness:16&style=feature:transit|element:geometry|color:0x000000|lightness:16&style=feature:water|element:geometry|color:0x000000|lightness:14';
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latFinal,$lngFinal&zoom=$z&size=1280x520&scale=2&key=${AppConfig.googleMapKey}${dark ? darkTheme : ''}';
  }

  static Future<String> getLocationName({
    double lat = 0.0,
    double lng = 0.0,
  }) async {
    final latOff = Random().nextDouble() * 0.01;
    final lngOff = Random().nextDouble() * 0.01;
    try {
      var response = await Dio().get(
        'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=$lat,$lng&origins=${lat + latOff},${lng + lngOff}&key=${AppConfig.googleMapKey}',
      );
      String destinationAddresses =
          List<String>.from(response.data?["destination_addresses"] ?? [])
              .map((item) => item)
              .toList()
              .join(' ');
      return destinationAddresses;
    } catch (error) {
      return '';
    }
  }

  /// Returns a [Uri] that can be launched on the current platform
  /// to open a maps application showing coordinates ([latitude] and [longitude]).
  static Uri createCoordinatesUri(
    double latitude,
    double longitude, {
    GeoAppOption? option,
  }) {
    if (option == GeoAppOption.apple) {
      var params = {
        'll': '$latitude,$longitude',
      };

      return Uri.https('maps.apple.com', '/', params);
    }

    if (option == GeoAppOption.waze) {
      var params = {
        'll': '$latitude,$longitude',
      };
      return Uri.https('www.waze.com', '/ul', params);
    }

    return Uri.https(
      'www.google.com',
      '/maps/search/',
      {'api': '1', 'query': '$latitude,$longitude'},
    );
  }

  /// Launches the maps application for this platform.
  /// The maps application will show the specified coordinates.
  /// Returns a Future that resolves to true if the maps application
  /// was launched successfully, false otherwise.
  static Future<bool> launchCoordinates(
    double latitude,
    double longitude,
  ) {
    return launchUrl(createCoordinatesUri(latitude, longitude));
  }

  static showMapOptionBottomSheet(
    BuildContext context, {
    required double latitude,
    required double longitude,
  }) {
    showCupertinoModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: LemonColor.atomicBlack,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => MapOptionBottomSheet(
        lat: latitude,
        lng: longitude,
      ),
    );
  }
}
