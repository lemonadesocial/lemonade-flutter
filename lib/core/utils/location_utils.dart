import 'package:location/location.dart';

class LocationUtils {
  Location _location = Location();
  PermissionStatus _permissionStatus = PermissionStatus.denied;
  final Function()? onPermissionDeniedForever;

  LocationUtils({
    this.onPermissionDeniedForever,
  });

  PermissionStatus get permissionStatus => _permissionStatus;

  Future<LocationData> getCurrentLocation() async {
    if (!(await _location.serviceEnabled()) && !(await _location.requestService())) {
      throw LocationServiceNotEnabledException();
    }

    if (!await _checkAndRequestPermission()) {
      throw PermissionNotGrantedException();
    }

    return await _location.getLocation();
  }

  Future<bool> _checkAndRequestPermission() async {
    PermissionStatus _status = await _location.hasPermission();

    if (_status == PermissionStatus.denied) {
      _status = await _location.requestPermission();
    }

    if (_status == PermissionStatus.deniedForever) {
      onPermissionDeniedForever?.call();
    }

    _permissionStatus = _status;

    return _permissionStatus == PermissionStatus.granted;
  }
}


class LocationServiceNotEnabledException implements Exception {
  @override
  String toString() {
    return "Location service is not enabled";
  }
}

class PermissionNotGrantedException implements Exception {
  @override
  String toString() {
    return "Location permission is not granted";
  }
}