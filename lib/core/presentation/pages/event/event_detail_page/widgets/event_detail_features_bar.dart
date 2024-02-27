import 'dart:ui';

import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventDetailFeaturesBar extends StatelessWidget {
  const EventDetailFeaturesBar({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 100.h,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(33, 33, 33, 0.87),
              Color.fromRGBO(23, 23, 23, 0.87),
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(LemonRadius.normal),
            topRight: Radius.circular(LemonRadius.normal),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: Spacing.small,
          horizontal: Spacing.medium,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(LemonRadius.normal),
            topRight: Radius.circular(LemonRadius.normal),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                InkWell(
                  onTap: () {
                    AutoRouter.of(context).navigate(const EventProgramRoute());
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 54.w,
                        height: 42.h,
                        decoration: BoxDecoration(
                          color: colorScheme.onPrimary.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(21.r),
                        ),
                        child: Icon(
                          Icons.home,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary, // Adjust the icon color as needed
                        ),
                      ),
                      const Text('Program'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
