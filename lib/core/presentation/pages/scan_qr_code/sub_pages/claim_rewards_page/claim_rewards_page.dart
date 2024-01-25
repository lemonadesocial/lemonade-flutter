import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event/claim_rewards_bloc/claim_rewards_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/domain/event/entities/reward.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    List<Reward> rewards = context.watch<GetEventDetailBloc>().state.maybeWhen(
              fetched: (event) => event.rewards,
              orElse: () => [],
            ) ??
        [];
    String eventId = context.watch<GetEventDetailBloc>().state.maybeWhen(
              fetched: (event) => event.id,
              orElse: () => "",
            ) ??
        "";
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ClaimRewardsBloc(eventId)
            ..add(ClaimRewardsEvent.getUserDetail(userId: userId)),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                        child: Text(
                          state.scannedUserDetail?.name ?? '',
                          style: Typo.large.copyWith(
                            color: colorScheme.onPrimary,
                            fontSize: 24.sp,
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
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, sectionIndex) {
                  final reward = rewards[sectionIndex];
                  return Column(
                    children: [
                      BlocBuilder<ClaimRewardsBloc, ClaimRewardsState>(
                        builder: (context, state) {
                          return ListTile(
                            title: Text(reward.title ?? ''),
                          );
                        },
                      ),
                      HorizontalListWidget(
                        reward: reward,
                      ),
                    ],
                  );
                },
                childCount: rewards.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HorizontalListWidget extends StatelessWidget {
  const HorizontalListWidget({super.key, required this.reward});
  final Reward reward;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizing.regular,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: reward.limitPer,
        itemBuilder: (context, index) {
          final fullIconUrl = '${AppConfig.assetPrefix}${reward.iconUrl}';
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
            child: Opacity(
              opacity: 1,
              child: Container(
                width: Sizing.regular,
                height: Sizing.regular,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(LemonRadius.large),
                  border: Border.all(
                    width: 2.w,
                    color: Colors.yellow,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    LemonRadius.large,
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.contain,
                    imageUrl: fullIconUrl,
                    placeholder: (_, __) =>
                        ImagePlaceholder.defaultPlaceholder(),
                    errorWidget: (_, __, ___) =>
                        ImagePlaceholder.defaultPlaceholder(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
