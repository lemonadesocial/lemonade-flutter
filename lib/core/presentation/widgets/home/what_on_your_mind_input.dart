import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class WhatOnYourMindInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        // Add your onTap logic here for the entire widget.
        // For example, show a dialog or navigate to the edit screen.
        print("Custom input widget tapped!");
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: themeColor.outline),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "What's on your mind, Joseph?",
                style: Typo.medium.copyWith(fontWeight: FontWeight.w400, color: themeColor.onSecondary),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Add your edit icon onTap logic here
                // For example, show a dialog or navigate to the edit screen.
                print("Edit icon tapped!");
              },
              child: ThemeSvgIcon(
                color: themeColor.onSecondary,
                builder: (filter) => Assets.icons.icEdit
                    .svg(colorFilter: filter, width: 18, height: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
