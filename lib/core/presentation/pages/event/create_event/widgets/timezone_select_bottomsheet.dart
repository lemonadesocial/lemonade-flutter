import 'package:app/core/application/event/event_datetime_settings_bloc/event_datetime_settings_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/constants/event/event_constants.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wheel_picker/wheel_picker.dart';

const double timezoneWheelSize = 225;

class TimezoneSelectBottomSheet extends StatefulWidget {
  const TimezoneSelectBottomSheet({super.key, this.event});
  final Event? event;

  @override
  State<TimezoneSelectBottomSheet> createState() =>
      _TimezoneSelectBottomSheetState();
}

class _TimezoneSelectBottomSheetState extends State<TimezoneSelectBottomSheet> {
  late String? selectedTimezone = '';
  @override
  void initState() {
    super.initState();
    final timezone = context.read<EventDateTimeSettingsBloc>().state.timezone;
    setState(() {
      selectedTimezone = timezone;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final timezone = context.read<EventDateTimeSettingsBloc>().state.timezone;
    final index = EventConstants.timezoneOptions
        .indexWhere((element) => element['value'] == timezone);
    late final timezoneWheelController = WheelPickerController(
      itemCount: EventConstants.timezoneOptions.length,
      initialIndex: index,
    );
    const textStyle = TextStyle(fontSize: 10.0, height: 3, color: Colors.white);
    final wheelStyle = WheelPickerStyle(
      size: timezoneWheelSize,
      itemExtent: textStyle.fontSize! * textStyle.height!,
      squeeze: 1.25,
      diameterRatio: 1,
      surroundingOpacity: .25,
      magnification: 1.2,
    );
    return BlocListener<EventDateTimeSettingsBloc, EventDateTimeSettingsState>(
      listener: (context, state) async {
        if (state.isValid == true &&
            state.status == FormzSubmissionStatus.success) {
          SnackBarUtils.showCustom(
            title: "${t.common.saved}!",
            message: t.event.datetimeSettings.timezoneUpdated,
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
      child: SingleChildScrollView(
        controller: ModalScrollController.of(context),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: LemonColor.atomicBlack,
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                LemonAppBar(
                  backgroundColor: LemonColor.atomicBlack,
                  title: t.event.timezoneSetting.chooseTimezone,
                ),
                Stack(
                  children: [
                    _centerBar(context),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: BlocBuilder<EventDateTimeSettingsBloc,
                          EventDateTimeSettingsState>(
                        builder: (context, state) {
                          return WheelPicker(
                            style: wheelStyle,
                            controller: timezoneWheelController,
                            builder: (BuildContext context, int index) {
                              String? textDisplay =
                                  EventConstants.timezoneOptions.toList()[index]
                                          ['text'] ??
                                      '';
                              return Text(
                                textDisplay,
                                style: textStyle,
                              );
                            },
                            selectedIndexColor: colorScheme.onPrimary,
                            onIndexChanged: (index) {
                              final element = EventConstants.timezoneOptions
                                  .elementAt(index);
                              setState(() {
                                selectedTimezone = element['value'];
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                BlocBuilder<EventDateTimeSettingsBloc,
                    EventDateTimeSettingsState>(
                  builder: (context, state) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        vertical: Spacing.smMedium,
                        horizontal: Spacing.xSmall,
                      ),
                      child: LinearGradientButton.primaryButton(
                        onTap: () {
                          // Edit event
                          if (widget.event != null) {
                            context.read<EventDateTimeSettingsBloc>().add(
                                  EventDateTimeSettingsEventSaveChangesTimezone(
                                    event: widget.event,
                                    timezone: selectedTimezone ?? '',
                                  ),
                                );
                          }
                          // Create new event
                          else {
                            SnackBarUtils.showCustom(
                              title: "${t.common.saved}!",
                              message: t.event.datetimeSettings.timezoneUpdated,
                              icon: Assets.icons.icSave.svg(),
                              showIconContainer: true,
                              iconContainerColor: LemonColor.acidGreen,
                            );
                            AutoRouter.of(context).pop();
                          }
                        },
                        label: t.common.actions.saveChanges,
                        loadingWhen:
                            state.status == FormzSubmissionStatus.inProgress,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _centerBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: timezoneWheelSize,
      padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
      child: Center(
        child: Container(
          height: Sizing.medium,
          decoration: BoxDecoration(
            color: colorScheme.secondary,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
