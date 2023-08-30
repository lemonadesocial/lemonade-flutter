import 'package:app/core/application/badge/badge_near_you_bloc/badge_near_you_bloc.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/poap/hot_badge_item/hot_badge_item.dart';
import 'package:app/core/utils/location_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';

class DiscoverBadgesNearYou extends StatelessWidget {
  const DiscoverBadgesNearYou({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: getIt<LocationUtils>().checkAndRequestPermission(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final hasLocationAccess = snapshot.data!;
          if (hasLocationAccess) {
            return BlocProvider(
              create: (context) => BadgesNearYouBloc()
                ..add(
                  BadgesNearYouEvent.fetch(),
                ),
              child: const _DiscoverBadgesNearYouView(),
            );
          }
        }

        return const SliverToBoxAdapter(
          child: SizedBox.shrink(),
        );
      },
    );
  }
}

class _DiscoverBadgesNearYouView extends StatelessWidget {
  const _DiscoverBadgesNearYouView();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return MultiSliver(
      children: [
        SliverPadding(
          padding: EdgeInsets.symmetric(
            vertical: Spacing.xSmall,
            horizontal: Spacing.xSmall,
          ),
          sliver: SliverToBoxAdapter(
            child: Text(
              t.discover.hotBadgesNearYou,
              style: Typo.medium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        BlocBuilder<BadgesNearYouBloc, BadgesNearYouState>(
          builder: (context, state) {
            return state.when(
              failure: () => SliverToBoxAdapter(
                child: EmptyList(
                  emptyText: t.common.somethingWrong,
                ),
              ),
              initial: () => SliverToBoxAdapter(
                child: Loading.defaultLoading(context),
              ),
              fetched: (badges) {
                if (badges.isEmpty) {
                  return SliverToBoxAdapter(
                    child: EmptyList(
                      emptyText: t.nft.noBadges,
                    ),
                  );
                }
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: 226.w,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => HotBadgeItem(
                        badge: badges[index],
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        width: Spacing.xSmall,
                      ),
                      itemCount: badges.length,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
