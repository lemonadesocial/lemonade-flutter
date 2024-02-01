import 'package:app/core/application/community/community_bloc.dart';
import 'package:app/core/domain/community/community_repository.dart';
import 'package:app/core/presentation/pages/community/widgets/community_followee_view.dart';
import 'package:app/core/presentation/pages/community/widgets/community_follower_view.dart';
import 'package:app/core/presentation/pages/community/widgets/community_friend_view.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/tabbar_indicator/custom_tabbar_indicator.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final userId = AuthUtils.getUserId(context);
    return BlocProvider(
      create: (context) => CommunityBloc(getIt<CommunityRepository>())
        ..getListFriend(userId)
        ..getListFollower(userId)
        ..getListFollowee(userId),
      child: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          backgroundColor: colorScheme.primary,
          appBar: LemonAppBar(
            title: t.setting.community,
          ),
          body: Column(
            children: [
              TabBar(
                labelStyle: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w500,
                ),
                unselectedLabelStyle: Typo.medium.copyWith(
                  color: colorScheme.onPrimary.withOpacity(0.36),
                  fontWeight: FontWeight.w500,
                ),
                indicator: CustomTabIndicator(color: LemonColor.paleViolet),
                indicatorPadding: EdgeInsets.symmetric(horizontal: 32.w),
                tabs: <Widget>[
                  Tab(text: t.setting.friend),
                  Tab(text: t.setting.follower),
                  Tab(text: t.setting.following),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    CommunityFriendView(),
                    CommunityFollowerView(),
                    CommunityFolloweeView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
