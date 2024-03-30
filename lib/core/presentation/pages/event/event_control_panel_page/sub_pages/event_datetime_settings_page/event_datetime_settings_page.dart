import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_datetime_settings_page/widgets/event_datetime_setting_row_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EventDatetimeSettingsPage extends StatelessWidget {
  const EventDatetimeSettingsPage({
    super.key,
    this.event,
    this.expandedStarts = true,
    this.expandedEnds = false,
  });
  final Event? event;
  final bool? expandedStarts;
  final bool? expandedEnds;

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
          ),
          backgroundColor: LemonColor.atomicBlack,
          resizeToAvoidBottomInset: true,
          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Spacing.smMedium,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: EventDatetimeSettingRowItem(
                        expanded: widget.expandedStarts == true,
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
                        expanded: widget.expandedEnds == true,
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(Spacing.smMedium),
                  child: SafeArea(
                    child: LinearGradientButton.primaryButton(
                      onTap: () {},
                      label: t.common.actions.saveChanges,
                      textColor: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          )

          //   BlocListener<EditEventDetailBloc, EditEventDetailState>(
          //     listener: (context, state) {
          //       if (state.status == EditEventDetailBlocStatus.success) {
          //         AutoRouter.of(context).pop();
          //       }
          //     },
          //     child: BlocListener<EventDateTimeSettingsBloc,
          //         EventDateTimeSettingsState>(
          //       listener: (context, state) async {
          //         if (state.start.value == null) {
          //           startDateInputController.text = '';
          //         }
          //         if (state.end.value == null) {
          //           endDateInputController.text = '';
          //         }
          //       },
          //       child: BlocBuilder<EventDateTimeSettingsBloc,
          //           EventDateTimeSettingsState>(
          //         builder: (context, state) {
          //           if (state.start.value == null && state.end.value == null) {
          //             return const SizedBox();
          //           }
          //           return Stack(
          //             children: [
          //               Padding(
          //                 padding: EdgeInsets.symmetric(
          //                   horizontal: Spacing.xSmall,
          //                   vertical: Spacing.small,
          //                 ),
          //                 child: Column(
          //                   children: [
          //                     EventDatetimeSettingRowItem(),
          //                     // DatePickerTextField(
          //                     //   controller: startDateInputController,
          //                     //   label: t.event.datetimeSettings.startDate,
          //                     //   initialValue: state.start.value,
          //                     //   onChanged: (value) => context
          //                     //       .read<EventDateTimeSettingsBloc>()
          //                     //       .add(StartDateChanged(datetime: value)),
          //                     //   errorText: state.start.error?.getMessage(
          //                     //     t.event.datetimeSettings.startDate,
          //                     //   ),
          //                     // ),
          //                     // SizedBox(
          //                     //   height: Spacing.medium,
          //                     // ),
          //                     // TimePickerTextField(
          //                     //   controller: startTimeInputController,
          //                     //   label: t.event.datetimeSettings.startTime,
          //                     //   initialValue: state.start.value,
          //                     //   onChanged: (value) => context
          //                     //       .read<EventDateTimeSettingsBloc>()
          //                     //       .add(StartTimeChanged(datetime: value)),
          //                     // ),
          //                     // SizedBox(
          //                     //   height: Spacing.medium,
          //                     // ),
          //                     // DatePickerTextField(
          //                     //   controller: endDateInputController,
          //                     //   label: t.event.datetimeSettings.endDate,
          //                     //   initialValue: state.end.value,
          //                     //   onChanged: (value) => context
          //                     //       .read<EventDateTimeSettingsBloc>()
          //                     //       .add(EndDateChanged(datetime: value)),
          //                     //   errorText: state.end.error?.getMessage(
          //                     //     t.event.datetimeSettings.endDate,
          //                     //   ),
          //                     // ),
          //                     // SizedBox(
          //                     //   height: Spacing.medium,
          //                     // ),
          //                     // TimePickerTextField(
          //                     //   controller: endTimeInputController,
          //                     //   label: t.event.datetimeSettings.endTime,
          //                     //   initialValue: state.end.value,
          //                     //   onChanged: (value) => context
          //                     //       .read<EventDateTimeSettingsBloc>()
          //                     //       .add(EndTimeChanged(datetime: value)),
          //                     // ),
          //                   ],
          //                 ),
          //               ),
          //               widget.event != null
          //                   ? BlocBuilder<EditEventDetailBloc,
          //                       EditEventDetailState>(
          //                       builder: (context, state) {
          //                         return Align(
          //                           alignment: Alignment.bottomCenter,
          //                           child: SafeArea(
          //                             child: Padding(
          //                               padding: EdgeInsets.symmetric(
          //                                 horizontal: Spacing.smMedium,
          //                                 vertical: Spacing.smMedium,
          //                               ),
          //                               child: LinearGradientButton(
          //                                 label: t.common.actions.save,
          //                                 height: 48.h,
          //                                 radius: BorderRadius.circular(24),
          //                                 textStyle: Typo.medium.copyWith(),
          //                                 mode: GradientButtonMode.lavenderMode,
          //                                 onTap: () {
          //                                   final start = context
          //                                       .read<EventDateTimeSettingsBloc>()
          //                                       .state
          //                                       .start
          //                                       .value;
          //                                   final end = context
          //                                       .read<EventDateTimeSettingsBloc>()
          //                                       .state
          //                                       .end
          //                                       .value;
          //                                   context.read<EditEventDetailBloc>().add(
          //                                         EditEventDetailEvent.update(
          //                                           eventId: widget.event?.id ?? '',
          //                                           start: start,
          //                                           end: end,
          //                                         ),
          //                                       );
          //                                 },
          //                                 loadingWhen: state.status ==
          //                                     EditEventDetailBlocStatus.loading,
          //                               ),
          //                             ),
          //                           ),
          //                         );
          //                       },
          //                     )
          //                   : const SizedBox(),
          //             ],
          //           );
          //         },
          //       ),
          //     ),
          //   ),
          ),
    );
  }
}
