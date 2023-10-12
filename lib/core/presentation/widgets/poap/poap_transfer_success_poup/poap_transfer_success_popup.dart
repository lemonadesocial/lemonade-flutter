import 'package:app/core/domain/token/entities/token_entities.dart';
import 'package:app/core/presentation/widgets/animation/ripple_animation.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PoapTransferSuccessPopup extends StatelessWidget {
  const PoapTransferSuccessPopup({
    super.key,
    this.token,
    required this.onClose,
  });

  final TokenDetail? token;
  final Function() onClose;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LemonRadius.small),
      ),
      backgroundColor: LemonColor.dialogBackground,
      insetPadding: EdgeInsets.only(
        left: Spacing.smMedium,
        right: Spacing.smMedium,
      ),
      child: SizedBox(
        height: 0.6465.sh,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            LemonRadius.small,
          ),
          child: Stack(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) => Transform.scale(
                      scale: 1.8,
                      child: RippleAnimation(
                        size: constraints.maxWidth,
                        color: LemonColor.rippleDark,
                        scaleTween: Tween<double>(begin: 0.3, end: 1),
                      ),
                    ),
                  ),
                  Assets.icons.icSuccess.svg(),
                ],
              ),
              Transform.translate(
                offset: Offset(0, -Spacing.medium),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.medium),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          t.nft.transferred,
                          style: Typo.extraLarge.copyWith(
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.nohemiVariable,
                          ),
                        ),
                        SizedBox(height: Spacing.extraSmall),
                        Text(
                          t.nft.transferSuccess(
                            tokenName: token?.metadata?.name ?? '',
                          ),
                          style: Typo.mediumPlus.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: Spacing.medium),
                        SizedBox(
                          height: 42.w,
                          child: LinearGradientButton(
                            label: '${t.common.done}!',
                            onTap: () => onClose.call(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
