import 'package:app/core/application/event/events_listing_bloc/attending_events_listing_bloc.dart';
import 'package:app/core/application/event/events_listing_bloc/base_events_listing_bloc.dart';
import 'package:app/core/application/event/events_listing_bloc/hosting_events_listing_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/base_sliver_tab_view.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_chip_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/event/event_service.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEventTabView extends StatefulWidget {
  final User user;
  const ProfileEventTabView({
    super.key,
    required this.user,
  });

  @override
  State<ProfileEventTabView> createState() => _ProfileEventTabViewState();
}

class _ProfileEventTabViewState extends State<ProfileEventTabView> {
  double get _filterBarHeight => 72;
  EventListingType type = EventListingType.attending;

  late final attendingEventsBloc = AttendingEventListingBloc(
    EventService(
      getIt<EventRepository>(),
    ),
    defaultInput: GetEventsInput(accepted: widget.user.id),
  )..add(BaseEventsListingEvent.fetch());

  late final hostingEventsBloc = HostingEventsListingBloc(
    EventService(
      getIt<EventRepository>(),
    ),
    defaultInput: GetHostingEventsInput(id: widget.user.id),
  )..add(BaseEventsListingEvent.fetch());

  @override
  void initState() {
    super.initState();
  }

  setEventListingType(EventListingType _type) {
    setState(() {
      type = _type;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return BaseSliverTabView(
      name: "event",
      children: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
          sliver: SliverAppBar(
            pinned: true,
            collapsedHeight: _filterBarHeight,
            expandedHeight: _filterBarHeight,
            flexibleSpace: Container(
              color: colorScheme.primary,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  color: colorScheme.primary,
                  child: Column(
                    children: [
                      SizedBox(height: Spacing.smMedium),
                      Row(
                        children: [
                          LemonChip(
                            label: t.event.attended,
                            onTap: () => setEventListingType(EventListingType.attending),
                            isActive: type == EventListingType.attending,
                          ),
                          SizedBox(width: Spacing.superExtraSmall),
                          LemonChip(
                            label: t.event.created,
                            onTap: () => setEventListingType(EventListingType.hosting),
                            isActive: type == EventListingType.hosting,
                          ),
                        ],
                      ),
                      SizedBox(height: Spacing.smMedium),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (type == EventListingType.attending)
          BlocProvider.value(
            value: attendingEventsBloc,
            child: _EventList<AttendingEventListingBloc>(),
          ),
        if (type == EventListingType.hosting)
          BlocProvider.value(
            value: hostingEventsBloc,
            child: _EventList<HostingEventsListingBloc>(),
          ),
        SliverToBoxAdapter(
          child: SizedBox(height: 92),
        )
      ],
    );
  }
}

class _EventList<T extends BaseEventListingBloc> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return BlocBuilder<T, BaseEventsListingState>(
      builder: (context, state) {
        return state.when(failure: () {
          return SliverToBoxAdapter(
              child: Center(
            child: Text(t.common.somethingWrong),
          ));
        }, loading: () {
          return SliverToBoxAdapter(
            child: Loading.defaultLoading(context),
          );
        }, fetched: (events, filterEvents) {
          if (events.isEmpty) {
            return SliverToBoxAdapter(
              // hasScrollBody: false,
              child: Container(
                height: 250,
                // color: Colors.red,
                child: Center(
                  child: Text(t.event.empty_home_events(time: '')),
                ),
              ),
            );
          }
          return SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: Spacing.superExtraSmall,
                mainAxisSpacing: Spacing.superExtraSmall,
                childAspectRatio: 1.8,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  var event = events[index];
                  return _EventItem(
                    event: event,
                  );
                },
                childCount: events.length,
              ),
            ),
          );
        });
      },
    );
  }
}

class _EventItem extends StatelessWidget {
  final Event event;
  const _EventItem({
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).navigate(
          EventDetailRoute(eventId: event.id ?? '', eventName: event.title ?? ''),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: colorScheme.outline),
          borderRadius: BorderRadius.circular(LemonRadius.small),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: (event.newNewPhotosExpanded?.isNotEmpty == true)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                      child: CachedNetworkImage(
                        imageUrl: ImageUtils.generateUrl(
                            file: event.newNewPhotosExpanded!.first, imageConfig: ImageConfig.eventPhoto),
                        fit: BoxFit.cover,
                        errorWidget: (ctx, _, __) => ImagePlaceholder.eventCard(),
                      ),
                    )
                  : ImagePlaceholder.eventCard(),
            ),
            Positioned(
              bottom: Spacing.xSmall,
              left: Spacing.xSmall,
              child: Text.rich(
                TextSpan(
                  text: "${event.title}\n",
                  style: Typo.small.copyWith(fontWeight: FontWeight.w700),
                  children: [
                    TextSpan(
                      style: Typo.small.copyWith(color: colorScheme.onSurface),
                      text: DateFormatUtils.dateOnly(event.start),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
