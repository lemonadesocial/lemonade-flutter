import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingDeleteAccountDialog extends StatefulWidget {
  const SettingDeleteAccountDialog({super.key});

  @override
  State<SettingDeleteAccountDialog> createState() =>
      _SettingDeleteAccountDialogState();
}

class _SettingDeleteAccountDialogState
    extends State<SettingDeleteAccountDialog> {
  String? confirmText;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return AlertDialog(
      backgroundColor: colorScheme.primary,
      insetPadding: EdgeInsets.all(Spacing.medium),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(LemonRadius.normal),
        ),
        side: BorderSide(
          color: colorScheme.outline,
          width: 2.w,
        ),
      ),
      title: Text(
        t.setting.deleteAccountDialog,
        style: Typo.large.copyWith(
          fontWeight: FontWeight.w800,
          color: colorScheme.onPrimary,
        ),
      ),
      content: SizedBox(
        width: 1.sw,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.setting.deleteAccountDialogDesc,
              style: Typo.mediumPlus.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
            SizedBox(height: Spacing.superExtraSmall),
            LemonTextField(
              hintText: t.setting.deleteAccountDialogHint,
              placeholderStyle: Typo.medium.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              onChange: (value) => setState(() {
                confirmText = value;
              }),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            LinearGradientButton(
              label: t.common.actions.ok,
              mode: confirmText != t.setting.deleteAccountConfirmText
                  ? GradientButtonMode.defaultMode
                  : GradientButtonMode.lavenderMode,
              onTap: confirmText != t.setting.deleteAccountConfirmText
                  ? null
                  : () => context.router.pop(true),
            ),
            SizedBox(width: Spacing.small),
            LinearGradientButton(
              label: t.common.actions.cancel,
              onTap: () => context.router.pop(false),
            ),
            SizedBox(width: Spacing.small),
          ],
        ),
        SizedBox(height: Spacing.superExtraSmall),
      ],
    );
  }
}
