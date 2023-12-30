import 'package:app/core/application/event/event_datetime_settings_bloc/event_datetime_settings_bloc.dart';
import 'package:app/core/application/event/event_location_setting_bloc/event_location_setting_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/constants/event/event_constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventControlPanelPage extends StatelessWidget
    implements AutoRouteWrapper {
  const EventControlPanelPage({
    super.key,
  });

  @override
  Widget wrappedRoute(BuildContext context) {
    final event = context.read<GetEventDetailBloc>().state.maybeWhen(
          fetched: (eventDetail) => eventDetail,
          orElse: () => null,
        );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EventDateTimeSettingsBloc()
            ..add(
              EventDateTimeSettingsEvent.init(
                startDateTime:
                    event?.start ?? EventDateTimeConstants.defaultStartDateTime,
                endDateTime:
                    event?.end ?? EventDateTimeConstants.defaultEndDateTime,
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
