import 'dart:ui';

import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_about_card.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_basic_info.dart';
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
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            ),
          ),
          loading: () => Loading.defaultLoading(context),
          fetched: (event) {
            return SafeArea(
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
                      SliverPadding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                        sliver: SliverToBoxAdapter(
                          child: GuestEventDetailBasicInfo(event: event),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.only(top: Spacing.xLarge),
                      ),
                      SliverPadding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Spacing.smMedium),
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
                      if (event.latitude != null &&
                          event.longitude != null) ...[
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
                        child: SizedBox(height: Spacing.xLarge * 2),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 100.h,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(33, 33, 33, 0.87),
                            Color.fromRGBO(23, 23, 23, 0.87),
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(LemonRadius.normal),
                          topRight: Radius.circular(LemonRadius.normal),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: Spacing.small,
                        horizontal: Spacing.medium,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(LemonRadius.normal),
                          topRight: Radius.circular(LemonRadius.normal),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              InkWell(
                                onTap: () {
                                  AutoRouter.of(context)
                                      .navigate(const EventProgramRoute());
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 54.w,
                                      height: 42.h,
                                      decoration: BoxDecoration(
                                        color: colorScheme.onPrimary
                                            .withOpacity(0.06),
                                        borderRadius:
                                            BorderRadius.circular(21.r),
                                      ),
                                      child: Icon(
                                        Icons.home,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary, // Adjust the icon color as needed
                                      ),
                                    ),
                                    const Text('Program'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
