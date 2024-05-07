import 'package:app/core/application/collaborator/get_user_discovery_matched_swipes_bloc/get_user_discovery_matched_swipes_bloc.dart';
import 'package:app/core/data/collaborator/dtos/user_discovery_swipe_dto/user_discovery_swipe_dto.dart';
import 'package:app/core/domain/collaborator/entities/user_discovery_swipe/user_discovery_swipe.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_chat_page/widgets/collaborator_chat_list.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_chat_page/widgets/horizontal_collaborator_likes_list.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/graphql/backend/collaborator/query/get_user_discovery_swipes.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

@RoutePage()
class CollaboratorChatPage extends StatelessWidget {
  const CollaboratorChatPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const _CollaboratorChatPageView();
  }
}

class _CollaboratorChatPageView extends StatelessWidget {
  const _CollaboratorChatPageView();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final loggedInUserId = AuthUtils.getUserId(context);
    return Scaffold(
      appBar: LemonAppBar(
        title: t.collaborator.chat,
      ),
      body: CustomScrollView(
        slivers: [
          Query$GetUserDiscoverySwipes$Widget(
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
              final pendingSwipes =
                  (result.parsedData?.getUserDiscoverySwipes ?? [])
                      .map((item) {
                        return UserDiscoverySwipe.fromDto(
                          UserDiscoverySwipeDto.fromJson(item.toJson()),
                        );
                      })
                      .where((element) => element.user1 != loggedInUserId)
                      .toList();
              if (pendingSwipes.isEmpty) {
                return const SliverToBoxAdapter(
                  child: SizedBox.shrink(),
                );
              }
              return SliverPadding(
                padding: EdgeInsets.only(bottom: Spacing.large),
                sliver: SliverToBoxAdapter(
                  child: HorizontalCollaboratorLikesList(
                    pendingSwipes: pendingSwipes,
                    refetch: refetch,
                  ),
                ),
              );
            },
          ),
          BlocBuilder<GetUserDiscoveryMatchedSwipesBloc,
              GetUserDiscoveryMatchedSwipesState>(
            builder: (context, state) {
              List<UserDiscoverySwipe> matchedSwipes = state.maybeWhen(
                orElse: () => [],
                fetched: (matchedSwipes) => matchedSwipes,
              );

              return CollaboratorChatList(
                matchedSwipes: matchedSwipes,
              );
            },
          ),
        ],
      ),
    );
  }
}
