import 'package:geolocator/geolocator.dart';

class LocationUtils {
  LocationPermission _permissionStatus = LocationPermission.denied;
  final Function()? onPermissionDeniedForever;

  LocationUtils({
    this.onPermissionDeniedForever,
  });

  LocationPermission get permissionStatus => _permissionStatus;

  Future<Position> getCurrentLocation() async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      throw LocationServiceNotEnabledException();
    }
    
    if (!await _checkAndRequestPermission()) {
      throw PermissionNotGrantedException();
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<bool> _checkAndRequestPermission() async {
    LocationPermission _status = await Geolocator.checkPermission();

    if (_status == LocationPermission.denied) {
      _status = await Geolocator.requestPermission();
    }

    if (_status == LocationPermission.deniedForever) {
      onPermissionDeniedForever?.call();
    }

    _permissionStatus = _status;

    return _permissionStatus == LocationPermission.always || _permissionStatus == LocationPermission.whileInUse;
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
