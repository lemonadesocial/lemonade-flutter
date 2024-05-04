import 'package:app/core/application/collaborator/discover_users_bloc/discover_user_bloc.dart';
import 'package:app/core/utils/location_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CollaboratorPage extends StatefulWidget implements AutoRouteWrapper {
  final discoverUserBloc = DiscoverUserBloc();
  CollaboratorPage({
    super.key,
  });

  @override
  State<CollaboratorPage> createState() => _CollaboratorPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: discoverUserBloc,
        ),
      ],
      child: this,
    );
  }
}

class _CollaboratorPageState extends State<CollaboratorPage> {
  @override
  initState() {
    super.initState();
    _checkLocation();
  }

  void _checkLocation() async {
    bool hasPermission = await getIt<LocationUtils>().checkPermission();
    if (!hasPermission) {
      hasPermission = await LocationUtils.requestLocationPermissionWithPopup(
        context,
      );
    }
    if (hasPermission) {
      widget.discoverUserBloc.add(DiscoverUserEvent.fetch());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
