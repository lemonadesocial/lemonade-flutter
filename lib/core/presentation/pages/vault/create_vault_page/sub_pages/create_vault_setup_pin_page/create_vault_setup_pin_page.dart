import 'package:app/core/presentation/pages/vault/create_vault_page/sub_pages/create_vault_setup_pin_page/widgets/pin_row.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/custom_number_keyboard/custom_number_keyboard.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CreateVaultSetupPinPage extends StatefulWidget {
  const CreateVaultSetupPinPage({super.key});

  @override
  State<CreateVaultSetupPinPage> createState() =>
      _CreateVaultSetupPinPageState();
}

class _CreateVaultSetupPinPageState extends State<CreateVaultSetupPinPage> {
  String pinCode = '';

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const LemonAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.vault.createPIN.setPIN,
              style: Typo.extraLarge.copyWith(
                fontWeight: FontWeight.w800,
                fontFamily: FontFamily.nohemiVariable,
              ),
            ),
            SizedBox(height: Spacing.small),
            Text(
              t.vault.createPIN.setPINDescription,
              style: Typo.mediumPlus.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
            SizedBox(height: Spacing.medium),
            PinRow(
              pinCode: pinCode,
            ),
            const Spacer(),
            CustomNumberKeyboard(
              onBackspacePressed: () {
                if (pinCode.isEmpty) return;
                setState(() {
                  pinCode = pinCode.substring(0, pinCode.length - 1);
                });
              },
              onClearPressed: () {
                setState(() {
                  pinCode = '';
                });
              },
              onNumberPressed: (number) {
                if (pinCode.length == 6) {
                  return;
                }
                setState(() {
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
                  onTap: () {},
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
