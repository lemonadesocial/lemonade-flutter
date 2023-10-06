import 'package:app/core/application/community/community_bloc.dart';
import 'package:app/core/presentation/pages/community/widgets/community_user_tile.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/discover/discover_card.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommunityFriendView extends StatelessWidget {
  const CommunityFriendView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.all(Spacing.xSmall),
      child: Column(
        children: [
          LemonTextField(
            leadingIcon: ThemeSvgIcon(
              color: colorScheme.onSurfaceVariant,
              builder: (filter) => Assets.icons.icSearch.svg(
                colorFilter: filter,
                width: 18.w,
                height: 18.w,
                fit: BoxFit.scaleDown,
              ),
            ),
            hintText: t.setting.searchCommunity,
            contentPadding: EdgeInsets.all(Spacing.small),
            onChange: (value) =>
                context.read<CommunityBloc>().onSearchInputChange(
                      CommunityType.friend,
                      userId: AuthUtils.getUserId(context),
                      searchInput: value,
                    ),
          ),
          SizedBox(height: Spacing.small),
          Expanded(
            child: BlocBuilder<CommunityBloc, CommunityState>(
              builder: (context, state) {
                switch (state.status) {
                  case CommunityStatus.loading:
                    return Loading.defaultLoading(context);
                  case CommunityStatus.loaded:
                    return CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: DiscoverCard(
                                  title: t.setting.crew,
                                  subTitle: '0/5',
                                  icon: Assets.icons.icCrew.svg(),
                                  colors: DiscoverCardGradient.events.colors,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Spacing.medium,
                                    vertical: Spacing.smMedium,
                                  ),
                                  onTap: () {},
                                ),
                              ),
                              SizedBox(width: Spacing.extraSmall),
                              Expanded(
                                flex: 1,
                                child: DiscoverCard(
                                  title: t.setting.tribe,
                                  subTitle: '0/25',
                                  icon: Assets.icons.icDiscoverPeople.svg(),
                                  colors:
                                      DiscoverCardGradient.collaborators.colors,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Spacing.medium,
                                    vertical: Spacing.smMedium,
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(height: Spacing.superExtraSmall),
                        ),
                        state.friendList.isEmpty
                            ? SliverToBoxAdapter(
                                child: Center(
                                  child: EmptyList(
                                    emptyText: t.setting.empty.friend,
                                  ),
                                ),
                              )
                            : SliverList.separated(
                                itemCount: state.friendList.length,
                                itemBuilder: (context, index) =>
                                    CommunityUserTile(
                                  user: state.friendList[index],
                                ),
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: Spacing.superExtraSmall),
                              ),
                      ],
                    );
                  default:
                    return Center(
                      child: Text(t.common.somethingWrong),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
