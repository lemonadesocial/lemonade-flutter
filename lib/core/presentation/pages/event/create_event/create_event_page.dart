import 'package:app/core/application/event/create_event_bloc/create_event_bloc.dart';
import 'package:app/core/application/event/event_datetime_settings_bloc/event_datetime_settings_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CreateEventPage extends StatelessWidget implements AutoRouteWrapper {
  const CreateEventPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    DateTime currentDateTime = DateTime.now();
    DateTime startDateTime = DateTime(
      currentDateTime.year,
      currentDateTime.month,
      currentDateTime.day + 3,
      10,
    );

    DateTime endDateTime = DateTime(
      currentDateTime.year,
      currentDateTime.month,
      currentDateTime.day + 6,
      18,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateEventBloc(),
        ),
        BlocProvider(
          create: (context) => EventDateTimeSettingsBloc()
            ..add(
              EventDateTimeSettingsEvent.init(
                startDateTime: startDateTime,
                endDateTime: endDateTime,
              ),
            ),
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
