import 'dart:ui';

import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/event/event_default_price_badge.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/device_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventPostCard extends StatelessWidget {
  const EventPostCard({
    super.key,
    required this.event,
  });
  final Event event;

  DbFile? get eventPhoto => event.newNewPhotosExpanded?.isNotEmpty ?? false
      ? event.newNewPhotosExpanded!.first
      : null;

  String get eventTitle => event.title ?? '';

  String get hostName =>
      event.hostExpanded?.displayName ?? event.hostExpanded?.username ?? '';

  int? get cohostsCount => event.cohostsExpanded?.length;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).navigate(
          EventDetailRoute(
            eventId: event.id ?? '',
          ),
        );
      },
      child: Stack(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: colorScheme.outline,
              ),
              borderRadius: BorderRadius.circular(LemonRadius.xSmall),
            ),
            child: Column(
              children: [
                _buildEventPhoto(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 14.h,
                    horizontal: Spacing.xSmall,
                  ),
                  child: Column(
                    children: [
                      _buildEventTitleAndTime(colorScheme),
                      SizedBox(height: Spacing.xSmall),
                      _buildEventHost(colorScheme),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: Spacing.extraSmall,
            right: Spacing.extraSmall,
            child: _buildEventBadge(colorScheme),
          ),
        ],
      ),
    );
  }

  Row _buildEventHost(ColorScheme colorScheme) {
    return Row(
      children: [
        _buildHostsAvatars(colorScheme),
        SizedBox(width: Spacing.extraSmall),
        ThemeSvgIcon(
          color: colorScheme.onSecondary,
          builder: (filter) => Assets.icons.icHostFilled.svg(
            colorFilter: filter,
            width: 15.w,
            height: 15.w,
          ),
        ),
        SizedBox(width: 5.w),
        Text.rich(
          style: Typo.small.copyWith(
            color: colorScheme.onSecondary,
            height: 1.5,
          ),
          TextSpan(
            text: hostName,
            children: [
              if (cohostsCount != null && cohostsCount != 0)
                TextSpan(text: ' +$cohostsCount'),
            ],
          ),
        ),
        SizedBox(width: Spacing.superExtraSmall),
      ],
    );
  }

  Widget _buildHostsAvatars(ColorScheme colorScheme) {
    final hosts = [...event.cohostsExpanded ?? [], event.hostExpanded];
    return SizedBox(
      width: (1 + 1 / 2 * (hosts.length - 1)) * Sizing.small,
      height: Sizing.small,
      child: Stack(
        children: hosts.asMap().entries.map((entry) {
          final file = (entry.value?.newPhotosExpanded?.isNotEmpty == true)
              ? entry.value?.newPhotosExpanded!.first
              : null;
          return Positioned(
            right: entry.key * 12,
            child: Container(
              width: Sizing.small,
              height: Sizing.small,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                border: Border.all(color: colorScheme.outline),
                borderRadius: BorderRadius.circular(Sizing.small),
              ),
              child: LemonCircleAvatar(
                url: ImageUtils.generateUrl(file: file),
                size: Sizing.small,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Row _buildEventTitleAndTime(ColorScheme colorScheme) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${event.title}',
                style: Typo.medium.copyWith(fontFamily: FontFamily.circularStd),
              ),
              Row(
                children: [
                  Text(
                    DateFormatUtils.dateOnly(event.start),
                    style: Typo.small.copyWith(
                      color: colorScheme.onSecondary,
                      height: 1.5,
                      fontFamily: FontFamily.circularStd,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
                    child: Container(
                      width: 3.r,
                      height: 3.r,
                      decoration: ShapeDecoration(
                        color: colorScheme.outlineVariant,
                        shape: const OvalBorder(),
                      ),
                    ),
                  ),
                  Text(
                    DateFormatUtils.timeOnly(event.start),
                    style: Typo.small.copyWith(
                      color: colorScheme.onSecondary,
                      height: 1.5,
                      fontFamily: FontFamily.circularStd,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          width: Spacing.xSmall,
        ),
        EventDefaultPriceBadge(event: event),
      ],
    );
  }

  SizedBox _buildEventPhoto() {
    return SizedBox(
      height: DeviceUtils.isIpad() ? 340.h : 170.h,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(LemonRadius.xSmall),
          topLeft: Radius.circular(LemonRadius.xSmall),
        ),
        child: CachedNetworkImage(
          imageUrl: ImageUtils.generateUrl(
            file: eventPhoto,
            imageConfig: ImageConfig.eventPhoto,
          ),
          errorWidget: (_, __, ___) => ImagePlaceholder.eventCard(),
          placeholder: (_, __) => ImagePlaceholder.eventCard(),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildEventBadge(ColorScheme colorScheme) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          width: Sizing.regular,
          height: Sizing.regular,
          decoration: ShapeDecoration(
            shape: CircleBorder(
              side: BorderSide(color: colorScheme.outline),
            ),
            color: Colors.transparent,
          ),
          child: Center(
            child: Assets.icons.icHouseParty.svg(
              width: Sizing.xSmall,
              height: Sizing.xSmall,
            ),
          ),
        ),
      ),
    );
  }
}
