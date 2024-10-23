import 'package:app/core/domain/event/entities/event_checkin.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
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
    return InkWell(
      onTap: () {
        if (checkIn.user != null) {
          AutoRouter.of(context).push(ProfileRoute(userId: checkIn.user!));
        }
      },
      child: Column(
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
      ),
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
        LemonNetworkImage(
          borderRadius: BorderRadius.circular(Sizing.medium),
          width: Sizing.medium,
          height: Sizing.medium,
          imageUrl: checkIn.loginUser?.imageAvatar ?? '',
          placeholder: ImagePlaceholder.avatarPlaceholder(),
        ),
        SizedBox(width: Spacing.xSmall),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Sizing.xLarge * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                checkIn.loginUser != null
                    ? checkIn.loginUser?.name ??
                        checkIn.loginUser?.displayName ??
                        t.common.anonymous
                    : checkIn.nonLoginUser?.name ??
                        checkIn.nonLoginUser?.displayName ??
                        t.common.anonymous,
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2.w),
              Text(
                checkIn.loginUser != null
                    ? checkIn.loginUser?.email ?? checkIn.email ?? ''
                    : checkIn.nonLoginUser?.email ?? checkIn.email ?? '',
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
