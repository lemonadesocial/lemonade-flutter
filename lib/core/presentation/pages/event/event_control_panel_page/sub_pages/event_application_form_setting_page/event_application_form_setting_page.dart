import 'package:app/core/application/event/event_application_form_profile_setting_bloc/event_application_form_profile_setting_bloc.dart';
import 'package:app/core/application/event/event_application_form_setting_bloc/event_application_form_setting_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_application_form_setting_page/widgets/choose_question_type_bottomsheet.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_application_form_setting_page/widgets/event_application_form_setting_questions_list.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_application_form_setting_page/widgets/event_application_form_setting_selected_profile_fields_list.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_application_form_setting_page/widgets/event_application_form_setting_web3_identity.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';

import 'package:app/core/utils/snackbar_utils.dart';

import 'package:app/i18n/i18n.g.dart';

import 'package:app/theme/spacing.dart';

@RoutePage()
class EventApplicationFormSettingPage extends StatelessWidget {
  const EventApplicationFormSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Event? event = context.watch<GetEventDetailBloc>().state.maybeWhen(
          fetched: (event) => event,
          orElse: () => null,
        );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EventApplicationFormSettingBloc(
            event: event,
            initialQuestions: event?.applicationQuestions ?? [],
          ),
        ),
        BlocProvider(
          create: (context) => EventApplicationFormProfileSettingBloc(
            event: event,
            initialProfileFields: event?.applicationProfileFields ?? [],
          ),
        ),
      ],
      child: EventApplicationFormSettingPageView(),
    );
  }
}

class EventApplicationFormSettingPageView extends StatelessWidget {
  EventApplicationFormSettingPageView({
    super.key,
  });

  final _scrollController = ScrollController();

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
    final event = getEventDetailBloc.state.maybeWhen(
      fetched: (event) => event,
      orElse: () => null,
    );
    return MultiBlocListener(
      listeners: [
        BlocListener<EventApplicationFormSettingBloc,
            EventApplicationFormSettingBlocState>(
          listener: (context, state) {
            if (state.status == EventApplicationFormStatus.success) {
              SnackBarUtils.showSuccess(
                message:
                    t.event.applicationForm.updateApplicationFormSuccessfully,
              );
              getEventDetailBloc.add(
                GetEventDetailEvent.fetch(
                  eventId: eventId,
                ),
              );
            }
          },
        ),
        BlocListener<EventApplicationFormProfileSettingBloc,
            EventApplicationFormProfileSettingBlocState>(
          listener: (context, state) {
            if (state.status ==
                EventApplicationFormProfileSettingStatus.success) {
              SnackBarUtils.showSuccess(
                message:
                    t.event.applicationForm.updateApplicationFormSuccessfully,
              );
              getEventDetailBloc.add(
                GetEventDetailEvent.fetch(
                  eventId: eventId,
                ),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: LemonAppBar(
          title: t.event.applicationForm.applicationFormTitle,
        ),
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Spacing.small,
                    ),
                    sliver:
                        EventApplicationFormSettingSelectedProfileFieldsList(
                      profileFields: event?.applicationProfileFields ?? [],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Divider(
                      color: colorScheme.outline,
                      height: Spacing.medium * 2,
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Spacing.small,
                    ),
                    sliver: const EventApplicationFormSettingWeb3Identity(),
                  ),
                  SliverToBoxAdapter(
                    child: Divider(
                      color: colorScheme.outline,
                      height: Spacing.medium * 2,
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Spacing.small,
                    ),
                    sliver: const EventApplicationFormSettingQuestionsList(),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: Spacing.large * 4,
                    ),
                  ),
                ],
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
                    child: LinearGradientButton.secondaryButton(
                      mode: GradientButtonMode.light,
                      onTap: () {
                        ChooseQuestionTypeBottomSheet.show(context);
                      },
                      label: t.event.applicationForm.addQuestion,
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
