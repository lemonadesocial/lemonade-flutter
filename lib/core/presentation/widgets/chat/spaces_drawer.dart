import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class SpaceItem {
  final String icon;
  final String label;
  final String subLabel;
  final bool? selected;
  SpaceItem(
      {required this.icon,
      required this.label,
      required this.subLabel,
      this.selected});
}

class SpacesDrawer extends StatelessWidget {
  const SpacesDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Drawer(
        width: 300,
        backgroundColor: colorScheme.primary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: Spacing.small,
                horizontal: Spacing.smMedium,
              ),
              child: Row(children: [
                Text("Spaces",
                    style:
                        Typo.extraMedium.copyWith(color: colorScheme.onPrimary))
              ]),
            ),
            ...[
              SpaceItem(
                  icon:
                      'https://play-lh.googleusercontent.com/AwVn1UZPqMMEPFR0jWqlmMFA8veTG3T-DRZ_BQjQahShQxAa8_7Cu5Fe9tlnRVTHPTGK',
                  label: "Lemonade",
                  subLabel: 'lemonade.social',
                  selected: true),
              SpaceItem(
                  icon:
                      'https://images.lemonade.social/eyJidWNrZXQiOiJsZW1vbmFkZS11cGxvYWRzLWV1LWNlbnRyYWwtMSIsImtleSI6IjY0YmZlNTU1YTRhZTUyY2ExMTQ3NmRjZi9waG90b3MvNjRiZmU1OGJkNjIyYTk3NGMyNTI0NTQyLnBuZyIsImVkaXRzIjp7InJlc2l6ZSI6eyJoZWlnaHQiOjUxMiwid2lkdGgiOjUxMiwiZml0IjoiY292ZXIifX19',
                  label: "HER Nation",
                  subLabel: 'hernation.ai'),
              SpaceItem(
                  icon:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlDsismHhyTIf7eybUn4kw16dU-y6vm35yPMOf9yTGIvdFIjKQcEWZ3TmyECsr2Be6mbE&usqp=CAU',
                  label: "PopEx",
                  subLabel: 'lemonade.popex.net'),
            ].map((item) => _buildSpaceItem(context, item: item)),
            Spacer(),
            _buildSpaceActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSpaceItem(
    BuildContext context, {
    required SpaceItem item,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    var selected = item.selected ?? false;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Spacing.small),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
            10), // Set the border radius for the blue container
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: Spacing.xSmall,
            horizontal: Spacing.xSmall,
          ),
          color: selected ? LemonColor.white15 : Colors.transparent,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  item.icon,
                  width: 42,
                  height: 42,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: Spacing.xSmall),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.label,
                    style: Typo.medium.copyWith(color: colorScheme.onPrimary, fontFamily: FontFamily.switzerVariable),
                  ),
                  Text(
                    item.subLabel,
                    style: Typo.small.copyWith(color: LemonColor.white36),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpaceActions(
    context,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Spacing.small),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: Spacing.xSmall,
              horizontal: Spacing.xSmall,
            ),
            child: Row(
              children: [
                ThemeSvgIcon(
                  color: colorScheme.onPrimary,
                  builder: (filter) => Assets.icons.icoCreateSpace.svg(
                    colorFilter: filter,
                  ),
                ),
                SizedBox(width: Spacing.small),
                Text(
                  "Create space",
                  style: Typo.medium.copyWith(color: colorScheme.onPrimary),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: Spacing.xSmall,
              horizontal: Spacing.xSmall,
            ),
            child: Row(
              children: [
                ThemeSvgIcon(
                  color: colorScheme.onPrimary,
                  builder: (filter) => Assets.icons.icJoinSpace.svg(
                    colorFilter: filter,
                  ),
                ),
                SizedBox(width: Spacing.small),
                Text(
                  "Join space",
                  style: Typo.medium.copyWith(color: colorScheme.onPrimary),
                )
              ],
            ),
          ),
          SizedBox(
            height: Spacing.medium,
          ),
        ],
      ),
    );
  }
}
