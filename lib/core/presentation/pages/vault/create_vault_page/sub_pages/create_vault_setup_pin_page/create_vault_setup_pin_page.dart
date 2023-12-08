import 'package:app/core/application/payment/get_payment_accounts_bloc/get_payment_accounts_bloc.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/input/get_payment_accounts_input/get_payment_accounts_input.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/domain/vault/vault_enums.dart';
import 'package:app/core/presentation/widgets/app_lock/widgets/pin_row.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/custom_number_keyboard/custom_number_keyboard.dart';
import 'package:app/core/service/vault/vault_secure_storage.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CreateVaultSetupPinPage extends StatefulWidget {
  final String? defaultPinCode;
  final String? title;
  final String? description;
  final PaymentAccount? vault;

  const CreateVaultSetupPinPage({
    super.key,
    this.defaultPinCode,
    this.title,
    this.description,
    this.vault,
  });

  @override
  State<CreateVaultSetupPinPage> createState() =>
      _CreateVaultSetupPinPageState();
}

class _CreateVaultSetupPinPageState extends State<CreateVaultSetupPinPage> {
  String pinCode = '';
  bool hasError = false;

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
              widget.title ?? t.vault.createPIN.setPIN,
              style: Typo.extraLarge.copyWith(
                fontWeight: FontWeight.w800,
                fontFamily: FontFamily.nohemiVariable,
              ),
            ),
            SizedBox(height: Spacing.small),
            Text(
              widget.description ?? t.vault.createPIN.setPINDescription,
              style: Typo.mediumPlus.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
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
                  pinCode = pinCode + number.toString();
                  hasError = false;
                });
              },
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Spacing.smMedium,
                ),
                child: LinearGradientButton(
                  onTap: () async {
                    if (pinCode.length < 6) {
                      return;
                    }
                    // setup pin
                    if (widget.defaultPinCode == null) {
                      AutoRouter.of(context).push(
                        CreateVaultSetupPinRoute(
                          vault: widget.vault,
                          defaultPinCode: pinCode,
                          title: t.vault.createPIN.confirmPIN,
                        ),
                      );
                    }

                    // confirm pin
                    if (widget.defaultPinCode != null) {
                      if (pinCode == widget.defaultPinCode) {
                        final userId = AuthUtils.getUserId(context);
                        await VaultSecureStorage.setPinCode(
                          userId: userId,
                          pinCode: pinCode,
                        );
                        AutoRouter.of(context).replaceAll([
                          CreateVaultSuccessRoute(
                            vaultName: widget.vault?.title,
                            vaultType: VaultType.individual,
                            onPressed: (innerContext) {
                              innerContext.read<GetPaymentAccountsBloc>().add(
                                    GetPaymentAccountsEvent.fetch(
                                      input: GetPaymentAccountsInput(
                                        type: PaymentAccountType.ethereum,
                                        provider: PaymentProvider.safe,
                                      ),
                                    ),
                                  );
                              AutoRouter.of(innerContext).pop();
                            },
                          ),
                        ]);
                        return;
                      }

                      setState(() {
                        hasError = true;
                      });
                    }
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
