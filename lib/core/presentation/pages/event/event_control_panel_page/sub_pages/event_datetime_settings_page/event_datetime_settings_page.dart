import 'package:app/core/application/event/edit_event_detail_bloc/edit_event_detail_bloc.dart';
import 'package:app/core/application/event/event_datetime_settings_bloc/event_datetime_settings_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/datepicker_text_field/datepicker_text_field.dart';
import 'package:app/core/presentation/widgets/common/timepicker_text_field/timepicker_text_field.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class EventDatetimeSettingsPage extends StatelessWidget {
  const EventDatetimeSettingsPage({
    super.key,
    this.event,
  });
  final Event? event;

  @override
  Widget build(BuildContext context) {
    return EventDatetimeSettingsPageView(event: event);
  }
}

class EventDatetimeSettingsPageView extends StatefulWidget {
  const EventDatetimeSettingsPageView({
    super.key,
    this.event,
  });
  final Event? event;

  @override
  State<EventDatetimeSettingsPageView> createState() =>
      _EventDatetimeSettingsPageState();
}

class _EventDatetimeSettingsPageState
    extends State<EventDatetimeSettingsPageView> {
  final TextEditingController startDateInputController =
      TextEditingController();
  final TextEditingController endDateInputController = TextEditingController();
  final TextEditingController startTimeInputController =
      TextEditingController();
  final TextEditingController endTimeInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: LemonAppBar(
          backgroundColor: colorScheme.onPrimaryContainer,
          title: t.event.dateAndTime,
        ),
        backgroundColor: colorScheme.onPrimaryContainer,
        resizeToAvoidBottomInset: true,
        body: BlocListener<EditEventDetailBloc, EditEventDetailState>(
          listener: (context, state) {
            if (state.status == EditEventDetailBlocStatus.success) {
              AutoRouter.of(context).pop();
            }
          },
          child: BlocListener<EventDateTimeSettingsBloc,
              EventDateTimeSettingsState>(
            listener: (context, state) async {
              if (state.start.value == null) {
                startDateInputController.text = '';
              }
              if (state.end.value == null) {
                endDateInputController.text = '';
              }
            },
            child: BlocBuilder<EventDateTimeSettingsBloc,
                EventDateTimeSettingsState>(
              builder: (context, state) {
                if (state.start.value == null && state.end.value == null) {
                  return const SizedBox();
                }
                return Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Spacing.xSmall,
                        vertical: Spacing.small,
                      ),
                      child: Column(
                        children: [
                          DatePickerTextField(
                            controller: startDateInputController,
                            label: t.event.datetimeSettings.startDate,
                            initialValue: state.start.value,
                            onChanged: (value) => context
                                .read<EventDateTimeSettingsBloc>()
                                .add(StartDateChanged(datetime: value)),
                            errorText: state.start.error != null
                                ? state.start.error!.getMessage(
                                    t.event.datetimeSettings.startDate,
                                  )
                                : null,
                          ),
                          SizedBox(
                            height: Spacing.medium,
                          ),
                          TimePickerTextField(
                            controller: startTimeInputController,
                            label: t.event.datetimeSettings.startTime,
                            initialValue: state.start.value,
                            onChanged: (value) => context
                                .read<EventDateTimeSettingsBloc>()
                                .add(StartTimeChanged(datetime: value)),
                          ),
                          SizedBox(
                            height: Spacing.medium,
                          ),
                          DatePickerTextField(
                            controller: endDateInputController,
                            label: t.event.datetimeSettings.endDate,
                            initialValue: state.end.value,
                            onChanged: (value) => context
                                .read<EventDateTimeSettingsBloc>()
                                .add(EndDateChanged(datetime: value)),
                            errorText: state.end.error != null
                                ? state.end.error!.getMessage(
                                    t.event.datetimeSettings.endDate,
                                  )
                                : null,
                          ),
                          SizedBox(
                            height: Spacing.medium,
                          ),
                          TimePickerTextField(
                            controller: endTimeInputController,
                            label: t.event.datetimeSettings.endTime,
                            initialValue: state.end.value,
                            onChanged: (value) => context
                                .read<EventDateTimeSettingsBloc>()
                                .add(EndTimeChanged(datetime: value)),
                          ),
                        ],
                      ),
                    ),
                    widget.event != null
                        ? BlocBuilder<EditEventDetailBloc,
                            EditEventDetailState>(
                            builder: (context, state) {
                              return Align(
                                alignment: Alignment.bottomCenter,
                                child: SafeArea(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Spacing.smMedium,
                                      vertical: Spacing.smMedium,
                                    ),
                                    child: LinearGradientButton(
                                      label: t.common.actions.save,
                                      height: 48.h,
                                      radius: BorderRadius.circular(24),
                                      textStyle: Typo.medium.copyWith(),
                                      mode: GradientButtonMode.lavenderMode,
                                      onTap: () {
                                        final start = context
                                            .read<EventDateTimeSettingsBloc>()
                                            .state
                                            .start
                                            .value;
                                        final end = context
                                            .read<EventDateTimeSettingsBloc>()
                                            .state
                                            .end
                                            .value;
                                        context.read<EditEventDetailBloc>().add(
                                              EditEventDetailEvent.update(
                                                eventId: widget.event?.id ?? '',
                                                start: start,
                                                end: end,
                                              ),
                                            );
                                      },
                                      loadingWhen: state.status ==
                                          EditEventDetailBlocStatus.loading,
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : const SizedBox(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
