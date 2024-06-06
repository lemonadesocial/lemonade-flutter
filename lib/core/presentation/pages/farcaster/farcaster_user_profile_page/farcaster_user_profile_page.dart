import 'package:app/core/domain/farcaster/entities/airstack_farcaster_cast.dart';
import 'package:app/core/presentation/pages/farcaster/farcaster_user_profile_page/components/farcaster_profile_header.dart';
import 'package:app/core/presentation/pages/farcaster/farcaster_user_profile_page/components/farcaster_profile_tabbar_delegate.dart';
import 'package:app/core/presentation/pages/farcaster/farcaster_user_profile_page/components/user_farcaster_feeds/user_facaster_replies_newsfeed.dart';
import 'package:app/core/presentation/pages/farcaster/farcaster_user_profile_page/components/user_farcaster_feeds/user_farcaster_casts_newsfeed.dart';
import 'package:app/core/presentation/pages/farcaster/farcaster_user_profile_page/components/user_farcaster_feeds/user_farcaster_likes_newsfeed.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/common/sliver/dynamic_sliver_appbar.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/farcaster_airstack/query/get_farcaster_user_detail.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:web3modal_flutter/utils/debouncer.dart';

@RoutePage()
class FarcasterUserProfilePage extends StatefulWidget {
  final String profileName;
  const FarcasterUserProfilePage({
    super.key,
    required this.profileName,
  });

  @override
  State<FarcasterUserProfilePage> createState() =>
      _FarcasterUserProfilePageState();
}

class _FarcasterUserProfilePageState extends State<FarcasterUserProfilePage>
    with SingleTickerProviderStateMixin {
  final debouncer = Debouncer(milliseconds: 300);
  late ValueNotifier<GraphQLClient> airstackClient;
  final _refreshController = RefreshController();
  late final TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(
      length: 3,
      initialIndex: 0,
      vsync: this,
    );
    airstackClient = ValueNotifier(getIt<AirstackGQL>().client);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return GraphQLProvider(
      client: airstackClient,
      child: Query$GetFarcasterUserDetail$Widget(
        options: Options$Query$GetFarcasterUserDetail(
          fetchPolicy: FetchPolicy.cacheFirst,
          variables: Variables$Query$GetFarcasterUserDetail(
            profileName: widget.profileName,
          ),
        ),
        builder: (result, {refetch, fetchMore}) {
          return Scaffold(
            appBar: LemonAppBar(
              title: '@${widget.profileName}',
            ),
            body: Builder(
              builder: (context) {
                if (result.isLoading) {
                  return Center(
                    child: Loading.defaultLoading(context),
                  );
                }
                final rawData = result.parsedData?.Socials?.Social?.firstOrNull;
                final userDetail = rawData == null
                    ? null
                    : AirstackFarcasterUser.fromJson(rawData.toJson());
                if (userDetail == null) {
                  return Center(
                    child: EmptyList(
                      emptyText: t.common.somethingWrong,
                    ),
                  );
                }

                return NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context,
                      ),
                      sliver: MultiSliver(
                        children: [
                          DynamicSliverAppBar(
                            maxHeight: 250.h,
                            floating: true,
                            forceElevated: innerBoxIsScrolled,
                            child: FarcasterProfileHeader(
                              userDetail: userDetail,
                            ),
                          ),
                          SliverPersistentHeader(
                            pinned: true,
                            delegate: FarcasterProfileTabBarDelegate(
                              controller: _tabCtrl,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  body: TabBarView(
                    controller: _tabCtrl,
                    children: [
                      UserFarcasterCastsNewsfeed(
                        user: userDetail,
                      ),
                      UserFarcasterRepliesNewsfeed(
                        user: userDetail,
                      ),
                      UserFarcasterLikesNewsfeed(
                        user: userDetail,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
