import 'package:app/core/application/event/create_event_bloc/create_event_bloc.dart';
import 'package:app/core/application/event/edit_event_detail_bloc/edit_event_detail_bloc.dart';
import 'package:app/core/application/event/event_datetime_settings_bloc/event_datetime_settings_bloc.dart';
import 'package:app/core/application/event/event_guest_settings_bloc/event_guest_settings_bloc.dart';
import 'package:app/core/application/event/event_location_setting_bloc/event_location_setting_bloc.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/get_event_detail_input.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CreateEventPage extends StatefulWidget implements AutoRouteWrapper {
  final String? parentEventId;
  final DateTime? parentEventStart;
  final DateTime? parentEventEnd;
  final String? parentTimezone;
  const CreateEventPage({
    super.key,
    this.parentEventId,
    this.parentEventStart,
    this.parentEventEnd,
    this.parentTimezone,
  });

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateEventBloc(
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
                startDateTime: EventUtils.getDefaultStartDateTime(
                  parentEventStart: parentEventStart,
                  parentEventEnd: parentEventEnd,
                ),
                endDateTime: EventUtils.getDefaultEndDateTime(
                  parentEventStart: parentEventStart,
                  parentEventEnd: parentEventEnd,
                ),
                timezone: parentTimezone,
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
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  @override
  void initState() {
    super.initState();
    _prefillParentEventData();
  }

  Future<void> _prefillParentEventData() async {
    if (widget.parentEventId != null) {
      final result = await getIt<EventRepository>().getEventDetail(
        input: GetEventDetailInput(id: widget.parentEventId!),
      );
      final parentEvent = result.fold(
        (l) => null,
        (r) => r,
      );
      context.read<EventLocationSettingBloc>().add(
            EventLocationSettingEvent.selectAddress(
              address: Address(
                id: parentEvent?.address?.id,
                title: parentEvent?.address?.title ?? '',
                street1: parentEvent?.address?.street1 ?? '',
                street2: parentEvent?.address?.street2 ?? '',
                city: parentEvent?.address?.city ?? '',
                region: parentEvent?.address?.region ?? '',
                postal: parentEvent?.address?.postal ?? '',
                country: parentEvent?.address?.country ?? '',
                latitude: parentEvent?.address?.latitude,
                longitude: parentEvent?.address?.longitude,
                recipientName: parentEvent?.address?.recipientName ?? '',
              ),
            ),
          );
    }
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
