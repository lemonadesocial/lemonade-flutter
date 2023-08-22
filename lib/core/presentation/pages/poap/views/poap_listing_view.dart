import 'package:app/core/application/badge/badge_collections_bloc/badge_collections_bloc.dart';
import 'package:app/core/application/badge/badge_location_listing_bloc/badge_locations_listing_bloc.dart';
import 'package:app/core/application/badge/badges_listing_bloc/badges_listing_bloc.dart';
import 'package:app/core/presentation/pages/poap/popap_listing_page.dart';
import 'package:app/core/presentation/pages/poap/views/popap_filter_bottom_sheet_view.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/poap/poap_item.dart';
import 'package:app/core/utils/debouncer.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final List<double> _snapSizes = [.2, .77, 1];

class PoapListingView extends StatefulWidget {
  const PoapListingView({
    super.key,
    required this.controller,
  });
  final PoapListingPageController controller;

  @override
  State<PoapListingView> createState() => _PoapListingViewState();
}

class _PoapListingViewState extends State<PoapListingView> {
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
          listenWhen: widget.controller.badgeCollectionListenWhen,
          listener: (context, state) {
            context.read<BadgesListingBloc>().add(
                  BadgesListingEvent.refresh(),
                );
          },
        ),
        BlocListener<BadgeLocationsListingBloc, BadgeLocationsListingState>(
          listenWhen: widget.controller.badgeLocationListenWhen,
          listener: (context, state) {
            context.read<BadgesListingBloc>().add(
                  BadgesListingEvent.refresh(),
                );
          },
        ),
        BlocListener<BadgeLocationsListingBloc, BadgeLocationsListingState>(
          listenWhen: widget.controller.badgeLocationDistanceListenWhen,
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
                              _snapSizes[1],
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.linear,
                            );
                          },
                          child: Assets.icons.icFilterOutline.svg(),
                        ),
                      ],
                    ),
                  ),
                  CupertinoSliverRefreshControl(
                    onRefresh: () async {
                      context.read<BadgesListingBloc>().add(BadgesListingEvent.refresh());
                    },
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
                          itemBuilder: (context, i) => PoapItem(
                            key: ValueKey(badges[i].id),
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
                  snapSizes: _snapSizes,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
