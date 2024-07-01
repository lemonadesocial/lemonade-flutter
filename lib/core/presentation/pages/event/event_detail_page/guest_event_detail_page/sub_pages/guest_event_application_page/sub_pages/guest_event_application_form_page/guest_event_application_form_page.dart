import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/event_application_form_bloc/event_application_form_bloc.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/sub_pages/guest_event_application_page/sub_pages/guest_event_application_form_page/widgets/guest_event_application_form_answers_items.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/sub_pages/guest_event_application_page/sub_pages/guest_event_application_form_page/widgets/guest_event_application_form_profile_items.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

@RoutePage()
class GuestEventApplicationFormPage extends StatelessWidget {
  const GuestEventApplicationFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const LemonAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Text(
                        t.event.applicationForm.applicationForm,
                        style: Typo.extraLarge.copyWith(
                          color: colorScheme.onPrimary,
                          fontFamily: FontFamily.nohemiVariable,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: Spacing.superExtraSmall,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Text(
                        t.event.applicationForm.applicationFormDescription,
                        style: Typo.mediumPlus.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: Spacing.medium,
                      ),
                    ),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return state.when(
                          unknown: () {
                            return SliverToBoxAdapter(
                              child: EmptyList(
                                emptyText: t.common.somethingWrong,
                              ),
                            );
                          },
                          processing: () {
                            return SliverToBoxAdapter(
                              child: Loading.defaultLoading(context),
                            );
                          },
                          authenticated: (User user) {
                            return SliverToBoxAdapter(
                              child: Column(
                                children: [
                                  const GuestEventApplicationFormProfileItems(),
                                  SizedBox(
                                    height: Spacing.extraSmall,
                                  ),
                                  const GuestEventApplicationFormAnswersItems(),
                                ],
                              ),
                            );
                          },
                          unauthenticated: (bool isChecking) {
                            return SliverToBoxAdapter(
                              child: EmptyList(
                                emptyText: t.common.somethingWrong,
                              ),
                            );
                          },
                          onBoardingRequired: (User authSession) {
                            return const SizedBox();
                          },
                        );
                      },
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: Spacing.xLarge * 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.background,
                  border: Border(
                    top: BorderSide(
                      color: colorScheme.outline,
                    ),
                  ),
                ),
                padding: EdgeInsets.all(Spacing.smMedium),
                child: SafeArea(
                  child: BlocBuilder<EventApplicationFormBloc,
                      EventApplicationFormBlocState>(
                    builder: (context, state) => Opacity(
                      opacity: state.isValid ? 1 : 0.5,
                      child: LinearGradientButton.primaryButton(
                        onTap: () {
                          if (!state.isValid) return;
                          Vibrate.feedback(FeedbackType.light);
                          FocusManager.instance.primaryFocus?.unfocus();
                          AutoRouter.of(context).replaceAll([
                            const GuestEventApplicationFormProcessingRoute(),
                          ]);
                        },
                        label: t.common.actions.submit,
                        textColor: colorScheme.onPrimary,
                      ),
                    ),
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
