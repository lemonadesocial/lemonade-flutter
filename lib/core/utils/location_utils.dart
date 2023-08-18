import 'package:app/i18n/i18n.g.dart';
import 'package:flutter/cupertino.dart';
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
  }) async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      throw LocationServiceNotEnabledException();
    }

    if (!await _checkAndRequestPermission(
      onPermissionDeniedForever: onPermissionDeniedForever,
    )) {
      throw PermissionNotGrantedException();
    }

    return Geolocator.getCurrentPosition();
  }

  Future<bool> checkPermission() async {
    _permissionStatus = await Geolocator.checkPermission();
    return _permissionStatus == LocationPermission.always || _permissionStatus == LocationPermission.whileInUse;
  }

  Future<bool> _checkAndRequestPermission({
    void Function()? onPermissionDeniedForever,
  }) async {
    var status = await Geolocator.checkPermission();

    if (status == LocationPermission.denied) {
      status = await Geolocator.requestPermission();
    }

    if (status == LocationPermission.deniedForever) {
      onPermissionDeniedForever?.call();
    }

    _permissionStatus = status;

    return _permissionStatus == LocationPermission.always || _permissionStatus == LocationPermission.whileInUse;
  }

  static Future<void> goToSetting(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        final t = Translations.of(context);
        return Theme(
          data: ThemeData.dark(),
          child: CupertinoAlertDialog(
            content: Text(t.common.requestLocation),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                isDestructiveAction: true,
                child: Text(t.common.actions.cancel),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.of(context).pop();
                  Geolocator.openLocationSettings();
                },
                child: Text(t.common.actions.goToSettings),
              ),
            ],
          ),
        );
      },
    );
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
