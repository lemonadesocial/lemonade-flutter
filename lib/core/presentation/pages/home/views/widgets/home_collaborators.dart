import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/data/collaborator/dtos/user_discovery_swipe_dto/user_discovery_swipe_dto.dart';
import 'package:app/core/domain/collaborator/entities/user_discovery_swipe/user_discovery_swipe.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_chat_page/widgets/horizontal_collaborator_likes_list.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/collaborator/query/get_user_discovery_swipes.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:app/app_theme/app_theme.dart';

class HomeCollaborators extends StatelessWidget {
  const HomeCollaborators({super.key});

  @override
  Widget build(BuildContext context) {
    final loggedInUserId = context
        .watch<AuthBloc>()
        .state
        .maybeWhen(orElse: () => '', authenticated: (user) => user.userId);
    if (loggedInUserId.isEmpty) {
      return const _EmptyCollaboratorLikes(
        isLoggedIn: false,
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
          return const _EmptyCollaboratorLikes(
            isLoggedIn: true,
          );
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
  const _EmptyCollaboratorLikes({
    required this.isLoggedIn,
  });

  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appText = context.theme.appTextTheme;
    final appColors = context.theme.appColors;
    final user = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession,
          orElse: () => null,
        );

    return Container(
      height: 235.w,
      decoration: BoxDecoration(
        color: appColors.cardBg,
        border: Border.all(color: appColors.cardBorder),
        borderRadius: BorderRadius.circular(LemonRadius.md),
      ),
      padding: EdgeInsets.only(
        bottom: Spacing.s5,
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: Spacing.s1_5),
            child: Assets.images.homeCollaborators.image(),
          ),
          Positioned(
            top: Spacing.s3,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LemonNetworkImage(
                  borderRadius: BorderRadius.circular(LemonRadius.full),
                  width: 60.w,
                  height: 60.w,
                  imageUrl: user?.imageAvatar ?? '',
                  placeholder: ImagePlaceholder.avatarPlaceholder(
                    radius: BorderRadius.circular(LemonRadius.full),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: Spacing.s24),
                Text(
                  t.collaborator.swipeAndMAtch,
                  style: appText.lg,
                ),
                SizedBox(height: Spacing.s1_5),
                Text(
                  t.collaborator.swipeAndMAtchDescription,
                  style: appText.sm.copyWith(
                    color: appColors.textSecondary,
                  ),
                ),
                SizedBox(height: Spacing.s5),
                SizedBox(
                  width: 91.w,
                  child: LinearGradientButton.secondaryButton(
                    onTap: () {
                      AutoRouter.of(context).push(CollaboratorRoute());
                    },
                    height: Sizing.s9,
                    label: t.collaborator.letsGo,
                    radius: BorderRadius.circular(LemonRadius.full),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
