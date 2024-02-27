import 'dart:ui';

import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/helper/event_features_helper.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventDetailFeaturesBar extends StatelessWidget {
  final Event event;
  const EventDetailFeaturesBar({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    late List features = [];
    final userId = context.read<AuthBloc>().state.maybeWhen(
          orElse: () => '',
          authenticated: (session) => session.userId,
        );
    final isCohost = EventUtils.isCohost(event: event, userId: userId);
    final isAttending = EventUtils.isAttending(event: event, userId: userId);
    final isOwnEvent = EventUtils.isOwnEvent(event: event, userId: userId);
    if (isOwnEvent || isCohost) {
      features = EventFeaturesHelper.getEventFeaturesForHost(context);
    } else if (isAttending) {
      features = EventFeaturesHelper.getEventFeaturesForHost(context);
    }
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
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
              scrollDirection: Axis.horizontal,
              itemCount: features.length,
              itemBuilder: (BuildContext context, int index) {
                final feature = features[index];
                return InkWell(
                  onTap: () {
                    feature.onTap();
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
                        child: Center(child: feature.iconData),
                      ),
                      SizedBox(
                        height: Spacing.extraSmall,
                      ),
                      Text(
                        feature.label,
                        style: Typo.xSmall.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: Spacing.xSmall,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
