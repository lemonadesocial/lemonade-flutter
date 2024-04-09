import 'package:app/core/application/event/event_title_description_setting_bloc/event_title_description_setting_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/editor/mobile_editor.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:formz/formz.dart';

@RoutePage()
class EventTitleDescriptionSettingPage extends StatelessWidget {
  const EventTitleDescriptionSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final event = context.read<GetEventDetailBloc>().state.maybeWhen(
          fetched: (eventDetail) => eventDetail,
          orElse: () => null,
        );
    return BlocProvider<EventTitleDescriptionSettingBloc>(
      create: (context) => EventTitleDescriptionSettingBloc(event),
      child: const EventTitleDescriptionSettingView(),
    );
  }
}

class EventTitleDescriptionSettingView extends StatelessWidget {
  const EventTitleDescriptionSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final eventId = context.read<GetEventDetailBloc>().state.maybeWhen(
          fetched: (eventDetail) => eventDetail.id,
          orElse: () => null,
        );
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: PlatformExtension.isDesktopOrWeb,
        appBar: LemonAppBar(
          title: t.event.eventCreation.titleAndDescription,
          backgroundColor: LemonColor.atomicBlack,
          onPressBack: () {
            AutoRouter.of(context).pop();
          },
        ),
        body: BlocListener<EventTitleDescriptionSettingBloc,
            EventTitleDescriptionSettingState>(
          listener: (context, state) async {
            if (state.isValid == true &&
                state.status == FormzSubmissionStatus.success) {
              SnackBarUtils.showCustom(
                title: "${t.common.saved}!",
                message: t.common.updatedSuccessfully,
                icon: Assets.icons.icSave.svg(),
                showIconContainer: true,
                iconContainerColor: LemonColor.acidGreen,
              );
              context.read<GetEventDetailBloc>().add(
                    GetEventDetailEvent.fetch(
                      eventId: eventId ?? '',
                    ),
                  );
              AutoRouter.of(context).pop();
            }
          },
          child: BlocBuilder<EventTitleDescriptionSettingBloc,
              EventTitleDescriptionSettingState>(
            builder: (context, state) {
              if (state.status == null) {
                return Center(
                  child: Loading.defaultLoading(context),
                );
              }
              return SafeArea(
                child: Container(
                  color: LemonColor.atomicBlack,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Spacing.smMedium,
                          vertical: Spacing.smMedium / 2,
                        ),
                        child: LemonTextField(
                          fillColor: LemonColor.atomicBlack,
                          hintText: t.event.eventCreation.titleHint,
                          initialText: state.title.value,
                          onChange: (value) => context
                              .read<EventTitleDescriptionSettingBloc>()
                              .add(
                                EventTitleDescriptionSettingEventTitleChanged(
                                  title: value,
                                ),
                              ),
                          errorText: state.title.displayError?.getMessage(
                            t.event.eventCreation.title,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: Spacing.smMedium,
                            vertical: Spacing.smMedium / 2,
                          ),
                          decoration: BoxDecoration(
                            color: LemonColor.atomicBlack,
                            borderRadius:
                                BorderRadius.circular(LemonRadius.medium),
                            border: Border.all(
                              color: colorScheme.outline,
                            ),
                          ),
                          child: MobileEditor(
                            editorState: state.descriptionEditorState ??
                                EditorState.blank(),
                            autoFocus: false,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Spacing.smMedium,
                          vertical: Spacing.xSmall,
                        ),
                        child: LinearGradientButton(
                          label: t.common.actions.saveChanges,
                          height: 48.h,
                          radius: BorderRadius.circular(24),
                          textStyle: Typo.medium.copyWith(),
                          mode: GradientButtonMode.lavenderMode,
                          onTap: () {
                            Vibrate.feedback(FeedbackType.light);
                            context
                                .read<EventTitleDescriptionSettingBloc>()
                                .add(
                                  EventTitleDescriptionSettingEventSaveChanges(
                                    eventId: eventId ?? '',
                                  ),
                                );
                          },
                          loadingWhen: state.status!.isInProgress,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
