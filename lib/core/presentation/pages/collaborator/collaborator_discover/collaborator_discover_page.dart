import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_basic_info_section.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_expertise_offering_card.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_photos_card.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_social_grid_section.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/widgets/collaborator_send_like_bottomsheet/collaborator_send_like_bottomsheet.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_icon_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

@RoutePage()
class CollaboratorDiscoverPage extends StatelessWidget {
  const CollaboratorDiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: LemonAppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Spacing.medium),
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.filter_alt_outlined,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: Spacing.medium),
            child: InkWell(
              onTap: () {
                AutoRouter.of(context).push(const CollaboratorLikesRoute());
              },
              child: Icon(
                Icons.favorite_border,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: Spacing.smMedium),
            child: InkWell(
              onTap: () {
                AutoRouter.of(context).push(const CollaboratorChatRoute());
              },
              child: ThemeSvgIcon(
                color: colorScheme.onPrimary,
                builder: (filter) => Assets.icons.icChatBubble.svg(
                  colorFilter: filter,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: Spacing.xSmall),
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.more_vert,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: CollaboratorDiscoverBasicInfoSection(),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 30.w,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: CollaboratorDiscoverPhotosCard(
                    photos: [
                      "https://i.pravatar.cc/1000?img=5",
                      "https://i.pravatar.cc/1000?img=9",
                      "https://i.pravatar.cc/1000?img=10",
                      "https://i.pravatar.cc/1000?img=11",
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 30.w,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: CollaboratorDiscoverExpertiseOfferingCard(),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 30.w,
                  ),
                ),
                const CollaboratorDiscoverSocialGridSection(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Spacing.smMedium,
                  horizontal: Spacing.xSmall,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: Sizing.xLarge,
                      height: Sizing.xLarge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Sizing.xLarge),
                        color: colorScheme.background,
                      ),
                      child: LinearGradientIconButton(
                        width: Sizing.xLarge,
                        height: Sizing.xLarge,
                        radius: BorderRadius.circular(Sizing.xLarge),
                        icon: Assets.icons.icClose.svg(
                          width: Sizing.small,
                          height: Sizing.small,
                        ),
                      ),
                    ),
                    Container(
                      width: Sizing.xLarge,
                      height: Sizing.xLarge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Sizing.xLarge),
                        color: colorScheme.background,
                      ),
                      child: LinearGradientIconButton(
                        onTap: () {
                          showCupertinoModalBottomSheet(
                            context: context,
                            backgroundColor: colorScheme.surface,
                            topRadius: Radius.circular(30.r),
                            builder: (mContext) {
                              return const CollaboratorSendLikeBottomSheet();
                            },
                          );
                        },
                        width: Sizing.xLarge,
                        height: Sizing.xLarge,
                        radius: BorderRadius.circular(Sizing.xLarge),
                        icon: ThemeSvgIcon(
                          color: LemonColor.paleViolet,
                          builder: (filter) => Assets.icons.icHeart.svg(
                            width: Sizing.small,
                            height: Sizing.small,
                            colorFilter: filter,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
