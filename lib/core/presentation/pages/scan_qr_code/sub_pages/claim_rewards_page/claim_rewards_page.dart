import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event/claim_rewards_bloc/claim_rewards_bloc.dart';
import 'package:app/core/presentation/pages/scan_qr_code/sub_pages/claim_rewards_page/widgets/claim_rewards_listing.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ClaimRewardsPage extends StatelessWidget {
  final String userId;
  const ClaimRewardsPage({
    super.key,
    @PathParam("userId") required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    String eventId = context.watch<GetEventDetailBloc>().state.maybeWhen(
              fetched: (event) => event.id,
              orElse: () => "",
            ) ??
        "";
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ClaimRewardsBloc(eventId)
            ..add(ClaimRewardsEvent.getUserDetail(userId: userId))
            ..add(
              ClaimRewardsEvent.getEventRewardUses(
                showLoading: true,
                userId: userId,
                eventId: eventId,
              ),
            ),
        ),
      ],
      child: Scaffold(
        backgroundColor: colorScheme.background,
        appBar: LemonAppBar(
          title: t.event.rewards,
        ),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              leading: const SizedBox.shrink(),
              collapsedHeight: kToolbarHeight,
              pinned: true,
              flexibleSpace: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<ClaimRewardsBloc, ClaimRewardsState>(
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: Spacing.smMedium,
                          right: Spacing.smMedium,
                          top: Spacing.xSmall,
                        ),
                        child: Text(
                          state.scannedUserDetail?.name ?? '',
                          style: Typo.superLarge.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w800,
                            fontFamily: FontFamily.nohemiVariable,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<ClaimRewardsBloc, ClaimRewardsState>(
                builder: (context, state) {
              if (state.initialLoading == true) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: Spacing.large),
                    child: Loading.defaultLoading(context),
                  ),
                );
              }
              return ClaimRewardsListing(userId: userId);
            }),
          ],
        ),
      ),
    );
  }
}
