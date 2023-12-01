import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddVaultButton extends StatelessWidget {
  const AddVaultButton({super.key, this.onPressAdd});

  final Function()? onPressAdd;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onPressAdd,
      child: DottedBorder(
        dashPattern: [5.w],
        color: colorScheme.outline,
        borderType: BorderType.RRect,
        padding: EdgeInsets.all(Spacing.smMedium),
        radius: Radius.circular(LemonRadius.xSmall),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icBank.svg(
                colorFilter: filter,
              ),
            ),
            SizedBox(width: Spacing.extraSmall),
            Text(
              t.vault.newVault,
              style: Typo.medium.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
