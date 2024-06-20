import 'package:app/core/application/community/community_bloc.dart';
import 'package:app/core/domain/community/community_repository.dart';
import 'package:app/core/presentation/pages/discover/discover_page/widgets/community_spotlight_item.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';

class DiscoverCommunities extends StatelessWidget {
  const DiscoverCommunities({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return MultiSliver(
      children: [
        SliverPadding(
          padding: EdgeInsets.symmetric(
            vertical: Spacing.xSmall,
            horizontal: Spacing.xSmall,
          ),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Text(
                  t.discover.communities,
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: Spacing.extraSmall),
                ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (filter) => Assets.icons.icArrowRight.svg(
                    colorFilter: filter,
                    width: Sizing.mSmall,
                    height: Sizing.mSmall,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: Spacing.superExtraSmall,
        ),
        BlocProvider(
          create: (context) =>
              CommunityBloc(getIt<CommunityRepository>())..getUsersSpotlight(),
          child: const _DiscoverCommunitiesList(),
        ),
      ],
    );
  }
}

class _DiscoverCommunitiesList extends StatelessWidget {
  const _DiscoverCommunitiesList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityBloc, CommunityState>(
      builder: (context, state) {
        switch (state.status) {
          case CommunityStatus.loading:
            return SliverToBoxAdapter(
              child: Loading.defaultLoading(context),
            );
          case CommunityStatus.loaded:
            return state.usersSpotlightList.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: EmptyList(
                        emptyText: t.discover.emptyCommunities,
                      ),
                    ),
                  )
                : SliverToBoxAdapter(
                    child: SizedBox(
                      height: 138.w,
                      child: ListView.separated(
                        padding:
                            EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            final userId = state.usersSpotlightList[index].id;
                            AutoRouter.of(context).navigate(
                              ProfileRoute(userId: userId),
                            );
                          },
                          child: CommunitySpotlightItem(
                            user: state.usersSpotlightList[index],
                          ),
                        ),
                        separatorBuilder: (_, __) =>
                            SizedBox(width: Spacing.small),
                        itemCount: state.usersSpotlightList.length,
                      ),
                    ),
                  );
          default:
            return Center(
              child: Text(t.common.somethingWrong),
            );
        }
      },
    );
  }
}
