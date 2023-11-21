import 'package:app/core/application/event/create_event_bloc/create_event_bloc.dart';
import 'package:app/core/presentation/pages/event/event_guest_settings_page/views/event_guest_settings_view.dart';
import 'package:app/core/presentation/widgets/lemon_bottom_sheet_mixin.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventGuestSettingsPage extends StatelessWidget with LemonBottomSheet {
  const EventGuestSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateEventBloc(),
      child: const EventGuestSettingsView(),
    );
  }
}
