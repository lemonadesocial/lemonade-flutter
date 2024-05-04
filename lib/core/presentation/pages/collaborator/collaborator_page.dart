import 'package:app/core/application/collaborator/discover_users_bloc/discover_user_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CollaboratorPage extends StatelessWidget implements AutoRouteWrapper {
  const CollaboratorPage({
    super.key,
  });

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DiscoverUserBloc()
            ..add(
              DiscoverUserEvent.fetch(),
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
