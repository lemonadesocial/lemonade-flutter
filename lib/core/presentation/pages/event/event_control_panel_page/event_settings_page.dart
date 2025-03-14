import 'package:app/core/application/event/event_datetime_settings_bloc/event_datetime_settings_bloc.dart';
import 'package:app/core/application/event/event_guest_settings_bloc/event_guest_settings_bloc.dart';
import 'package:app/core/application/event/event_location_setting_bloc/event_location_setting_bloc.dart';
import 'package:app/core/application/event/event_subevents_setting_bloc/event_subevents_setting_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event/manage_event_cohost_requests_bloc/manage_event_cohost_requests_bloc.dart';
import 'package:app/core/application/payment/get_payment_accounts_bloc/get_payment_accounts_bloc.dart';
import 'package:app/core/application/user/get_users_bloc/get_users_bloc.dart';
import 'package:app/core/constants/event/event_constants.dart';
import 'package:app/core/domain/payment/input/get_payment_accounts_input/get_payment_accounts_input.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventSettingsPage extends StatelessWidget implements AutoRouteWrapper {
  const EventSettingsPage({
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
                timezone: event?.timezone,
              ),
            ),
        ),
        BlocProvider(
          create: (context) => EventLocationSettingBloc(),
        ),
        BlocProvider(
          create: (context) => EventGuestSettingsBloc(
            parentEventId: event?.subeventParent,
          ),
        ),
        BlocProvider(
          create: (context) => GetUsersBloc(),
        ),
        BlocProvider(
          create: (context) => ManageEventCohostRequestsBloc(),
        ),
        BlocProvider(
          create: (context) => EventSubEventsSettingBloc(),
        ),
        // Get all-user level payment accounts
        BlocProvider(
          create: (context) => GetPaymentAccountsBloc()
            ..add(
              GetPaymentAccountsEvent.fetch(
                input: GetPaymentAccountsInput(),
              ),
            ),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
