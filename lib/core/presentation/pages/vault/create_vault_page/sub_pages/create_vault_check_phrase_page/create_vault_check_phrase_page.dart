import 'package:app/core/presentation/pages/vault/create_vault_page/sub_pages/create_vault_check_phrase_page/widgets/phrase_check_answers_options.dart';
import 'package:app/core/presentation/pages/vault/create_vault_page/sub_pages/create_vault_check_phrase_page/widgets/phrase_check_placeholder.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class CreateVaultCheckPhrasePage extends StatelessWidget {
  const CreateVaultCheckPhrasePage({super.key});

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
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 4.w,
              child: GridView.count(
                crossAxisSpacing: Spacing.superExtraSmall,
                crossAxisCount: 7,
                childAspectRatio: 42.w / 4.w,
                children: List.filled(7, 0).map((item) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.w),
                      color: LemonColor.paleViolet,
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: Spacing.xSmall * 3),
            Text(
              t.vault.createVault.recoveryPhraseCheck,
              style: Typo.extraLarge.copyWith(
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.nohemiVariable,
              ),
            ),
            SizedBox(height: Spacing.superExtraSmall),
            Text(
              t.vault.createVault.recoveryCheckQuestion(order: '7th'),
              style: Typo.mediumPlus.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
            SizedBox(height: Spacing.medium),
            const PhraseCheckPlaceholder(),
            SizedBox(height: Spacing.medium),
            const PhraseCheckAnswersOptions(),
            SizedBox(height: Spacing.xSmall),
            const Spacer(),
            Container(
              padding: EdgeInsets.only(bottom: Spacing.smMedium),
              width: double.infinity,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ThemeSvgIcon(
                      color: colorScheme.onSurfaceVariant,
                      builder: (filter) => Assets.icons.icHome.svg(
                        width: Sizing.small,
                        height: Sizing.small,
                        colorFilter: filter,
                      ),
                    ),
                    SizedBox(height: Spacing.small),
                    Text(
                      t.vault.createVault.securityRemind,
                      style: Typo.medium.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
