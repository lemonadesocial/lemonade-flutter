import 'package:app/core/domain/event/entities/event_guest.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventInvitedItem extends StatelessWidget {
  final EventGuest guest;
  const EventInvitedItem({
    super.key,
    required this.guest,
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
              _GuestInfo(guest: guest),
              const Spacer(),
              _Status(guest: guest),
            ],
          ),
        ),
      ],
    );
  }
}

class _Status extends StatelessWidget {
  const _Status({
    required this.guest,
  });

  final EventGuest guest;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.xSmall),
      decoration: BoxDecoration(
        color: LemonColor.darkBackground,
        borderRadius: BorderRadius.circular(LemonRadius.normal),
      ),
      child: Row(
        children: [
          Text(
            guest.joined == true
                ? t.event.eventInvited.joined
                : t.event.eventInvited.notJoined,
            style: Typo.small.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _GuestInfo extends StatelessWidget {
  const _GuestInfo({
    required this.guest,
  });

  final EventGuest guest;

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
            imageUrl: guest.userExpanded?.imageAvatar ?? '',
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
                guest.userExpanded?.name ??
                    guest.userExpanded?.email ??
                    t.common.anonymous,
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2.w),
              Text(
                guest.userExpanded?.username != null
                    ? '@${guest.userExpanded?.username}'
                    : guest.userExpanded?.email ?? '',
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
