import 'package:app/core/application/badge/badge_collections_bloc/badge_collections_bloc.dart';
import 'package:app/core/application/badge/badge_location_listing_bloc/badge_locations_listing_bloc.dart';
import 'package:app/core/application/badge/badges_listing_bloc/badges_listing_bloc.dart';
import 'package:app/core/presentation/pages/poap/views/poap_listing_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class PoapListingPage extends StatefulWidget {
  const PoapListingPage({super.key});

  @override
  State<PoapListingPage> createState() => PoapListingPageController();
}

class PoapListingPageController extends State<PoapListingPage> with WidgetsBindingObserver {
  final _badgeListingBloc = BadgesListingBloc();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        _badgeListingBloc.add(BadgesListingEvent.refresh());
        break;
      // ignore: no_default_cases
      default:
    }
  }

  bool badgeCollectionListenWhen(
    BadgeCollectionsState prev,
    BadgeCollectionsState cur,
  ) {
    if (prev is BadgeCollectionsStateFetched && cur is BadgeCollectionsStateFetched) {
      return true;
    }
    return false;
  }

  bool badgeLocationListenWhen(
    BadgeLocationsListingState prev,
    BadgeLocationsListingState cur,
  ) {
    final prevLocation = prev.whenOrNull(
      initial: (selectedLocation, _) => selectedLocation,
      fetched: (_, selectedLocation, __) => selectedLocation,
    );
    final currentLocation = cur.whenOrNull(
      initial: (selectedLocation, _) => selectedLocation,
      fetched: (_, selectedLocation, __) => selectedLocation,
    );
    return prevLocation != currentLocation;
  }

  bool badgeLocationDistanceListenWhen(
    BadgeLocationsListingState prev,
    BadgeLocationsListingState cur,
  ) {
    final prevDistance = prev.maybeWhen(
      initial: (_, distance) => distance,
      fetched: (_, __, distance) => distance,
      orElse: () => 1,
    );
    final currentDistance = cur.maybeWhen(
      initial: (_, distance) => distance,
      fetched: (_, __, distance) => distance,
      orElse: () => 1,
    );
    return prevDistance != currentDistance;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _badgeListingBloc
            ..add(
              BadgesListingEvent.fetch(),
            ),
        ),
        BlocProvider(
          create: (context) => BadgeCollectionsBloc()
            ..add(
              BadgeCollectionsEvent.fetch(),
            ),
        ),
        BlocProvider(
          create: (context) => BadgeLocationsListingBloc()
            ..add(
              BadgeLocationsListingEvent.fetch(),
            ),
        ),
      ],
      child: PoapListingView(controller: this),
    );
  }
}
