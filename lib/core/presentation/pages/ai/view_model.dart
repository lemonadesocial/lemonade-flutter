import 'package:flutter/material.dart';

class AIDefaultChatGridModel {
  final String action;
  final String label;
  final String content;
  final Widget icon;
  final bool featureAvailable;
  final List<Color> colors;

  AIDefaultChatGridModel({
    required this.action,
    required this.label,
    required this.content,
    required this.icon,
    required this.featureAvailable,
    required this.colors,
  });
}
