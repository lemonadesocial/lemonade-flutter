import 'package:app/core/domain/badge/entities/badge_entities.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/utils/location_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class BadgeService {
  final LocationUtils _locationUtils = getIt<LocationUtils>();
  List<BadgeList> selectedCollections = [];
  BadgeLocation? selectedLocation;
  GeoPoint? geoPoint;
  double distance = 1;

  List<BadgeList> addCollection(BadgeList collection) {
    return selectedCollections = [...selectedCollections, collection];
  }

  List<BadgeList> removeCollection(BadgeList collection) {
    return selectedCollections = selectedCollections.where((item) => item.id != collection.id).toList();
  }

  void updateGeoPoint(GeoPoint? point) {
    geoPoint = point;
  }

  void selectLocation(BadgeLocation? location) {
    selectedLocation = location;
  }

  void updateDistance(double value) {
    if (value < 1) {
      distance = 1;
      return;
    }
    distance = value;
  }

  Future<void> updateMyLocation() async {
    try {
      final position = await _locationUtils.getCurrentLocation();
      updateGeoPoint(
        GeoPoint(
          lat: position.latitude,
          lng: position.longitude,
        ),
      );

      if (selectedLocation != null && selectedLocation!.isMyLocation) {
        selectLocation(
          BadgeLocation.myLocation(
            geoPoint: GeoPoint(
              lat: position.latitude,
              lng: position.longitude,
            ),
          ),
        );
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
