import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/newsfeed/newsfeed_listing_bloc/newsfeed_listing_bloc.dart';
import 'package:app/core/presentation/pages/farcaster/widgets/connect_farcaster_button/connect_farcaster_button.dart';
import 'package:app/core/presentation/pages/farcaster/widgets/farcaster_channels_list/farcaster_channel_list.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/post/post_profile_card_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class HomeNewsfeedListView extends StatefulWidget {
  const HomeNewsfeedListView({
    super.key,
  });

  @override
  State<HomeNewsfeedListView> createState() => _HomeNewsfeedListViewState();
}

class _HomeNewsfeedListViewState extends State<HomeNewsfeedListView> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final bloc = context.read<NewsfeedListingBloc>();
    final refreshController = RefreshController();

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          authenticated: (_) => context
              .read<NewsfeedListingBloc>()
              .add(NewsfeedListingEvent.refresh()),
          unauthenticated: (_) => context
              .read<NewsfeedListingBloc>()
              .add(NewsfeedListingEvent.refresh()),
          orElse: () {},
        );
      },
      builder: (context, authState) =>
          BlocConsumer<NewsfeedListingBloc, NewsfeedListingState>(
        listener: (context, state) {
          if (state.scrollToTopEvent) {
            bloc.scrollController
                .animateTo(
                  bloc.scrollController.position.minScrollExtent,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                )
                //Reset state
                .then(
                  (_) => bloc.add(
                    NewsfeedListingEvent.scrollToTop(scrollToTopEvent: false),
                  ),
                );
          }
        },
        builder: (context, state) {
          if (state.posts.isEmpty) {
            if (state.status != NewsfeedStatus.fetched) {
              return Loading.defaultLoading(context);
            } else {
              return Center(
                child: EmptyList(emptyText: t.notification.emptyNotifications),
              );
            }
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
              setState(() {});
              context
                  .read<NewsfeedListingBloc>()
                  .add(NewsfeedListingEvent.refresh());
              refreshController.refreshCompleted();
            },
            onLoading: () {
              // add load more here
              context
                  .read<NewsfeedListingBloc>()
                  .add(NewsfeedListingEvent.fetch());
              refreshController.loadComplete();
            },
            footer: const ClassicFooter(
              height: 100,
              loadStyle: LoadStyle.ShowWhenLoading,
            ),
            child: CustomScrollView(
              controller: bloc.scrollController,
              slivers: [
                const SliverToBoxAdapter(
                  child: FarcasterChannelsList(),
                ),
                Builder(
                  builder: (context) {
                    final loggedInUser =
                        context.watch<AuthBloc>().state.maybeWhen(
                              orElse: () => null,
                              authenticated: (user) => user,
                            );
                    final isConnected = loggedInUser
                            ?.farcasterUserInfo?.accountKeyRequest?.accepted ==
                        true;
                    if (isConnected) {
                      return const SliverToBoxAdapter(
                        child: SizedBox.shrink(),
                      );
                    }
                    return SliverPadding(
                      padding: EdgeInsets.symmetric(
                        vertical: Spacing.xSmall,
                        horizontal: Spacing.xSmall,
                      ),
                      sliver: const SliverToBoxAdapter(
                        child: ConnectFarcasterButton(
                          variant: ConnectFarcasterButtonVariant.home,
                        ),
                      ),
                    );
                  },
                ),
                SliverPadding(
                  padding:
                      EdgeInsetsDirectional.symmetric(vertical: Spacing.xSmall),
                  sliver: SliverList.separated(
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
