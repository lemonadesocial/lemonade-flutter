import 'package:app/core/application/event/create_event_bloc/create_event_bloc.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/datepicker_text_field/datepicker_text_field.dart';
import 'package:app/core/presentation/widgets/common/timepicker_text_field/timepicker_text_field.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventDatetimeSettingsPage extends StatefulWidget {
  const EventDatetimeSettingsPage({Key? key}) : super(key: key);

  @override
  State<EventDatetimeSettingsPage> createState() =>
      _EventDatetimeSettingsPageState();
}

class _EventDatetimeSettingsPageState extends State<EventDatetimeSettingsPage> {
  final TextEditingController startDateInputController =
      TextEditingController();
  final TextEditingController endDateInputController = TextEditingController();
  final TextEditingController startTimeInputController =
      TextEditingController();
  final TextEditingController endTimeInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
        body: SingleChildScrollView(child: _buildContent(colorScheme)),
        resizeToAvoidBottomInset: true,
      ),
    );
  }

  Widget _buildContent(ColorScheme colorScheme) {
    return BlocBuilder<CreateEventBloc, CreateEventState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Spacing.xSmall, vertical: Spacing.small),
          child: Column(
            children: [
              DatePickerTextField(
                controller: startDateInputController,
                label: t.event.datetimeSettings.startDate,
              ),
              SizedBox(
                height: Spacing.medium,
              ),
              TimePickerTextField(
                controller: startTimeInputController,
                label: t.event.datetimeSettings.startTime,
              ),
              SizedBox(
                height: Spacing.medium,
              ),
              DatePickerTextField(
                controller: endDateInputController,
                label: t.event.datetimeSettings.endDate,
              ),
              SizedBox(
                height: Spacing.medium,
              ),
              TimePickerTextField(
                controller: endTimeInputController,
                label: t.event.datetimeSettings.endTime,
              ),
            ],
          ),
        );
      },
    );
  }
}
