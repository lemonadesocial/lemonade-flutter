import 'package:app/core/application/event/event_application_form_setting_bloc/event_application_form_setting_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_application_form_setting_page/sub_pages/event_application_form_page/widgets/application_form_questions.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class EventApplicationFormQuestionsPage extends StatelessWidget {
  final _scrollController = ScrollController();

  EventApplicationFormQuestionsPage({super.key});

  scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeIn,
    );
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final eventId = context.watch<GetEventDetailBloc>().state.maybeWhen(
          fetched: (event) => event.id ?? '',
          orElse: () => '',
        );
    final getEventDetailBloc = context.read<GetEventDetailBloc>();
    return Scaffold(
      appBar: const LemonAppBar(),
      resizeToAvoidBottomInset: false,
      body: BlocListener<EventApplicationFormSettingBloc,
          EventApplicationFormSettingBlocState>(
        listener: (context, state) {
          if (state.status == EventApplicationFormStatus.success) {
            AutoRouter.of(context).back();
            SnackBarUtils.showSuccessSnackbar(
              t.event.applicationForm.createQuestionsSuccessfully,
            );
            getEventDetailBloc.add(
              GetEventDetailEvent.fetch(
                eventId: eventId,
              ),
            );
          }
        },
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.event.applicationForm.createApplicationFom,
                            style: Typo.extraLarge.copyWith(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontFamily.nohemiVariable,
                            ),
                          ),
                          SizedBox(height: Spacing.superExtraSmall),
                          Text(
                            t.event.applicationForm.applicationDescription,
                            style: Typo.mediumPlus.copyWith(
                              color: colorScheme.onSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: Spacing.large),
                    ),
                    SliverToBoxAdapter(
                      child: Focus(
                        onFocusChange: (isFocused) {
                          if (isFocused) {
                            scrollToEnd();
                          } else {
                            scrollToTop();
                          }
                        },
                        child: ApplicationFormQuestions(
                          onAddButtonPressed: scrollToEnd,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: 350.w),
                    ),
                  ],
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
                    child: BlocBuilder<EventApplicationFormSettingBloc,
                        EventApplicationFormSettingBlocState>(
                      builder: (context, state) => Opacity(
                        opacity: state.isValid ? 1 : 0.5,
                        child: LinearGradientButton.primaryButton(
                          onTap: () {
                            if (!state.isValid) return;
                            context.read<EventApplicationFormSettingBloc>().add(
                                  EventApplicationFormSettingBlocEvent
                                      .submitCreate(
                                    eventId: eventId,
                                  ),
                                );
                          },
                          label: t.common.create,
                          textColor: colorScheme.onPrimary,
                          loadingWhen: state.status ==
                              EventApplicationFormStatus.loading,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
