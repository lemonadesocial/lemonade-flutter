import 'package:app/core/domain/collaborator/entities/user_discovery_swipe/user_discovery_swipe.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/widgets/collaborator_counter_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalCollaboratorLikesList extends StatelessWidget {
  final List<UserDiscoverySwipe> pendingSwipes;
  final Function()? refetch;
  final bool headerVisible;

  const HorizontalCollaboratorLikesList({
    super.key,
    required this.pendingSwipes,
    this.refetch,
    this.headerVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        if (headerVisible)
          InkWell(
            onTap: () =>
                AutoRouter.of(context).push(const CollaboratorLikesRoute()),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
              child: Row(
                children: [
                  Text(
                    t.collaborator.likes,
                    style: Typo.mediumPlus.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(
                    width: Spacing.extraSmall,
                  ),
                  CollaboratorCounter(
                    count: pendingSwipes.length,
                  ),
                  const Spacer(),
                  ThemeSvgIcon(
                    color: colorScheme.onSecondary,
                    builder: (filter) => Assets.icons.icArrowRight.svg(
                      colorFilter: filter,
                    ),
                  ),
                ],
              ),
            ),
          ),
        SizedBox(height: Spacing.xSmall),
        SizedBox(
          height: 87.w,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
            itemCount: pendingSwipes.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                AutoRouter.of(context).push(
                  CollaboratorLikePreviewRoute(
                    swipe: pendingSwipes[index],
                    refetch: refetch,
                  ),
                );
              },
              child: _PersonItem(
                swipe: pendingSwipes[index],
              ),
            ),
            separatorBuilder: (context, index) => SizedBox(
              width: Spacing.xSmall,
            ),
          ),
        ),
      ],
    );
  }
}

class _PersonItem extends StatelessWidget {
  final UserDiscoverySwipe swipe;
  const _PersonItem({
    required this.swipe,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 68.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: 64.w,
                height: 64.w,
                padding: EdgeInsets.all(2.w),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 2.w,
                      color: LemonColor.paleViolet,
                    ),
                    borderRadius: BorderRadius.circular(64.r),
                  ),
                ),
                child: LemonNetworkImage(
                  imageUrl: swipe.otherExpanded?.imageAvatar ?? '',
                  width: 60.w,
                  height: 60.w,
                  borderRadius: BorderRadius.circular(60.w),
                  placeholder: ImagePlaceholder.avatarPlaceholder(),
                ),
              ),
              if (swipe.message?.isNotEmpty == true)
                Positioned(
                  bottom: 4.w,
                  right: 4.w,
                  child: Assets.icons.icCollaboratorBubbleChat.svg(),
                ),
            ],
          ),
          SizedBox(height: Spacing.superExtraSmall),
          Text(
            swipe.otherExpanded?.name ?? '',
            textAlign: TextAlign.center,
            style: Typo.xSmall.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
