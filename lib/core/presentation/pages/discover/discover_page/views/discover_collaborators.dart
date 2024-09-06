import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/data/collaborator/dtos/user_discovery_swipe_dto/user_discovery_swipe_dto.dart';
import 'package:app/core/domain/collaborator/entities/user_discovery_swipe/user_discovery_swipe.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_chat_page/widgets/horizontal_collaborator_likes_list.dart';
import 'package:app/graphql/backend/collaborator/query/get_user_discovery_swipes.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DiscoverCollaborators extends StatelessWidget {
  const DiscoverCollaborators({super.key});

  @override
  Widget build(BuildContext context) {
    final loggedInUserId = context
        .watch<AuthBloc>()
        .state
        .maybeWhen(orElse: () => '', authenticated: (user) => user.userId);
    if (loggedInUserId.isEmpty) {
      return const SliverToBoxAdapter(
        child: SizedBox.shrink(),
      );
    }
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
        if (pendingSwipes.isEmpty) {
          return const SliverToBoxAdapter(
            child: SizedBox.shrink(),
          );
        }
        return SliverToBoxAdapter(
          child: HorizontalCollaboratorLikesList(
            headerVisible: false,
            pendingSwipes: pendingSwipes,
            refetch: refetch,
          ),
        );
      },
    );
  }
}
