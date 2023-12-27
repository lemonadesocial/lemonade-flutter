import 'package:flutter/material.dart';

enum EventPrivacy { public, private }

enum EventConfigurationType {
  visibility,
  guestSettings,
  startDateTime,
  endDateTime,
  virtual,
  location
}

class EventConfiguration {
  EventConfiguration({
    required this.type,
    required this.title,
    this.description,
    required this.icon,
    this.selected,
  });

  final EventConfigurationType type;
  final String title;
  final String? description;
  final Widget icon;
  final bool? selected;
}
