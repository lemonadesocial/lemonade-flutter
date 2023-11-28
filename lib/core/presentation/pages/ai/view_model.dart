import 'package:flutter/material.dart';

class AIChatGridViewModel {
  final String action;
  final String label;
  final String content;
  final Widget icon;
  final bool featureAvailable;
  final List<Color> colors;

  AIChatGridViewModel({
    required this.action,
    required this.label,
    required this.content,
    required this.icon,
    required this.featureAvailable,
    required this.colors,
  });
}

class AICommandViewModel {
  final String label;
  final Function() onTap;

  AICommandViewModel({
    required this.label,
    required this.onTap,
  });
}
