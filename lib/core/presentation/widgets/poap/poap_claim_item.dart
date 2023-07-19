import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class POAPClaimItem extends StatelessWidget {
  const POAPClaimItem({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Spacing.small, vertical: Spacing.small),
      decoration: ShapeDecoration(
        color: colorScheme.surfaceVariant,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LemonRadius.small),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPoapImage(),
          SizedBox(width: Spacing.small),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildPoapInfo(colorScheme),
                SizedBox(height: Spacing.xSmall),
                _buildPoapQuantityBar(colorScheme),
                SizedBox(height: Spacing.small),
                _buildButtons(colorScheme),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPoapImage() {
    return Container(
      width: 72,
      height: 72,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: "https://i.pinimg.com/originals/02/3a/bc/023abc27a2a99211090dcbde0ba6bf2e.png",
          errorWidget: (_, __, ___) => ImagePlaceholder.defaultPlaceholder(
            radius: BorderRadius.circular(LemonRadius.extraSmall),
          ),
          placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(
            radius: BorderRadius.circular(LemonRadius.extraSmall),
          ),
        ),
      ),
    );
  }

  Widget _buildPoapInfo(ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Raging Burger",
          style: Typo.medium.copyWith(fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        SizedBox(height: 2),
        Text(
          "Burger Nation",
          style: Typo.small.copyWith(color: colorScheme.onSurfaceVariant),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildPoapQuantityBar(ColorScheme colorScheme) {
    final smallTextStyle = Typo.small.copyWith(color: colorScheme.onSurfaceVariant);
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: LinearProgressIndicator(
            value: 12 / 100,
            color: LemonColor.paleViolet,
            backgroundColor: LemonColor.paleViolet18,
            minHeight: 2,
          ),
        ),
        SizedBox(height: Spacing.extraSmall),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text("12 claimed", style: smallTextStyle),
            Text("100", style: smallTextStyle),
          ],
        ),
      ],
    );
  }

  Widget _buildButtons(ColorScheme colorScheme) {
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          LemonOutlineButton(
            onTap: () {},
            leading: ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icShare.svg(
                colorFilter: filter,
                width: Sizing.xSmall,
                height: Sizing.xSmall,
              ),
            ),
            radius: BorderRadius.circular(LemonRadius.extraSmall),
            padding: EdgeInsets.symmetric(horizontal: Spacing.superExtraSmall, vertical: Spacing.superExtraSmall),
          ),
          SizedBox(width: Spacing.superExtraSmall),
          LemonOutlineButton(
            onTap: () {},
            leading: ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icNavigationLine.svg(colorFilter: filter),
            ),
            label: "1.2km",
            radius: BorderRadius.circular(LemonRadius.extraSmall),
            padding: EdgeInsets.symmetric(horizontal: Spacing.extraSmall, vertical: Spacing.superExtraSmall),
          ),
          Spacer(),
          LinearGradientButton(
            label: "claim",
            leading: Assets.icons.icDownload.svg(),
            padding: EdgeInsets.symmetric(horizontal: Spacing.extraSmall, vertical: Spacing.extraSmall),
            radius: BorderRadius.circular(LemonRadius.extraSmall),
          )
        ],
      ),
    );
  }
}
