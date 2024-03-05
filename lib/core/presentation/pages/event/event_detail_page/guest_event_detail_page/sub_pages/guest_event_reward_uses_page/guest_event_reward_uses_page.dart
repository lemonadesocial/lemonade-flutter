import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event/get_event_reward_uses_bloc/get_event_reward_uses_bloc.dart';
import 'package:app/core/domain/event/entities/event_reward_use.dart';
import 'package:app/core/domain/event/entities/reward.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/sub_pages/guest_event_reward_uses_page/widgets/guest_event_reward_uses_listing.dart';
import 'package:app/core/presentation/pages/event/my_event_ticket_page/widgets/ticket_qr_code_popup.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class GuestEventRewardUsesPage extends StatelessWidget {
  const GuestEventRewardUsesPage({super.key});

  @override
  Widget build(BuildContext context) {
    String userId = context.watch<AuthBloc>().state.maybeWhen(
              authenticated: (authSession) => authSession.userId,
              orElse: () => "",
            ) ??
        "";
    String eventId = context.watch<GetEventDetailBloc>().state.maybeWhen(
              fetched: (event) => event.id,
              orElse: () => "",
            ) ??
        "";
    return BlocProvider(
      create: (context) => GetEventRewardUsesBloc(eventId)
        ..add(
          GetEventRewardUsesEvent.getEventRewardUses(
            showLoading: true,
            userId: userId,
            eventId: eventId,
          ),
        ),
      child: _GuestEventRewardUsesPageView(userId: userId),
    );
  }
}

class _GuestEventRewardUsesPageView extends StatelessWidget {
  const _GuestEventRewardUsesPageView({required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    List<EventRewardUse> eventRewardUses =
        context.watch<GetEventRewardUsesBloc>().state.eventRewardUses ?? [];

    List<Reward> eventRewards =
        context.watch<GetEventDetailBloc>().state.maybeWhen(
              fetched: (event) => event.rewards ?? [],
              orElse: () => [],
            );
    int totalEventRewardUses = eventRewardUses.length;

    int totalLimitPer = eventRewards.fold<int>(
      0,
      (previousValue, element) => previousValue + (element.limitPer ?? 0),
    );

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: LemonAppBar(
        title: t.event.rewards,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Spacing.small),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const TicketQRCodePopup(),
                );
              },
              child: ThemeSvgIcon(
                builder: (filter) => Assets.icons.icQr.svg(
                  colorFilter: filter,
                  width: 27.w,
                  height: 27.w,
                ),
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            leading: const SizedBox.shrink(),
            collapsedHeight: kToolbarHeight + Spacing.superExtraSmall,
            pinned: true,
            flexibleSpace: Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.medium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.event.rewards,
                    style: Typo.superLarge.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w800,
                      fontFamily: FontFamily.nohemiVariable,
                    ),
                  ),
                  Text(
                    '$totalEventRewardUses/$totalLimitPer ${t.common.claimed}',
                    style: Typo.medium.copyWith(
                      color: colorScheme.onSecondary,
                      fontWeight: FontWeight.w800,
                      fontFamily: FontFamily.nohemiVariable,
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<GetEventRewardUsesBloc, GetEventRewardUsesState>(
            builder: (context, state) {
              if (state.initialLoading == true) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: Spacing.large),
                    child: Loading.defaultLoading(context),
                  ),
                );
              }
              return const GuestEventRewardUsesListing();
            },
          ),
        ],
      ),
    );
  }
}
