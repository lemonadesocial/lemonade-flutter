import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/presentation/pages/event/guest_event_detail_page/widgets/guest_event_detail_about_card.dart';
import 'package:app/core/presentation/pages/event/guest_event_detail_page/widgets/guest_event_detail_clock.dart';
import 'package:app/core/presentation/pages/event/guest_event_detail_page/widgets/guest_event_detail_dashboard.dart';
import 'package:app/core/presentation/pages/event/guest_event_detail_page/widgets/guest_event_detail_hosts.dart';
import 'package:app/core/presentation/pages/event/guest_event_detail_page/widgets/guest_event_detail_photos.dart';
import 'package:app/core/presentation/pages/event/guest_event_detail_page/widgets/guest_event_location.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_animated_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/lemon_back_button_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class PostGuestEventDetailView extends StatelessWidget {
  const PostGuestEventDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: BlocBuilder<GetEventDetailBloc, GetEventDetailState>(
        builder: (context, state) => state.when(
          failure: () => Center(
              child: EmptyList(
            emptyText: t.common.somethingWrong,
          )),
          loading: () => Loading.defaultLoading(context),
          fetched: (event) {
            return SafeArea(
              child: Stack(
                children: [
                  CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: LemonAnimatedAppBar(
                          title: event.title ?? '',
                          leading:
                              LemonBackButton(color: colorScheme.onPrimary),
                          actions: [
                            InkWell(
                              onTap: () {
                                Share.share(
                                    '${AppConfig.webUrl}/event/${event.id}');
                              },
                              child: SizedBox(
                                height: Sizing.small,
                                width: Sizing.small,
                                child: ThemeSvgIcon(
                                  color: colorScheme.onPrimary,
                                  builder: (filter) => Assets.icons.icShare
                                      .svg(colorFilter: filter),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SliverPadding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                        sliver: SliverToBoxAdapter(
                          child: GuestEventDetailClock(event: event),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.only(top: Spacing.smMedium * 2),
                      ),
                      SliverPadding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Spacing.smMedium),
                          sliver: SliverToBoxAdapter(
                            child: GuestEventDetailDashboard(event: event),
                          )),
                      SliverPadding(
                        padding: EdgeInsets.only(top: Spacing.smMedium),
                      ),
                      if (event.latitude != null &&
                          event.longitude != null) ...[
                        SliverPadding(
                          padding: EdgeInsets.only(top: Spacing.smMedium),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Spacing.smMedium),
                          sliver: SliverToBoxAdapter(
                            child: GuestEventLocation(event: event),
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.only(
                            bottom: Spacing.smMedium,
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
                    ],
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
