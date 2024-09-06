import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/newsfeed/newsfeed_listing_bloc/newsfeed_listing_bloc.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/post/post_profile_card_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscoverPosts extends StatefulWidget {
  const DiscoverPosts({
    super.key,
  });

  @override
  State<DiscoverPosts> createState() => _DiscoverPostsState();
}

class _DiscoverPostsState extends State<DiscoverPosts> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final bloc = context.read<NewsfeedListingBloc>();

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
              return SliverToBoxAdapter(
                child: Loading.defaultLoading(context),
              );
            } else {
              return SliverToBoxAdapter(
                child: Center(
                  child:
                      EmptyList(emptyText: t.notification.emptyNotifications),
                ),
              );
            }
          }
          if (state.status == NewsfeedStatus.failure) {
            return SliverToBoxAdapter(
              child: Center(
                child: Text(t.common.somethingWrong),
              ),
            );
          }

          return SliverPadding(
            padding: EdgeInsetsDirectional.symmetric(
              vertical: Spacing.medium,
            ),
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
          );
        },
      ),
    );
  }
}
