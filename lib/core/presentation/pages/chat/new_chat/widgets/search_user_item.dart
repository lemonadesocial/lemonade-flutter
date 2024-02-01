import 'package:app/core/presentation/widgets/chat/matrix_avatar.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchUserItem extends StatelessWidget {
  final String name;
  final Uri? avatarUrl;
  final bool isSelected;
  final void Function() onTap;

  const SearchUserItem({
    required this.name,
    this.avatarUrl,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  Widget buildAvatar() {
    return MatrixAvatar(
      size: 27.w,
      radius: 6.w,
      mxContent: avatarUrl,
      name: name,
      fontSize: Typo.small.fontSize!,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Spacing.extraSmall,
          horizontal: Spacing.small,
        ),
        child: Row(
          children: [
            buildAvatar(),
            SizedBox(width: Spacing.xSmall),
            Expanded(
              child: Text(
                name,
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(width: Spacing.xSmall),
            Container(
              child: isSelected
                  ? ThemeSvgIcon(
                      builder: (filter) => Assets.icons.icChecked.svg(),
                    )
                  : ThemeSvgIcon(
                      builder: (filter) => Assets.icons.icUncheck.svg(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
