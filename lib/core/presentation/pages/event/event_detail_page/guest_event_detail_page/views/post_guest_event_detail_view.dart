import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_about_card.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_clock.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_dashboard.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_hosts.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_photos.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_location.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_poap_offers.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/post_guest_event_animated_app_bar.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostGuestEventDetailView extends StatelessWidget {
  const PostGuestEventDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: BlocBuilder<GetEventDetailBloc, GetEventDetailState>(
        builder: (context, state) => state.when(
          failure: () => Center(
            child: EmptyList(
              emptyText: t.common.somethingWrong,
            ),
          ),
          loading: () => Loading.defaultLoading(context),
          fetched: (event) {
            return SafeArea(
              bottom: false,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: PostGuestEventAnimatedAppBar(
                      event: event,
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                    sliver: SliverToBoxAdapter(
                      child: GuestEventDetailClock(event: event),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(top: Spacing.smMedium * 2),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                    sliver: SliverToBoxAdapter(
                      child: GuestEventDetailDashboard(event: event),
                    ),
                  ),
                  if (EventUtils.hasPoapOffers(event)) ...[
                    SliverPadding(
                      padding: EdgeInsets.only(
                        top: Spacing.smMedium * 2,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: GuestEventPoapOffers(
                        event: event,
                      ),
                    ),
                  ],
                  SliverPadding(
                    padding: EdgeInsets.only(top: Spacing.smMedium),
                  ),
                  if (event.latitude != null && event.longitude != null) ...[
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        vertical: Spacing.smMedium,
                        horizontal: Spacing.smMedium,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: GuestEventLocation(event: event),
                      ),
                    ),
                  ],
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      vertical: Spacing.smMedium,
                      horizontal: Spacing.smMedium,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: GuestEventDetailAboutCard(event: event),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(
                      top: Spacing.smMedium,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: GuestEventDetailPhotos(event: event),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      vertical: Spacing.smMedium,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: GuestEventDetailHosts(event: event),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: bottomPadding),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
