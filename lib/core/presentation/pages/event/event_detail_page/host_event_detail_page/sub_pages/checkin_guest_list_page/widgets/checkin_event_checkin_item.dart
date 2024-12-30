import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_checkin.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

class CheckinEventCheckinItem extends StatelessWidget {
  final Event? event;
  final EventCheckin eventCheckin;
  final Function()? refetch;
  final Function()? onTap;
  final bool? isFirst;
  final bool? isLast;
  const CheckinEventCheckinItem({
    super.key,
    this.event,
    required this.eventCheckin,
    this.refetch,
    this.onTap,
    this.isFirst,
    this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(Spacing.small),
            decoration: BoxDecoration(
              color: colorScheme.secondaryContainer,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  isFirst == true ? LemonRadius.medium : LemonRadius.extraSmall,
                ),
                topRight: Radius.circular(
                  isFirst == true ? LemonRadius.medium : LemonRadius.extraSmall,
                ),
                bottomLeft: Radius.circular(
                  isLast == true ? LemonRadius.medium : LemonRadius.extraSmall,
                ),
                bottomRight: Radius.circular(
                  isLast == true ? LemonRadius.medium : LemonRadius.extraSmall,
                ),
              ),
            ),
            // color: LemonColor.white03,
            child: Row(
              children: [
                _GuestInfo(eventCheckin: eventCheckin),
                const Spacer(),
                if (eventCheckin.active == true) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        StringUtils.capitalize(t.event.checkedIn),
                        style: Typo.small.copyWith(
                          color: LemonColor.malachiteGreen,
                        ),
                      ),
                      SizedBox(height: 2.w),
                      Text(
                        timeago
                            .format(eventCheckin.createdAt ?? DateTime.now()),
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GuestInfo extends StatelessWidget {
  const _GuestInfo({
    required this.eventCheckin,
  });

  final EventCheckin eventCheckin;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final loginUser = eventCheckin.loginUser;
    final nonLoginUser = eventCheckin.user;
    final email = eventCheckin.email;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        LemonNetworkImage(
          borderRadius: BorderRadius.circular(Sizing.medium),
          width: Sizing.medium,
          height: Sizing.medium,
          imageUrl: loginUser?.imageAvatar ?? '',
          placeholder: ImagePlaceholder.avatarPlaceholder(),
        ),
        SizedBox(width: Spacing.xSmall),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Sizing.xLarge * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                loginUser?.name ?? nonLoginUser ?? t.common.anonymous,
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2.w),
              Text(
                email ?? loginUser?.email ?? nonLoginUser ?? t.common.anonymous,
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
