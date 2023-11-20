import 'package:app/core/application/event/create_event_bloc/create_event_bloc.dart';
import 'package:app/core/presentation/pages/create_event/widgets/create_event_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CreateEventPage extends StatelessWidget {
  const CreateEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateEventBloc(),
      child: const CreateEventView(),
    );
  }
}
