import 'package:app/core/application/vault/create_vault_verify_seed_phrase_bloc/create_vault_verify_seed_phrase_bloc.dart';
import 'package:app/core/presentation/pages/vault/create_vault_page/sub_pages/create_vault_check_phrase_page/widgets/phrase_check_answers_options.dart';
import 'package:app/core/presentation/pages/vault/create_vault_page/sub_pages/create_vault_check_phrase_page/widgets/phrase_check_placeholder.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/string_utils.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class CreateVaultCheckPhrasePage extends StatelessWidget {
  final String? seedPhrase;
  CreateVaultCheckPhrasePage({
    super.key,
    this.seedPhrase,
  }) {
    assert(seedPhrase?.isNotEmpty == true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CreateVaultVerifySeedPhraseBloc(seedPhrase: seedPhrase!)
            ..add(
              CreateVaultVerifySeedPhraseEvent.generateQuestions(),
            ),
      child: CreateVaultCheckPhrasePageView(
        seedPhrase: seedPhrase!,
      ),
    );
  }
}

class CreateVaultCheckPhrasePageView extends StatelessWidget {
  final String seedPhrase;
  const CreateVaultCheckPhrasePageView({
    super.key,
    required this.seedPhrase,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final phrases = seedPhrase.split(" ");
    return BlocConsumer<CreateVaultVerifySeedPhraseBloc,
        CreateVaultVerifySeedPhraseState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          completed: (data) {
            AutoRouter.of(context).replaceAll([
              const CreateVaultSubmitTransactionRoute(),
            ]);
          },
        );
      },
      builder: (context, state) {
        if (state is CreateVaultVerifySeedPhraseStateInitial) {
          return Scaffold(
            body: Loading.defaultLoading(context),
          );
        }
        final correctWordIndex =
            state.data.questions[state.data.currentQuestion].wordIndex;
        final totalQuestions =
            context.read<CreateVaultVerifySeedPhraseBloc>().totalQuestions;
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
                    crossAxisCount: totalQuestions,
                    childAspectRatio: 42.w / 4.w,
                    children: List.generate(totalQuestions, (index) {
                      final isActive = index < state.data.currentQuestion;
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.w),
                          color: isActive
                              ? LemonColor.paleViolet
                              : LemonColor.chineseBlack,
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
                  t.vault.createVault.recoveryCheckQuestion(
                    order: StringUtils.ordinal(correctWordIndex + 1),
                  ),
                  style: Typo.mediumPlus.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: Spacing.medium),
                PhraseCheckPlaceholder(
                  state: state,
                  phrases: phrases,
                ),
                SizedBox(height: Spacing.medium),
                PhraseCheckAnswersOptions(
                  state: state,
                  phrases: phrases,
                ),
                SizedBox(height: Spacing.xSmall),
                const Spacer(),
                Container(
                  padding: EdgeInsets.only(bottom: Spacing.smMedium),
                  width: double.infinity,
                  child: SafeArea(
                    child: state.maybeWhen(
                      incorrect: (data) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LinearGradientButton(
                              onTap: () {
                                context
                                    .read<CreateVaultVerifySeedPhraseBloc>()
                                    .add(
                                      CreateVaultVerifySeedPhraseEvent
                                          .generateQuestions(),
                                    );
                              },
                              label: t.common.actions.restart,
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
                          ],
                        );
                      },
                      orElse: () {
                        return Column(
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
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
