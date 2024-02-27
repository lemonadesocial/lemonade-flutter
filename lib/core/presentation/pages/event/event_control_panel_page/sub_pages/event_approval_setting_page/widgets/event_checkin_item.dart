import 'package:app/core/domain/event/entities/event_checkin.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventCheckInItem extends StatelessWidget {
  final EventCheckin checkIn;
  const EventCheckInItem({
    super.key,
    required this.checkIn,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(Spacing.small),
          decoration: BoxDecoration(
            color: LemonColor.atomicBlack,
            borderRadius: BorderRadius.circular(
              LemonRadius.extraSmall,
            ),
          ),
          child: Row(
            children: [
              _GuestInfo(checkIn: checkIn),
            ],
          ),
        ),
      ],
    );
  }
}

class _GuestInfo extends StatelessWidget {
  const _GuestInfo({
    required this.checkIn,
  });

  final EventCheckin checkIn;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Sizing.medium),
          child: CachedNetworkImage(
            width: Sizing.medium,
            height: Sizing.medium,
            imageUrl: checkIn.userExpanded?.imageAvatar ?? '',
            placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
            errorWidget: (_, __, ___) => ImagePlaceholder.defaultPlaceholder(),
          ),
        ),
        SizedBox(width: Spacing.xSmall),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Sizing.xLarge * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                checkIn.userExpanded?.name ??
                    checkIn.userExpanded?.email ??
                    t.common.anonymous,
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2.w),
              Text(
                checkIn.userExpanded?.username != null
                    ? '@${checkIn.userExpanded?.username}'
                    : checkIn.userExpanded?.email ?? '',
                style: Typo.small.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
