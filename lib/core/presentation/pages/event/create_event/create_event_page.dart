import 'package:app/core/application/event/edit_event_bloc/edit_event_bloc.dart';
import 'package:app/core/application/event/edit_event_detail_bloc/edit_event_detail_bloc.dart';
import 'package:app/core/application/event/event_datetime_settings_bloc/event_datetime_settings_bloc.dart';
import 'package:app/core/application/event/event_guest_settings_bloc/event_guest_settings_bloc.dart';
import 'package:app/core/application/event/event_location_setting_bloc/event_location_setting_bloc.dart';
import 'package:app/core/constants/event/event_constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CreateEventPage extends StatelessWidget implements AutoRouteWrapper {
  final String? parentEventId;
  const CreateEventPage({
    super.key,
    this.parentEventId,
  });

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EditEventBloc(
            parentEventId: parentEventId,
          ),
        ),
        BlocProvider(
          create: (context) => EventGuestSettingsBloc(
            parentEventId: parentEventId,
          ),
        ),
        BlocProvider(
          create: (context) => EditEventDetailBloc(
            parentEventId: parentEventId,
          ),
        ),
        BlocProvider(
          create: (context) => EventDateTimeSettingsBloc()
            ..add(
              EventDateTimeSettingsEvent.init(
                startDateTime: EventDateTimeConstants.defaultStartDateTime,
                endDateTime: EventDateTimeConstants.defaultEndDateTime,
              ),
            ),
        ),
        BlocProvider(
          create: (context) => EventLocationSettingBloc(),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: const AutoRouter(),
    );
  }
}
