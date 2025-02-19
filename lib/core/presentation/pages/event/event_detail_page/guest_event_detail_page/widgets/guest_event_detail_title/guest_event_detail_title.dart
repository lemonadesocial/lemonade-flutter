import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestEventDetailTitle extends StatelessWidget {
  final Event event;
  const GuestEventDetailTitle({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _HostInfo(event: event),
        SizedBox(
          height: Spacing.superExtraSmall,
        ),
        Text(
          event.title ?? '',
          style: Typo.superLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }
}

class _HostInfo extends StatelessWidget {
  const _HostInfo({
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(
          ProfileRoute(
            userId: event.hostExpanded?.userId ?? '',
          ),
        );
      },
      child: Row(
        children: [
          LemonNetworkImage(
            imageUrl: event.hostExpanded?.imageAvatar ?? '',
            width: 18.w,
            height: 18.w,
            borderRadius: BorderRadius.circular(18.w),
            placeholder: ImagePlaceholder.avatarPlaceholder(),
          ),
          SizedBox(width: Spacing.extraSmall),
          Text(
            event.hostExpanded?.name ?? '',
            style: Typo.medium.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
          SizedBox(width: Spacing.superExtraSmall),
          ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icArrowRight.svg(
              colorFilter: filter,
            ),
          ),
        ],
      ),
    );
  }
}
