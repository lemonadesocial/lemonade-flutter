import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/bottomsheet/lemon_snap_bottom_sheet_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_button_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowRecoveryPhraseBottomSheet extends StatelessWidget {
  final String seedPhrase;
  final Function()? onNext;

  const ShowRecoveryPhraseBottomSheet({
    super.key,
    required this.seedPhrase,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final words = seedPhrase.split(" ");
    return SizedBox(
      height: 0.65.sh,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(LemonRadius.small),
        child: Scaffold(
          bottomSheet: LemonSnapBottomSheet(
            defaultSnapSize: 1,
            backgroundColor: LemonColor.atomicBlack,
            builder: (scrollController) {
              return Column(
                children: [
                  LemonAppBar(
                    backgroundColor: LemonColor.atomicBlack,
                    actions: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          LemonButton(
                            onTap: () {
                              SnackBarUtils.showSuccessSnackbar(
                                  t.common.copiedToClipboard);
                            },
                            width: 80.w,
                            icon: Assets.icons.icCopy.svg(),
                            label: t.common.actions.copy,
                          ),
                          SizedBox(width: Spacing.smMedium),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.vault.createVault.recoveryPhrase,
                          style: Typo.extraLarge.copyWith(
                            fontFamily: FontFamily.nohemiVariable,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: Spacing.superExtraSmall),
                        Text(
                          t.vault.createVault.recoveryPhraseDescription,
                          style: Typo.mediumPlus.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                        SizedBox(height: Spacing.medium),
                        SizedBox(
                          height: 200.w,
                          child: GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: Spacing.extraSmall,
                            mainAxisSpacing: Spacing.extraSmall,
                            crossAxisCount: 3,
                            childAspectRatio: 107.w / 42.w,
                            children: words.asMap().entries.map((entry) {
                              return Container(
                                height: 42.w,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Spacing.small),
                                decoration: BoxDecoration(
                                  color: LemonColor.paleViolet18,
                                  borderRadius:
                                      BorderRadius.circular(LemonRadius.xSmall),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      (entry.key + 1).toString(),
                                      style: Typo.small.copyWith(
                                        color: LemonColor.paleViolet,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      entry.value,
                                      style: Typo.small.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: Spacing.smMedium),
                        SafeArea(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: Spacing.smMedium,
                            ),
                            child: LinearGradientButton(
                              onTap: () {
                                onNext?.call();
                              },
                              label: t.common.next,
                              radius:
                                  BorderRadius.circular(LemonRadius.small * 2),
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
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
