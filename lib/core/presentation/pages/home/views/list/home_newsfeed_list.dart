import 'package:app/core/application/newsfeed/newsfeed_listing_bloc/newsfeed_listing_bloc.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/post/post_profile_card_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class HomeNewsfeedListView extends StatelessWidget {
  const HomeNewsfeedListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final _refreshController = RefreshController();
    return BlocBuilder<NewsfeedListingBloc, NewsfeedListingState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => Loading.defaultLoading(context),
          fetched: (newsfeed) {
            if (newsfeed.isEmpty) {
              return Center(
                child: EmptyList(emptyText: t.notification.emptyNotifications),
              );
            }
            return SmartRefresher(
              controller: _refreshController,
              enablePullUp: true,
              onRefresh: () {
                context
                    .read<NewsfeedListingBloc>()
                    .add(NewsfeedListingEvent.fetch());
                _refreshController.refreshCompleted();
              },
              onLoading: () {
                // add load more here
                context
                    .read<NewsfeedListingBloc>()
                    .add(NewsfeedListingEvent.fetch());
                _refreshController.loadComplete();
              },
              child: ListView.separated(
                padding:
                    EdgeInsetsDirectional.symmetric(vertical: Spacing.xSmall),
                itemBuilder: (ctx, index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                  child: PostProfileCard(
                    key: Key(newsfeed[index].id),
                    post: newsfeed[index],
                  ),
                ),
                separatorBuilder: (ctx, index) =>
                    Divider(color: colorScheme.outline),
                itemCount: newsfeed.length,
              ),
            );
          },
          failure: () => Center(
            child: Text(t.common.somethingWrong),
          ),
        );
      },
    );
  }
}
