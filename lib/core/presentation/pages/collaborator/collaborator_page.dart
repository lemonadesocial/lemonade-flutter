import 'package:app/core/application/profile/edit_profile_bloc/edit_profile_bloc.dart';
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
    // return this;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EditProfileBloc(),
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
