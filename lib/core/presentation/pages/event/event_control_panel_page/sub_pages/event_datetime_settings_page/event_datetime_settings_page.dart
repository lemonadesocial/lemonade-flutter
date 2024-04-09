import 'package:app/core/application/event/event_datetime_settings_bloc/event_datetime_settings_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_datetime_settings_page/widgets/event_datetime_setting_row_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/popup/go_back_confirmation_popup.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/utils/date_utils.dart' as date_utils;
import 'package:formz/formz.dart';

@RoutePage()
class EventDatetimeSettingsPage extends StatelessWidget {
  const EventDatetimeSettingsPage({
    super.key,
    this.event,
    this.expandedStarts,
    this.expandedEnds,
  });
  final bool? expandedStarts;
  final bool? expandedEnds;
  final Event? event;

  @override
  Widget build(BuildContext context) {
    return EventDatetimeSettingsPageView(
      event: event,
      expandedStarts: expandedStarts,
      expandedEnds: expandedEnds,
    );
  }
}

class EventDatetimeSettingsPageView extends StatefulWidget {
  const EventDatetimeSettingsPageView({
    super.key,
    this.event,
    this.expandedStarts,
    this.expandedEnds,
  });

  final Event? event;
  final bool? expandedStarts;
  final bool? expandedEnds;

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

  bool? expandedStarts;
  bool? expandedEnds;
  DateTime? tempStart;
  DateTime? tempEnd;

  @override
  void initState() {
    super.initState();
    final start = context.read<EventDateTimeSettingsBloc>().state.start.value;
    final end = context.read<EventDateTimeSettingsBloc>().state.end.value;
    setState(() {
      expandedStarts = widget.expandedStarts;
      expandedEnds = widget.expandedEnds;
      tempStart = start;
      tempEnd = end;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: LemonAppBar(
          backgroundColor: LemonColor.atomicBlack,
          title: t.event.datetimeSettings.chooseDateAndTime,
          onPressBack: () {
            final start =
                context.read<EventDateTimeSettingsBloc>().state.start.value;
            final end =
                context.read<EventDateTimeSettingsBloc>().state.end.value;
            if (tempStart != start || tempEnd != end) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => GoBackConfirmationPopup(
                  onConfirmed: () {
                    context
                        .read<EventDateTimeSettingsBloc>()
                        .add(const EventDateTimeSettingsEventReset());
                    AutoRouter.of(context).pop();
                  },
                ),
              );
            } else {
              AutoRouter.of(context).pop();
            }
          },
        ),
        backgroundColor: LemonColor.atomicBlack,
        resizeToAvoidBottomInset: true,
        body:
            BlocListener<EventDateTimeSettingsBloc, EventDateTimeSettingsState>(
          listener: (context, state) async {
            if (state.isValid == false &&
                state.status == FormzSubmissionStatus.failure &&
                state.errorMessage != '') {
              SnackBarUtils.showError(message: state.errorMessage);
            }
            if (state.isValid == true &&
                state.status == FormzSubmissionStatus.success) {
              SnackBarUtils.showCustom(
                title: "${t.common.saved}!",
                message: t.event.datetimeSettings.dateTimeUpdated,
                icon: Assets.icons.icSave.svg(),
                showIconContainer: true,
                iconContainerColor: LemonColor.acidGreen,
              );
              context.read<GetEventDetailBloc>().add(
                    GetEventDetailEvent.fetch(
                      eventId: widget.event!.id ?? '',
                    ),
                  );
              AutoRouter.of(context).pop();
            }
          },
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Spacing.smMedium,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: EventDatetimeSettingRowItem(
                        label: t.event.datetimeSettings.starts,
                        dotColor: LemonColor.snackBarSuccess,
                        selectedDateTime: tempStart ?? DateTime.now(),
                        expanded: expandedStarts == true,
                        onSelectTab: () {
                          setState(() {
                            expandedStarts = true;
                            expandedEnds = false;
                          });
                        },
                        onDateChanged: (DateTime datetime) {
                          setState(() {
                            tempStart = date_utils.DateUtils.combineDateAndTime(
                              datetime,
                              TimeOfDay(
                                hour: tempStart!.hour,
                                minute: tempStart!.minute,
                              ),
                            );
                          });
                        },
                        onTimeChanged: (TimeOfDay timeOfDay) {
                          setState(() {
                            tempStart = date_utils.DateUtils.combineDateAndTime(
                              tempStart ?? DateTime.now(),
                              timeOfDay,
                            );
                          });
                        },
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(
                      left: Spacing.smMedium,
                      right: Spacing.smMedium,
                      bottom: Spacing.smMedium,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        height: 1,
                        color: LemonColor.white03,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Spacing.smMedium,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: EventDatetimeSettingRowItem(
                        label: t.event.datetimeSettings.ends,
                        dotColor: LemonColor.coralReef,
                        expanded: expandedEnds == true,
                        selectedDateTime: tempEnd ?? DateTime.now(),
                        onSelectTab: () {
                          setState(() {
                            expandedStarts = false;
                            expandedEnds = true;
                          });
                        },
                        onDateChanged: (DateTime datetime) {
                          setState(() {
                            tempEnd = date_utils.DateUtils.combineDateAndTime(
                              datetime,
                              TimeOfDay(
                                hour: tempEnd!.hour,
                                minute: tempEnd!.minute,
                              ),
                            );
                          });
                        },
                        onTimeChanged: (TimeOfDay timeOfDay) {
                          setState(() {
                            tempEnd = date_utils.DateUtils.combineDateAndTime(
                              tempEnd ?? DateTime.now(),
                              timeOfDay,
                            );
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              BlocBuilder<EventDateTimeSettingsBloc,
                  EventDateTimeSettingsState>(
                builder: (context, state) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.all(Spacing.smMedium),
                      child: SafeArea(
                        child: LinearGradientButton.primaryButton(
                          onTap: () {
                            context.read<EventDateTimeSettingsBloc>().add(
                                  EventDateTimeSettingsEventSaveChanges(
                                    event: widget.event,
                                    newStart: tempStart ?? DateTime.now(),
                                    newEnd: tempEnd ?? DateTime.now(),
                                  ),
                                );
                          },
                          label: t.common.actions.saveChanges,
                          textColor: colorScheme.onPrimary,
                          loadingWhen:
                              state.status == FormzSubmissionStatus.inProgress,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
