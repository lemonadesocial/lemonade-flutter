import 'package:app/core/data/collaborator/dtos/user_discovery_swipe_dto/user_discovery_swipe_dto.dart';
import 'package:app/core/domain/collaborator/entities/user_discovery_swipe/user_discovery_swipe.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_likes_page/widgets/collborator_like_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/graphql/backend/collaborator/query/get_user_discovery_swipes.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

@RoutePage()
class CollaboratorLikesPage extends StatelessWidget {
  const CollaboratorLikesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final loggedInUserId = AuthUtils.getUserId(context);
    return Query$GetUserDiscoverySwipes$Widget(
      options: Options$Query$GetUserDiscoverySwipes(
        fetchPolicy: FetchPolicy.networkOnly,
        variables: Variables$Query$GetUserDiscoverySwipes(
          skip: 0,
          limit: 100,
          state: Enum$UserDiscoverySwipeState.pending,
        ),
      ),
      builder: (
        result, {
        refetch,
        fetchMore,
      }) {
        final pendingSwipes = (result.parsedData?.getUserDiscoverySwipes ?? [])
            .map((item) {
              return UserDiscoverySwipe.fromDto(
                UserDiscoverySwipeDto.fromJson(item.toJson()),
              );
            })
            .where((element) => element.user1 != loggedInUserId)
            .toList();

        if (result.isLoading || result.hasException) {
          return Scaffold(
            body: Center(
              child: result.isLoading
                  ? Loading.defaultLoading(context)
                  : EmptyList(
                      emptyText: t.common.somethingWrong,
                    ),
            ),
          );
        }

        if (pendingSwipes.isEmpty) {
          return Scaffold(
            appBar: LemonAppBar(title: t.collaborator.likes),
            body: Center(
              child: EmptyList(
                emptyText: t.collaborator.emptyLikes,
              ),
            ),
          );
        }

        return Scaffold(
          appBar: LemonAppBar(title: t.collaborator.likes),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
            child: CustomScrollView(
              slivers: [
                SliverList.separated(
                  itemCount: pendingSwipes.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        AutoRouter.of(context).push(
                          CollaboratorLikePreviewRoute(
                            swipe: pendingSwipes[index],
                            refetch: refetch,
                          ),
                        );
                      },
                      child: CollboratorLikeItem(
                        swipe: pendingSwipes[index],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(height: Spacing.xSmall),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
