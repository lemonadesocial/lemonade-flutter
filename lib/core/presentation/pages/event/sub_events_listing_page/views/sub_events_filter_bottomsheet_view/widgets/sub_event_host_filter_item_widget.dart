import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class SubEventHostFilterItemWidget extends StatelessWidget {
  final User host;
  final bool selected;
  final Function()? onTap;

  const SubEventHostFilterItemWidget({
    super.key,
    required this.host,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Row(
        children: [
          LemonNetworkImage(
            imageUrl: host.imageAvatar ?? '',
            width: Sizing.medium,
            height: Sizing.medium,
            borderRadius: BorderRadius.circular(Sizing.medium),
            placeholder: ImagePlaceholder.avatarPlaceholder(),
            border: Border.all(
              color: colorScheme.outline,
            ),
          ),
          SizedBox(width: Spacing.small),
          Expanded(
            child: Text(
              host.name ?? '',
              style: Typo.medium.copyWith(
                color:
                    selected ? colorScheme.onPrimary : colorScheme.onSecondary,
              ),
            ),
          ),
          SizedBox(width: Spacing.small),
          ThemeSvgIcon(
            color: selected ? colorScheme.onPrimary : colorScheme.onSecondary,
            builder: (filter) => selected
                ? Assets.icons.icChecked.svg(
                    colorFilter: filter,
                  )
                : Assets.icons.icUncheck.svg(
                    colorFilter: filter,
                  ),
          ),
        ],
      ),
    );
  }
}
