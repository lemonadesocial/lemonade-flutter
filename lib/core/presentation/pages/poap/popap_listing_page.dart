import 'package:app/core/application/badge/badge_collections_bloc/badge_collections_bloc.dart';
import 'package:app/core/application/badge/badge_location_listing_bloc/badge_locations_listing_bloc.dart';
import 'package:app/core/application/badge/badges_listing_bloc/badges_listing_bloc.dart';
import 'package:app/core/presentation/pages/poap/views/popap_filter_bottom_sheet_view.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/poap/poap_claim_item.dart';
import 'package:app/core/utils/debouncer.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final List<double> snapSizes = [.2, .77, 1];

@RoutePage()
class PoapListingPage extends StatelessWidget {
  const PoapListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BadgesListingBloc()
            ..add(
              BadgesListingEventFetch(),
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
      child: const PoapListingPageView(),
    );
  }
}

class PoapListingPageView extends StatefulWidget {
  const PoapListingPageView({
    super.key,
  });

  @override
  State<PoapListingPageView> createState() => _PoapListingPageViewState();
}

class _PoapListingPageViewState extends State<PoapListingPageView> {
  final DraggableScrollableController dragController = DraggableScrollableController();
  final debouncer = Debouncer(milliseconds: 300);

  @override
  void dispose() {
    debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<BadgeCollectionsBloc, BadgeCollectionsState>(
          listenWhen: (prev, cur) {
            if (prev is BadgeCollectionsStateFetched && cur is BadgeCollectionsStateFetched) {
              return true;
            }
            return false;
          },
          listener: (context, state) {
            context.read<BadgesListingBloc>().add(
                  BadgesListingEvent.refresh(),
                );
          },
        ),
        BlocListener<BadgeLocationsListingBloc, BadgeLocationsListingState>(
          listenWhen: (prev, cur) {
            final prevLocation = prev.whenOrNull(fetched: (_, selectedLocation, __) => selectedLocation);
            final currentLocation = cur.whenOrNull(fetched: (_, selectedLocation, __) => selectedLocation);
            return prevLocation != currentLocation;
          },
          listener: (context, state) {
            context.read<BadgesListingBloc>().add(
                  BadgesListingEvent.refresh(),
                );
          },
        ),
        BlocListener<BadgeLocationsListingBloc, BadgeLocationsListingState>(
          listenWhen: (prev, cur) {
            final prevDistance = prev.maybeWhen(fetched: (_, __, distance) => distance, orElse: () => 1);
            final currentDistance = cur.maybeWhen(fetched: (_, __, distance) => distance, orElse: () => 1);
            return prevDistance != currentDistance;
          },
          listener: (context, state) {
            debouncer.run(() {
              context.read<BadgesListingBloc>().add(
                    BadgesListingEvent.refresh(),
                  );
            });
          },
        )
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: colorScheme.primary,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.extraSmall,
          ),
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    leading: const SizedBox.shrink(),
                    expandedHeight: 60,
                    collapsedHeight: 60,
                    floating: true,
                    flexibleSpace: LemonAppBar(
                      title: StringUtils.capitalize(t.nft.badges),
                      actions: [
                        GestureDetector(
                          onTap: () {
                            dragController.animateTo(
                              snapSizes[1],
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.linear,
                            );
                          },
                          child: Assets.icons.icFilterOutline.svg(),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<BadgesListingBloc, BadgesListingState>(
                    builder: (context, state) => state.when(
                      initial: () => SliverToBoxAdapter(
                        child: Loading.defaultLoading(context),
                      ),
                      failure: () {
                        return SliverToBoxAdapter(
                          child: Center(
                            child: Text(t.common.somethingWrong),
                          ),
                        );
                      },
                      fetched: (badges) {
                        if (badges.isEmpty) {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: EmptyList(
                                emptyText: t.nft.noBadges,
                              ),
                            ),
                          );
                        }
                        return SliverList.separated(
                          itemCount: badges.length,
                          separatorBuilder: (context, i) => const SizedBox(height: 12),
                          itemBuilder: (context, i) => POAPClaimItem(
                            badge: badges[i],
                          ),
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  )
                ],
              ),
              SafeArea(
                bottom: false,
                child: PoapFilterBottomSheetView(
                  dragController: dragController,
                  snapSizes: snapSizes,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
