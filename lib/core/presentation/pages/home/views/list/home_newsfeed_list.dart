import 'package:app/core/application/newsfeed/newsfeed_listing_bloc/newsfeed_listing_bloc.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/post/post_profile_card_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../widgets/bottom_bar/bottom_bar_widget.dart';

class HomeNewsfeedListView extends StatelessWidget {
  const HomeNewsfeedListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final refreshController = RefreshController();
    return Padding(
      padding: EdgeInsets.only(bottom: BottomBar.bottomBarHeight),
      child: BlocBuilder<NewsfeedListingBloc, NewsfeedListingState>(
        builder: (context, state) {
          if (state.posts.isEmpty) {
            return Center(
              child: EmptyList(emptyText: t.notification.emptyNotifications),
            );
          }
          if (state.status == NewsfeedStatus.failure) {
            return Center(
              child: Text(t.common.somethingWrong),
            );
          }
          return SmartRefresher(
            controller: refreshController,
            enablePullUp: true,
            onRefresh: () {
              context.read<NewsfeedListingBloc>().add(NewsfeedListingEvent.fetch());
              refreshController.refreshCompleted();
            },
            onLoading: () {
              // add load more here
              context.read<NewsfeedListingBloc>().add(NewsfeedListingEvent.fetch());
              refreshController.loadComplete();
            },
            child: ListView.separated(
              padding:
              EdgeInsetsDirectional.symmetric(vertical: Spacing.xSmall),
              itemBuilder: (ctx, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                child: PostProfileCard(
                  key: Key(state.posts[index].id),
                  post: state.posts[index],
                ),
              ),
              separatorBuilder: (ctx, index) =>
                  Divider(color: colorScheme.outline),
              itemCount: state.posts.length,
            ),
          );
        },
      ),
    );
  }
}
