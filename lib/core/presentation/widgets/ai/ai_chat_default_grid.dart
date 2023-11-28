import 'package:app/core/presentation/widgets/home/create_pop_up_tile.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<Map<String, dynamic>> aiChatDefaultGridData = [
  {
    'action': 'create_post',
    'label': t.home.post,
    'content': t.home.postDesc,
    'icon': ThemeSvgIcon(
      builder: (colorFilter) => Assets.icons.icCreatePost.svg(
        width: 24.w,
        height: 24.w,
      ),
    ),
    'featureAvailable': true,
    'colors': CreatePopupGradient.post.colors,
  },
  {
    'action': 'create_room',
    'label': t.home.room,
    'content': t.home.roomDesc,
    'icon': ThemeSvgIcon(
      builder: (colorFilter) => Assets.icons.icCreateRoom.svg(
        width: 24.w,
        height: 24.w,
      ),
    ),
    'featureAvailable': false,
    'colors': CreatePopupGradient.room.colors,
  },
  {
    'action': 'create_event',
    'label': t.home.event,
    'content': t.home.eventDesc,
    'icon': ThemeSvgIcon(
      color: LemonColor.paleViolet,
      builder: (colorFilter) => Assets.icons.icHouseParty.svg(
        width: 24.w,
        height: 24.w,
        colorFilter: colorFilter,
      ),
    ),
    'featureAvailable': false,
    'colors': CreatePopupGradient.event.colors,
  },
  {
    'action': 'create_poap',
    'label': t.home.poap,
    'content': t.home.poapDesc,
    'icon': ThemeSvgIcon(
      builder: (colorFilter) => Assets.icons.icCreatePoap.svg(
        width: 24.w,
        height: 24.w,
      ),
    ),
    'featureAvailable': false,
    'colors': CreatePopupGradient.poap.colors,
  },
  {
    'action': 'create_collectible',
    'label': t.home.collectible,
    'content': t.home.collectibleDesc,
    'icon': ThemeSvgIcon(
      color: LemonColor.collectibleColor,
      builder: (colorFilter) => Assets.icons.icCrystal.svg(
        width: 24.w,
        height: 24.w,
        colorFilter: colorFilter,
      ),
    ),
    'featureAvailable': false,
    'colors': CreatePopupGradient.collectible.colors,
  }
];

class AIChatDefaultGrid extends StatelessWidget {
  const AIChatDefaultGrid({super.key});

  onTap(BuildContext context, item) {
    final action = item['action'];
    switch (action) {
      case 'create_post':
        AutoRouter.of(context).navigate(const CreatePostRoute());
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemCount: aiChatDefaultGridData.length,
      itemBuilder: (BuildContext context, int gridIndex) {
        return AIGridItem(
          item: aiChatDefaultGridData[gridIndex],
          onTap: () => {onTap(context, aiChatDefaultGridData[gridIndex])},
        );
      },
    );
  }
}

class AIGridItem extends StatelessWidget {
  const AIGridItem({Key? key, this.onTap, required this.item})
      : super(key: key);
  final Function()? onTap;
  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final label = item['label'];
    final content = item['content'];
    final icon = item['icon'];
    final featureAvailable = item['featureAvailable'];
    final colors = item['colors'];
    return InkWell(
      onTap: onTap,
      child: GridTile(
        child: Stack(
          children: [
            Container(
              height: 120.h,
              padding: EdgeInsets.all(Spacing.smMedium),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                gradient: RadialGradient(
                  radius: 1.1,
                  center: Alignment.bottomRight,
                  colors: colors,
                ),
                shadows: [
                  BoxShadow(
                    color: LemonColor.white06,
                    offset: const Offset(-1, -1),
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  icon ?? const SizedBox(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              label,
                              style: Typo.medium.copyWith(
                                fontWeight: FontWeight.w600,
                                fontFamily: FontFamily.nohemiVariable,
                                color: colorScheme.onPrimary,
                              ),
                            ),
                            Text(
                              content,
                              style: Typo.xSmall.copyWith(
                                fontWeight: FontWeight.w400,
                                color: colorScheme.onPrimary.withOpacity(0.54),
                                fontFamily: FontFamily.switzerVariable,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (!featureAvailable)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: colorScheme.onPrimary.withOpacity(0.12),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(LemonRadius.xSmall),
                      topRight: Radius.circular(LemonRadius.xSmall),
                    ),
                  ),
                  child: Text(
                    t.home.comingSoon,
                    style: Typo.extraSmall.copyWith(
                      color: colorScheme.onPrimary.withOpacity(0.72),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
