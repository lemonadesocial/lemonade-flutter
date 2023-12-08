import 'package:app/core/presentation/widgets/app_lock/app_lock.dart';
import 'package:app/core/presentation/widgets/app_lock/widgets/pin_row.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/custom_number_keyboard/custom_number_keyboard.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class LemonAppLockPage extends StatefulWidget {
  final String? title;
  final String? description;
  final String? correctPin;

  const LemonAppLockPage({
    super.key,
    this.title,
    this.description,
    this.correctPin,
  });

  @override
  State<LemonAppLockPage> createState() => _LemonAppLockPageState();
}

class _LemonAppLockPageState extends State<LemonAppLockPage> {
  String pinCode = '';
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const LemonAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.title != null)
              Text(
                widget.title!,
                style: Typo.extraLarge.copyWith(
                  fontWeight: FontWeight.w800,
                  fontFamily: FontFamily.nohemiVariable,
                ),
              ),
            if (widget.description != null) ...[
              SizedBox(height: Spacing.small),
              Text(
                widget.description!,
                style: Typo.mediumPlus.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
            SizedBox(height: Spacing.medium),
            PinRow(
              pinCode: pinCode,
            ),
            if (hasError) ...[
              SizedBox(height: Spacing.extraSmall),
              Text(
                t.common.incorrectPin,
                style: Typo.medium.copyWith(
                  color: LemonColor.errorRedBg,
                ),
              ),
            ],
            const Spacer(),
            CustomNumberKeyboard(
              onBackspacePressed: () {
                if (pinCode.isEmpty) return;
                setState(() {
                  pinCode = pinCode.substring(0, pinCode.length - 1);
                  hasError = false;
                });
              },
              onClearPressed: () {
                setState(() {
                  pinCode = '';
                  hasError = false;
                });
              },
              onNumberPressed: (number) {
                if (pinCode.length == 6) {
                  return;
                }
                setState(() {
                  hasError = false;
                  pinCode = pinCode + number.toString();
                });
              },
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Spacing.smMedium,
                ),
                child: LinearGradientButton(
                  onTap: () {
                    if (pinCode.length < 6) {
                      return;
                    }
                    if (pinCode != widget.correctPin) {
                      setState(() {
                        hasError = true;
                      });
                      return;
                    }
                    AppLock.of(context)?.didUnlock();
                  },
                  label: t.common.confirm,
                  radius: BorderRadius.circular(LemonRadius.small * 2),
                  height: Sizing.large,
                  mode: GradientButtonMode.lavenderMode,
                  textStyle: Typo.medium.copyWith(
                    color: colorScheme.onPrimary.withOpacity(0.87),
                    fontFamily: FontFamily.nohemiVariable,
                    fontWeight: FontWeight.w600,
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
