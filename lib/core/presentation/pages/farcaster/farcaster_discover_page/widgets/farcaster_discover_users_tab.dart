import 'package:app/core/domain/farcaster/entities/airstack_farcaster_cast.dart';
import 'package:app/core/presentation/pages/farcaster/farcaster_discover_page/widgets/farcaster_discover_user_item_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/debouncer.dart';
import 'package:app/core/utils/gql/widgets/airstack_gql_provider_widget.dart';
import 'package:app/graphql/farcaster_airstack/query/get_farcaster_users.graphql.dart';
import 'package:app/graphql/farcaster_airstack/schema.graphql.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class FarcasterDiscoverUsersTab extends StatefulWidget {
  final TextEditingController textController;
  const FarcasterDiscoverUsersTab({
    super.key,
    required this.textController,
  });

  @override
  State<FarcasterDiscoverUsersTab> createState() =>
      _FarcasterDiscoverUsersTabState();
}

class _FarcasterDiscoverUsersTabState extends State<FarcasterDiscoverUsersTab> {
  final debouncer = Debouncer(milliseconds: 500);
  final _refreshController = RefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => AirstackGQLProviderWidget(
        child: Query$GetFarcasterUsers$Widget(
          options: Options$Query$GetFarcasterUsers(
            variables: Variables$Query$GetFarcasterUsers(
              filter: Input$SocialFilter(),
            ),
            onComplete: (_, __) {
              _refreshController.refreshCompleted();
            },
          ),
          builder: (result, {refetch, fetchMore}) {
            return _UsersListView(
              textController: widget.textController,
              refreshController: _refreshController,
              debouncer: debouncer,
              result: result,
              refetch: refetch,
              fetchMore: fetchMore,
            );
          },
        ),
      ),
    );
  }
}

class _UsersListView extends StatefulWidget {
  const _UsersListView({
    required this.textController,
    required this.refreshController,
    required this.debouncer,
    required this.result,
    required this.refetch,
    required this.fetchMore,
  });

  final TextEditingController textController;
  final Debouncer debouncer;
  final RefreshController refreshController;
  final QueryResult<Query$GetFarcasterUsers> result;
  final Future<QueryResult<Query$GetFarcasterUsers>?> Function()? refetch;
  final Future<QueryResult<Query$GetFarcasterUsers>> Function(FetchMoreOptions)?
      fetchMore;

  @override
  State<_UsersListView> createState() => _UsersListViewState();
}

class _UsersListViewState extends State<_UsersListView> {
  @override
  void initState() {
    super.initState();
    widget.textController.addListener(() {
      widget.debouncer.run(() {
        if (widget.textController.text.isEmpty) {
          widget.fetchMore?.call(
            FetchMoreOptions$Query$GetFarcasterUsers(
              variables: Variables$Query$GetFarcasterUsers(
                filter: Input$SocialFilter(),
              ),
              updateQuery: (prev, next) => next,
            ),
          );
          return;
        }
        widget.fetchMore?.call(
          FetchMoreOptions$Query$GetFarcasterUsers(
            variables: Variables$Query$GetFarcasterUsers(
              limit: 50,
              filter: Input$SocialFilter(
                profileName: Input$Regex_String_Comparator_Exp(
                  $_regex: "^${widget.textController.text}",
                ),
              ),
            ),
            updateQuery: (prev, next) => next,
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final users = (widget.result.parsedData?.Socials?.Social ?? [])
        .map(
          (item) => AirstackFarcasterUser.fromJson(
            item.toJson(),
          ),
        )
        .toList();
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (notification.metrics.pixels ==
              notification.metrics.maxScrollExtent) {
            final pageInfo = widget.result.parsedData?.Socials?.pageInfo;
            if (widget.result.isLoading ||
                pageInfo?.hasNextPage == false ||
                widget.textController.text.isNotEmpty) {
              return true;
            }

            final fetchMoreOptions = FetchMoreOptions$Query$GetFarcasterUsers(
              variables: Variables$Query$GetFarcasterUsers(
                filter: Input$SocialFilter(),
                cursor: pageInfo?.nextCursor,
              ),
              updateQuery: (prevResult, nextResult) {
                final prevList =
                    prevResult?['Socials']?['Social'] as List<dynamic>? ?? [];
                final nextList =
                    nextResult?['Socials']?['Social'] as List<dynamic>? ?? [];
                final newList = [...prevList, ...nextList];
                nextResult?['Socials']['Social'] = newList;
                return nextResult;
              },
            );
            widget.debouncer.run(
              () => widget.fetchMore?.call(fetchMoreOptions),
            );
          }
        }
        return true;
      },
      child: SmartRefresher(
        controller: widget.refreshController,
        onRefresh: () async {
          widget.refetch?.call();
        },
        child: CustomScrollView(
          slivers: [
            if (widget.result.isLoading && users.isEmpty)
              SliverToBoxAdapter(
                child: Loading.defaultLoading(context),
              ),
            if (widget.result.isNotLoading && users.isEmpty)
              const SliverToBoxAdapter(
                child: EmptyList(),
              ),
            SliverList.separated(
              itemCount: users.length + 1,
              separatorBuilder: (context, index) => Divider(
                color: colorScheme.outline,
              ),
              itemBuilder: (context, index) {
                if (index == users.length) {
                  if (widget
                          .result.parsedData?.Socials?.pageInfo?.hasNextPage !=
                      true) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Spacing.medium,
                    ),
                    child: Loading.defaultLoading(context),
                  );
                }
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.xSmall,
                    vertical: Spacing.xSmall,
                  ),
                  child: InkWell(
                    onTap: () {
                      AutoRouter.of(context).push(
                        FarcasterUserProfileRoute(
                          profileName: users[index].profileName ?? '',
                        ),
                      );
                    },
                    child: FarcasterDiscoverUserItemWidget(
                      key: ValueKey(users[index].fid),
                      user: users[index],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
