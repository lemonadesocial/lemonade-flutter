import 'package:flutter/material.dart';

class EventConfigGridViewModel {
  final String title;
  final String subTitle;
  final Widget icon;
  final bool? showProgressBar;
  final List<Color>? progressBarColors;
  final Function() onTap;

  EventConfigGridViewModel({
    required this.title,
    required this.subTitle,
    required this.icon,
    this.showProgressBar,
    this.progressBarColors,
    required this.onTap,
  });
}
