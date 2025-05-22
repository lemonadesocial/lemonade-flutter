import 'package:app/core/domain/vault/vault_enums.dart';
import 'package:app/core/presentation/widgets/animation/ripple_animation.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class CreateVaultSuccessPage extends StatelessWidget {
  final Widget? Function(BuildContext context)? buttonBuilder;
  final Function(BuildContext context)? onPressed;
  final VaultType? vaultType;
  final String? vaultName;

  const CreateVaultSuccessPage({
    super.key,
    this.buttonBuilder,
    this.onPressed,
    this.vaultType,
    this.vaultName,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const _SuccessCircle(),
                SizedBox(
                  height: 56.w,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.xLarge),
                  child: Text(
                    '${t.common.done} 🎉',
                    style: Typo.extraLarge.copyWith(
                      fontFamily: FontFamily.clashDisplay,
                      fontWeight: FontWeight.w900,
                      height: 1.2,
                    ),
                  ),
                ),
                SizedBox(height: Spacing.superExtraSmall),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.xLarge),
                  child: Text(
                    t.vault.createVault.createVaultSuccess(
                      vaultType: vaultType == VaultType.individual
                          ? t.vault.vaultType.individual
                          : t.vault.vaultType.community,
                      name: vaultName ?? '',
                    ),
                    style: Typo.mediumPlus.copyWith(
                      fontWeight: FontWeight.w400,
                      color: colorScheme.onSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: Spacing.xLarge),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.xLarge),
                  child: buttonBuilder != null
                      ? buttonBuilder?.call(context)
                      : LinearGradientButton(
                          onTap: () => onPressed?.call(context),
                          mode: GradientButtonMode.lavenderMode,
                          height: Sizing.large,
                          textStyle: Typo.medium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onPrimary.withOpacity(0.87),
                            fontFamily: FontFamily.clashDisplay,
                          ),
                          radius: BorderRadius.circular(LemonRadius.small * 2),
                          label: t.vault.createVault.enterVault,
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SuccessCircle extends StatelessWidget {
  const _SuccessCircle();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 450.w,
      height: 450.w,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: LayoutBuilder(
              builder: (context, constraints) => Transform.scale(
                scale: 1.5,
                child: RippleAnimation(
                  size: constraints.maxWidth,
                  color: const Color.fromRGBO(12, 20, 17, 1),
                  scaleTween: Tween<double>(begin: 0.3, end: 1),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                gradient: const RadialGradient(
                  colors: [
                    Colors.black,
                    Color.fromRGBO(12, 20, 17, 1),
                  ],
                  stops: [
                    0.5,
                    1,
                  ],
                ),
                borderRadius: BorderRadius.circular(240.w),
              ),
              width: 240.w,
              height: 240.w,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Assets.icons.icSuccess.svg(),
          ),
        ],
      ),
    );
  }
}
