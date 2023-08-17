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

    if (!await _checkAndRequestPermission()) {
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
