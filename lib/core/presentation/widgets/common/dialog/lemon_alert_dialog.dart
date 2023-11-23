import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class LemonAlertDialog extends StatelessWidget {
  final Widget child;
  final String? buttonLabel;
  final Function()? onClose;
  final bool? closable;
  final String? title;
  final TextStyle? titleStyle;

  const LemonAlertDialog({
    super.key,
    required this.child,
    this.title,
    this.titleStyle,
    this.buttonLabel,
    this.onClose,
    this.closable = false,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Dialog(
      backgroundColor: LemonColor.atomicBlack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Container(
        padding: EdgeInsets.all(Spacing.medium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (closable == true || title != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (title != null)
                    Flexible(
                      flex: 3,
                      child: Text(
                        title!,
                        style: titleStyle ??
                            Typo.extraMedium
                                .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  const Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  if (closable == true)
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Assets.icons.icClose.svg(
                        width: Sizing.small,
                        height: Sizing.small,
                      ),
                    ),
                ],
              ),
            child,
            SizedBox(height: Spacing.small),
            LinearGradientButton(
              onTap: () => onClose != null
                  ? onClose?.call()
                  : Navigator.of(context).pop(),
              label: buttonLabel ?? t.common.actions.dismiss,
              mode: GradientButtonMode.lavenderMode,
            ),
          ],
        ),
      ),
    );
  }
}
