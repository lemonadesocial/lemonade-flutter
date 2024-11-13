import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/reward.dart';
import 'package:app/core/presentation/pages/event/event_settings_page/sub_pages/event_reward_setting_page/sub_pages/event_rewards_listing_page/widgets/reward_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class EventRewardsListingPage extends StatelessWidget {
  const EventRewardsListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final rewards = context.watch<GetEventDetailBloc>().state.maybeWhen(
              fetched: (event) => event.rewards,
              orElse: () => [] as List<Reward>,
            ) ??
        [];
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: LemonAppBar(
        title: t.event.rewards,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                if (rewards.isEmpty)
                  const SliverToBoxAdapter(
                    child: EmptyList(),
                  ),
                if (rewards.isNotEmpty)
                  SliverList.separated(
                    itemCount: rewards.length,
                    itemBuilder: (context, index) {
                      return RewardItem(
                        reward: rewards[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                      height: Spacing.large,
                    ),
                  ),
                SliverToBoxAdapter(
                  child: SizedBox(height: Spacing.xLarge * 3),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: colorScheme.background,
              padding: EdgeInsets.all(Spacing.smMedium),
              child: SafeArea(
                child: LinearGradientButton(
                  onTap: () {
                    AutoRouter.of(context).navigate(EventCreateRewardRoute());
                  },
                  height: 42.w,
                  leading: Assets.icons.icAdd.svg(),
                  radius: BorderRadius.circular(LemonRadius.small * 2),
                  mode: GradientButtonMode.lavenderMode,
                  label: t.common.addNew,
                  textStyle: Typo.medium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
