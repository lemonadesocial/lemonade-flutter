import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/post/post_profile_card_widget.dart';
import 'package:app/ferry_client.dart';
import 'package:app/graphql/__generated__/get_newsfeed.data.gql.dart';
import 'package:app/graphql/__generated__/get_newsfeed.req.gql.dart';
import 'package:app/graphql/__generated__/get_newsfeed.var.gql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeNewsfeedListView extends StatelessWidget {
  final client = getIt<FerryClient>().client;

  final getNewsfeedReq = GGetNewsfeedReq(
    (b) => b..requestId = 'getNewsfeed',
  );

  HomeNewsfeedListView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    // final colorScheme = Theme.of(context).colorScheme;
    // final bloc = context.read<NewsfeedListingBloc>();
    // final refreshController = RefreshController();

    onLoadMore() {
      if (kDebugMode) {
        print("onLoadMore");
      }
    }

    return Operation<GGetNewsfeedData, GGetNewsfeedVars>(
      client: client,
      operationRequest: getNewsfeedReq,
      builder: (context, response, error) {
        if (response!.loading) {
          return Loading.defaultLoading(context);
        }
        ScrollController scrollController = ScrollController();
        scrollController.addListener(() {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            onLoadMore();
          }
        });
        final posts = response.data?.getNewsfeed?.posts.toBuiltList();

        return ListView.builder(
          controller: scrollController,
          itemCount: posts?.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
            child: PostProfileCard(
              key: Key(posts![index].G_id.value),
              post: posts[index],
            ),
          ),
        );
      },
    );

    // return BlocListener<AuthBloc, AuthState>(
    //   listener: (context, state) {
    //     state.maybeWhen(
    //       authenticated: (_) => context
    //           .read<NewsfeedListingBloc>()
    //           .add(NewsfeedListingEvent.refresh()),
    //       unauthenticated: (_) => context
    //           .read<NewsfeedListingBloc>()
    //           .add(NewsfeedListingEvent.refresh()),
    //       orElse: () {},
    //     );
    //   },
    //   child: BlocConsumer<NewsfeedListingBloc, NewsfeedListingState>(
    //     listener: (context, state) {
    //       if (state.scrollToTopEvent) {
    //         bloc.scrollController
    //             .animateTo(
    //               bloc.scrollController.position.minScrollExtent,
    //               duration: const Duration(milliseconds: 500),
    //               curve: Curves.easeIn,
    //             )
    //             //Reset state
    //             .then(
    //               (_) => bloc.add(
    //                 NewsfeedListingEvent.scrollToTop(scrollToTopEvent: false),
    //               ),
    //             );
    //       }
    //     },
    //     builder: (context, state) {
    //       if (state.posts.isEmpty) {
    //         if (state.status != NewsfeedStatus.fetched) {
    //           return Loading.defaultLoading(context);
    //         } else {
    //           return Center(
    //             child: EmptyList(emptyText: t.notification.emptyNotifications),
    //           );
    //         }
    //       }
    //       if (state.status == NewsfeedStatus.failure) {
    //         return Center(
    //           child: Text(t.common.somethingWrong),
    //         );
    //       }
    //       return SmartRefresher(
    //         controller: refreshController,
    //         enablePullUp: true,
    //         onRefresh: () {
    //           context
    //               .read<NewsfeedListingBloc>()
    //               .add(NewsfeedListingEvent.refresh());
    //           refreshController.refreshCompleted();
    //         },
    //         onLoading: () {
    //           // add load more here
    //           context
    //               .read<NewsfeedListingBloc>()
    //               .add(NewsfeedListingEvent.fetch());
    //           refreshController.loadComplete();
    //         },
    //         footer: const ClassicFooter(
    //           height: 100,
    //           loadStyle: LoadStyle.ShowWhenLoading,
    //         ),
    //         child: ListView.separated(
    //           controller: bloc.scrollController,
    //           padding:
    //               EdgeInsetsDirectional.symmetric(vertical: Spacing.xSmall),
    //           itemBuilder: (ctx, index) => Padding(
    //             padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
    //             child: PostProfileCard(
    //               key: Key(state.posts[index].id),
    //               post: state.posts[index],
    //             ),
    //           ),
    //           separatorBuilder: (ctx, index) =>
    //               Divider(color: colorScheme.outline),
    //           itemCount: state.posts.length,
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
