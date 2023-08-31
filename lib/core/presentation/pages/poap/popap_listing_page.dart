import 'package:app/core/application/badge/badge_collections_bloc/badge_collections_bloc.dart';
import 'package:app/core/application/badge/badge_location_listing_bloc/badge_locations_listing_bloc.dart';
import 'package:app/core/application/badge/badges_listing_bloc/badges_listing_bloc.dart';
import 'package:app/core/presentation/pages/poap/views/poap_listing_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class PoapListingPage extends StatelessWidget {
  PoapListingPage({super.key});

  final _badgeListingBloc = BadgesListingBloc();

  bool badgeCollectionListenWhen(
    BadgeCollectionsState prev,
    BadgeCollectionsState cur,
  ) {
    return prev is BadgeCollectionsStateFetched &&
        cur is BadgeCollectionsStateFetched;
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
    if (prevLocation?.isMyLocation == true &&
        currentLocation?.isMyLocation == true) return false;
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
