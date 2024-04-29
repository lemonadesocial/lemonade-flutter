import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class _ItemData {
  final String title;
  final ThemeSvgIcon themeSvgIcon;

  _ItemData({required this.title, required this.themeSvgIcon});
}

class CollaboratorDiscoverActivitySection extends StatelessWidget {
  const CollaboratorDiscoverActivitySection({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final List<_ItemData> items = [
      _ItemData(
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
      _ItemData(
        title: t.collaborator.nftCreated,
        themeSvgIcon: ThemeSvgIcon(
          color: LemonColor.venetianRed,
          builder: (colorFilter) => Assets.icons.icCrystal.svg(
            colorFilter: colorFilter,
            width: 18.w,
            height: 18.w,
          ),
        ),
      ),
      _ItemData(
        title: t.collaborator.nftCollected,
        themeSvgIcon: ThemeSvgIcon(
          builder: (colorFilter) => Assets.icons.icStarCircle.svg(
            width: 18.w,
            height: 18.w,
          ),
        ),
      ),
    ];

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: Spacing.extraSmall,
        mainAxisSpacing: Spacing.extraSmall,
        childAspectRatio: 3,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return _Item(
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
  final String title;
  final ThemeSvgIcon icon;

  const _Item({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Spacing.smMedium),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: LemonColor.white06,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LemonRadius.normal),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          SizedBox(width: Spacing.extraSmall),
          Expanded(
            child: Text(
              title,
              style: Typo.medium.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: Spacing.extraSmall),
          ThemeSvgIcon(
            builder: (colorFilter) => Assets.icons.icExpand.svg(
              colorFilter: colorFilter,
              width: 18.w,
              height: 18.w,
            ),
          ),
        ],
      ),
    );
  }
}
