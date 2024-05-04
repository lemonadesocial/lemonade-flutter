import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class _ItemData {
  final double count;
  final String title;
  final ThemeSvgIcon themeSvgIcon;

  _ItemData({
    required this.count,
    required this.title,
    required this.themeSvgIcon,
  });
}

class CollaboratorDiscoverActivitySection extends StatelessWidget {
  final User? user;
  const CollaboratorDiscoverActivitySection({
    super.key,
    this.user,
  });
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final List<_ItemData> items = [
      _ItemData(
        count: user?.attended ?? 0,
        title: t.collaborator.eventHosted,
        themeSvgIcon: ThemeSvgIcon(
          color: LemonColor.paleViolet,
          builder: (colorFilter) => Assets.icons.icHostOutline.svg(
            colorFilter: colorFilter,
            width: 18.w,
            height: 18.w,
          ),
        ),
      ),
      _ItemData(
        count: user?.hosted ?? 0,
        title: t.collaborator.eventAttended,
        themeSvgIcon: ThemeSvgIcon(
          color: LemonColor.jordyBlue,
          builder: (colorFilter) => Assets.icons.icHouseParty.svg(
            colorFilter: colorFilter,
            width: 18.w,
            height: 18.w,
          ),
        ),
      ),
      // TODO: for now BE cannot handle
      // _ItemData(
      //   title: t.collaborator.nftCreated,
      //   themeSvgIcon: ThemeSvgIcon(
      //     color: LemonColor.venetianRed,
      //     builder: (colorFilter) => Assets.icons.icCrystal.svg(
      //       colorFilter: colorFilter,
      //       width: 18.w,
      //       height: 18.w,
      //     ),
      //   ),
      // ),
      // _ItemData(
      //   title: t.collaborator.nftCollected,
      //   themeSvgIcon: ThemeSvgIcon(
      //     builder: (colorFilter) => Assets.icons.icStarCircle.svg(
      //       width: 18.w,
      //       height: 18.w,
      //     ),
      //   ),
      // ),
    ];

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: Spacing.extraSmall,
        mainAxisSpacing: Spacing.extraSmall,
        childAspectRatio: 1.97,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return _Item(
            count: items[index].count,
            title: items[index].title,
            icon: items[index].themeSvgIcon,
          );
        },
        childCount: items.length,
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final double count;
  final String title;
  final ThemeSvgIcon icon;

  const _Item({
    required this.count,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.smMedium),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: LemonColor.atomicBlack,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LemonRadius.normal),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              SizedBox(width: Spacing.extraSmall),
              Text(
                count.toInt().toString(),
                style: Typo.extraMedium.copyWith(
                  color: colorScheme.onPrimary,
                  fontFamily: FontFamily.orbitron,
                ),
              ),
            ],
          ),
          SizedBox(height: Spacing.superExtraSmall),
          Text(
            title,
            style: Typo.medium.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
