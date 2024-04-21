import 'package:app/core/application/chat/create_guild_channel_bloc/create_guild_channel_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CreateGuildChannelPage extends StatelessWidget
    implements AutoRouteWrapper {
  const CreateGuildChannelPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateGuildChannelBloc()
        ..add(
          const CreateGuildChannelEvent.getAllGuilds(),
        ),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
