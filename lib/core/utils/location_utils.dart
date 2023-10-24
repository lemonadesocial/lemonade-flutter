import 'package:app/core/presentation/widgets/common/dialog/lemon_alert_dialog.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class LocationUtils {
  LocationUtils();

  LocationPermission _permissionStatus = LocationPermission.denied;
  LocationPermission get permissionStatus => _permissionStatus;

  Future<Position> getCurrentLocation({
    void Function()? onPermissionDeniedForever,
    bool? shouldRequestPermission = true,
  }) async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      throw LocationServiceNotEnabledException();
    }

    if (!await checkAndRequestPermission(
      onPermissionDeniedForever: onPermissionDeniedForever,
      shouldRequestPermission: shouldRequestPermission,
    )) {
      throw PermissionNotGrantedException();
    }

    return Geolocator.getCurrentPosition();
  }

  Future<bool> checkPermission() async {
    _permissionStatus = await Geolocator.checkPermission();
    return _permissionStatus == LocationPermission.always ||
        _permissionStatus == LocationPermission.whileInUse;
  }

  Future<bool> checkAndRequestPermission({
    void Function()? onPermissionDeniedForever,
    bool? shouldRequestPermission = true,
  }) async {
    var status = await Geolocator.checkPermission();

    if (shouldRequestPermission == true) {
      if (status == LocationPermission.denied) {
        status = await Geolocator.requestPermission();
      }

      if (status == LocationPermission.deniedForever) {
        onPermissionDeniedForever?.call();
      }
    }
    _permissionStatus = status;

    return _permissionStatus == LocationPermission.always ||
        _permissionStatus == LocationPermission.whileInUse;
  }

  static Future<void> goToSetting(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        final t = Translations.of(context);
        return Theme(
          data: ThemeData.dark(),
          child: LemonAlertDialog(
            closable: true,
            onClose: () {
              Navigator.of(context).pop();
              Geolocator.openLocationSettings();
            },
            buttonLabel: t.common.actions.goToSettings,
            child: Text(
              t.common.requestLocation,
              style: Typo.medium,
            ),
          ),
        );
      },
    );
  }

  static Future<bool> requestLocationPermissionWithPopup(
    BuildContext context, {
    bool? shouldGoToSettings = true,
  }) async {
    final locationUtils = getIt<LocationUtils>();

    final result = await locationUtils.checkPermission();

    if (result) {
      return result;
    }

    if (getIt<LocationUtils>().permissionStatus ==
            LocationPermission.deniedForever &&
        shouldGoToSettings != true) {
      return false;
    }

    return await context.router.push<bool>(
          LocationRequestRoute(
            onPermissionDeniedForever: () {
              if (shouldGoToSettings != true) return;
              Navigator.of(context).pop();
              LocationUtils.goToSetting(context);
            },
          ),
        ) ??
        false;
  }
}

class LocationServiceNotEnabledException implements Exception {
  @override
  String toString() {
    return 'Location service is not enabled';
  }
}

class PermissionNotGrantedException implements Exception {
  @override
  String toString() {
    return 'Location permission is not granted';
  }
}
