import 'package:app/core/domain/collaborator/entities/user_discovery_swipe/user_discovery_swipe.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/widgets/collaborator_counter_widget.dart';
import 'package:app/core/presentation/pages/home/views/collaborator_circle_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
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
        SizedBox(
          height: 64.w,
          child: ListView.separated(
            padding: EdgeInsets.only(left: Spacing.xSmall),
            itemCount: pendingSwipes.length + 1,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index == 0) {
                return InkWell(
                  onTap: () {
                    AutoRouter.of(context).push(CollaboratorRoute());
                  },
                  child: const CollaboratorCircleWidget(),
                );
              } else {
                final swipeIndex = index - 1;
                return InkWell(
                  onTap: () {
                    AutoRouter.of(context).push(
                      CollaboratorLikePreviewRoute(
                        swipe: pendingSwipes[swipeIndex],
                        refetch: refetch,
                      ),
                    );
                  },
                  child: _PersonItem(
                    swipe: pendingSwipes[swipeIndex],
                  ),
                );
              }
            },
            separatorBuilder: (context, index) => SizedBox(
              width: 10.w,
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
                      width: 1.w,
                      color: colorScheme.onPrimary,
                    ),
                    borderRadius: BorderRadius.circular(64.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(2.w),
                  child: LemonNetworkImage(
                    imageUrl: swipe.otherExpanded?.imageAvatar ?? '',
                    width: 60.w,
                    height: 60.w,
                    borderRadius: BorderRadius.circular(60.w),
                    placeholder: ImagePlaceholder.avatarPlaceholder(),
                  ),
                ),
              ),
              if (swipe.message?.isNotEmpty == true)
                Positioned(
                  bottom: 2.w,
                  right: 2.w,
                  child: Container(
                    width: Sizing.xxSmall * 1.5,
                    height: Sizing.xxSmall * 1.5,
                    decoration: BoxDecoration(
                      color: LemonColor.coralReef,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorScheme.background,
                        width: 3.w,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
