import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/post_guest_event_animated_app_bar.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/widgets/host_event_basic_info_card.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/widgets/host_event_detail_config_grid.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/widgets/host_event_location.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/widgets/host_event_poap_reward_card.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HostEventDetailView extends StatelessWidget {
  const HostEventDetailView({super.key});

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
                    padding: EdgeInsets.only(top: 6.h),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                    sliver: SliverToBoxAdapter(
                      child: HostEventBasicInfoCard(event: event),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(top: 36.h),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                    sliver: HostEventDetailConfigGrid(
                      event: event,
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(top: 42.h),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                    sliver: SliverToBoxAdapter(
                      child: HostEventPoapRewardCard(event: event),
                    ),
                  ),
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
                        child: HostEventLocation(event: event),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
