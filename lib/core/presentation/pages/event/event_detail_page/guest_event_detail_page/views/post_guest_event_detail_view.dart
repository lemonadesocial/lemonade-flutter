import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_about_card.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_basic_info.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_dashboard.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_hosts.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_photos.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_location.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_poap_offers.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/post_guest_event_animated_app_bar.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/widgets/create_sub_side_event_button.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/widgets/event_detail_floating_menu_button.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/widgets/event_detail_navigation_bar.dart';
import 'package:app/core/presentation/pages/farcaster/widgets/cast_on_farcaster_button/cast_on_farcaster_button.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PostGuestEventDetailView extends StatelessWidget {
  const PostGuestEventDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<GetEventDetailBloc, GetEventDetailState>(
      builder: (context, state) => state.when(
        failure: () => Scaffold(
          backgroundColor: colorScheme.primary,
          body: Center(
            child: EmptyList(
              emptyText: t.common.somethingWrong,
            ),
          ),
        ),
        loading: () => Scaffold(
          backgroundColor: colorScheme.primary,
          body: Loading.defaultLoading(context),
        ),
        fetched: (event) {
          final widgets = [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.smMedium,
              ),
              child: GuestEventDetailBasicInfo(event: event),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.smMedium,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GuestEventDetailDashboard(event: event),
                  SizedBox(height: Spacing.xSmall),
                  CastOnFarcasterButton(
                    event: event,
                  ),
                ],
              ),
            ),
            if (event.subeventEnabled == true) ...[
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.smMedium,
                ),
                child: CreateSubSideEventButton(
                  event: event,
                ),
              ),
            ],
            if (EventUtils.hasPoapOffers(event))
              GuestEventPoapOffers(
                event: event,
              ),
            if (event.latitude != null && event.longitude != null)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.smMedium,
                ),
                child: GuestEventLocation(event: event),
              ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.smMedium,
              ),
              child: GuestEventDetailAboutCard(event: event),
            ),
            if ((event.newNewPhotosExpanded ?? []).isNotEmpty)
              GuestEventDetailPhotos(event: event),
            GuestEventDetailHosts(event: event),
          ];
          return Scaffold(
            floatingActionButton: EventDetailFloatingMenuButton(
              onTap: () {
                showCupertinoModalBottomSheet(
                  context: context,
                  expand: false,
                  barrierColor: Colors.black.withOpacity(0.5),
                  backgroundColor: LemonColor.atomicBlack,
                  topRadius: Radius.circular(LemonRadius.normal),
                  useRootNavigator: true,
                  builder: (context) {
                    return EventDetailNavigationBar(
                      event: event,
                    );
                  },
                );
              },
            ),
            body: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: PostGuestEventAnimatedAppBar(
                          event: event,
                        ),
                      ),
                      SliverList.separated(
                        itemCount: widgets.length,
                        itemBuilder: (context, index) {
                          return widgets[index];
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: Spacing.smMedium * 2,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(height: Spacing.xLarge * 3),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
