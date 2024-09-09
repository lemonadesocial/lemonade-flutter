import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/data/collaborator/dtos/user_discovery_swipe_dto/user_discovery_swipe_dto.dart';
import 'package:app/core/domain/collaborator/entities/user_discovery_swipe/user_discovery_swipe.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_chat_page/widgets/horizontal_collaborator_likes_list.dart';
import 'package:app/core/presentation/pages/home/views/collaborator_circle_widget.dart';
import 'package:app/graphql/backend/collaborator/query/get_user_discovery_swipes.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeCollaborators extends StatelessWidget {
  const HomeCollaborators({super.key});

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
          return const _EmptyCollaboratorLikes();
        }
        return HorizontalCollaboratorLikesList(
          headerVisible: false,
          pendingSwipes: pendingSwipes,
          refetch: refetch,
        );
      },
    );
  }
}

class _EmptyCollaboratorLikes extends StatelessWidget {
  const _EmptyCollaboratorLikes();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Spacing.small),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CollaboratorCircleWidget(),
          SizedBox(width: Spacing.xSmall),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.collaborator.noMatchesYet,
                style: Typo.small.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                  height: 0,
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 2.w),
              Text(
                t.collaborator.noMatchesYetDescription,
                style: Typo.small.copyWith(
                  color: colorScheme.onSecondary,
                  height: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
