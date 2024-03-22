import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/bottomsheet/lemon_snap_bottom_sheet_widget.dart';
import 'package:app/core/utils/device_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AddVaultBottomSheet extends StatelessWidget {
  const AddVaultBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return LemonSnapBottomSheet(
      defaultSnapSize: DeviceUtils.hasNotch() ? 0.71 : 0.75,
      backgroundColor: LemonColor.atomicBlack,
      builder: (scrollController) => SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(LemonRadius.large),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LemonAppBar(
                backgroundColor: LemonColor.atomicBlack,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.vault.createVaultBottomSheet.title,
                      style: Typo.extraLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        fontFamily: FontFamily.nohemiVariable,
                      ),
                    ),
                    SizedBox(height: Spacing.superExtraSmall),
                    Text(
                      t.vault.createVaultBottomSheet.subTitle,
                      style: Typo.mediumPlus.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                    SizedBox(height: Spacing.medium),
                    _CreateVaultOptionItem(
                      onPressed: () {
                        Navigator.of(context).pop();
                        AutoRouter.of(context).push(const CreateVaultRoute());
                      },
                      title: t.vault.vaultType.individual,
                      description:
                          t.vault.createVaultBottomSheet.individualDescription,
                      icon: Assets.icons.icProfile.svg(
                        width: Sizing.small,
                        height: Sizing.small,
                      ),
                      iconBackground: colorScheme.onPrimary.withOpacity(0.06),
                      gradientColors: const [
                        Color(0xff232323),
                        Color(0xff252525),
                        Color(0xff282828),
                        Color(0xff343434),
                      ],
                    ),
                    SizedBox(height: Spacing.xSmall),
                    _CreateVaultOptionItem(
                      onPressed: () =>
                          SnackBarUtils.showComingSoon(),
                      title: t.vault.vaultType.community,
                      description:
                          t.vault.createVaultBottomSheet.communityDescription,
                      icon: Assets.icons.icGuestsGradient.svg(
                        width: Sizing.small,
                        height: Sizing.small,
                      ),
                      iconBackground: LemonColor.paleViolet18,
                      gradientColors: const [
                        Color(0xff232323),
                        Color(0xff262626),
                        Color(0xff383442),
                        Color(0xff484255),
                      ],
                    ),
                    SizedBox(height: Spacing.medium),
                    // TODO: temporary hide
                    // InkWell(
                    //   onTap: () => SnackBarUtils.showComingSoon(),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text(
                    //         t.vault.createVaultBottomSheet.alreadyHaveVault,
                    //         style: Typo.medium.copyWith(
                    //           color: colorScheme.onSecondary,
                    //         ),
                    //       ),
                    //       SizedBox(width: Spacing.superExtraSmall),
                    //       Text(
                    //         t.vault.createVaultBottomSheet.restore,
                    //         style: Typo.medium.copyWith(
                    //           color: LemonColor.paleViolet,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateVaultOptionItem extends StatelessWidget {
  final List<Color> gradientColors;
  final Color iconBackground;
  final Widget icon;
  final String title;
  final String description;
  final Function() onPressed;

  const _CreateVaultOptionItem({
    required this.title,
    required this.description,
    required this.gradientColors,
    required this.iconBackground,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(Spacing.medium),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LemonRadius.normal),
          gradient: LinearGradient(
            stops: const [0.25, 0.5, 0.75, 1],
            colors: gradientColors,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Sizing.large,
              height: Sizing.large,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(Sizing.large),
              ),
              child: Center(
                child: icon,
              ),
            ),
            SizedBox(width: Spacing.smMedium),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: Typo.mediumPlus.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: Spacing.superExtraSmall),
                  Text(
                    description,
                    style: Typo.small.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height: Spacing.xSmall),
                  Row(
                    children: [
                      Text(
                        t.vault.poweredBy,
                        style: Typo.xSmall.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                      SizedBox(width: Spacing.superExtraSmall),
                      Assets.icons.icSafe.svg(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
