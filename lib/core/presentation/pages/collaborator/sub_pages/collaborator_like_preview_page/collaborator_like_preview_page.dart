import 'package:app/core/application/collaborator/get_user_discovery_matched_swipes_bloc/get_user_discovery_matched_swipes_bloc.dart';
import 'package:app/core/application/profile/user_profile_bloc/user_profile_bloc.dart';
import 'package:app/core/domain/collaborator/collaborator_repository.dart';
import 'package:app/core/domain/collaborator/entities/user_discovery_swipe/user_discovery_swipe.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/pages/collaborator/collaborator_discover/widgets/collaborator_discover_view.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_icon_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/core/utils/matrix_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/collaborator/mutation/accept_user_discovery.graphql.dart';
import 'package:app/graphql/backend/collaborator/mutation/decline_user_discovery.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class CollaboratorLikePreviewPage extends StatelessWidget {
  final UserDiscoverySwipe swipe;
  final Function()? refetch;
  const CollaboratorLikePreviewPage({
    super.key,
    required this.swipe,
    this.refetch,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProfileBloc(
        getIt<UserRepository>(),
      )..add(
          UserProfileEvent.fetch(
            userId: swipe.other,
          ),
        ),
      child: _CollaboratorLikePreviewView(
        swipe: swipe,
        refetch: refetch,
      ),
    );
  }
}

class _CollaboratorLikePreviewView extends StatelessWidget {
  final UserDiscoverySwipe swipe;
  final Function()? refetch;
  const _CollaboratorLikePreviewView({
    required this.swipe,
    this.refetch,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: const LemonAppBar(
        actions: [
          // TODO: not supported yet
          // Padding(
          //   padding: EdgeInsets.only(right: Spacing.xSmall),
          //   child: InkWell(
          //     child: ThemeSvgIcon(
          //       color: colorScheme.onPrimary,
          //       builder: (filter) => Assets.icons.icMoreHoriz.svg(
          //         colorFilter: filter,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileStateLoading) {
            return Center(
              child: Loading.defaultLoading(context),
            );
          }
          final userProfile = state.maybeWhen(
            orElse: () => null,
            fetched: (user) => user,
          );
          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                    sliver: SliverToBoxAdapter(
                      child: _MessagesPreview(
                        message: swipe.message,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: Spacing.large),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                    sliver: CollaboratorDiscoverView(
                      user: userProfile,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: Spacing.xLarge * 3),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Spacing.smMedium,
                      horizontal: Spacing.xSmall,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: Sizing.xLarge,
                          height: Sizing.xLarge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Sizing.xLarge),
                            color: colorScheme.background,
                          ),
                          child: LinearGradientIconButton(
                            onTap: () async {
                              await showFutureLoadingDialog(
                                context: context,
                                future: () => getIt<CollaboratorRepository>()
                                    .declineUserDiscovery(
                                  input:
                                      Variables$Mutation$DeclineUserDiscovery(
                                    swipee: swipe.other ?? '',
                                  ),
                                ),
                              );
                              refetch?.call();
                              AutoRouter.of(context).pop();
                            },
                            width: Sizing.xLarge,
                            height: Sizing.xLarge,
                            radius: BorderRadius.circular(Sizing.xLarge),
                            icon: Assets.icons.icClose.svg(),
                          ),
                        ),
                        LinearGradientIconButton(
                          onTap: () async {
                            await showFutureLoadingDialog(
                              context: context,
                              future: () async {
                                final result =
                                    await getIt<CollaboratorRepository>()
                                        .acceptUserDiscovery(
                                  input: Variables$Mutation$AcceptUserDiscovery(
                                    swipee: swipe.other ?? '',
                                  ),
                                );
                                if (result.isLeft()) {
                                  return;
                                }
                                context
                                    .read<GetUserDiscoveryMatchedSwipesBloc>()
                                    .add(
                                      GetUserDiscoveryMatchedSwipesEvent
                                          .fetch(),
                                    );
                                refetch?.call();
                                final roomId = await getIt<MatrixService>()
                                    .client
                                    .startDirectChat(
                                      LemonadeMatrixUtils.generateMatrixUserId(
                                        lemonadeMatrixLocalpart:
                                            userProfile?.matrixLocalpart ?? '',
                                      ),
                                    );
                                AutoRouter.of(context).replace(
                                  ChatRoute(
                                    roomId: roomId,
                                  ),
                                );
                              },
                            );
                          },
                          width: Sizing.xLarge,
                          height: Sizing.xLarge,
                          radius: BorderRadius.circular(Sizing.xLarge),
                          icon: Assets.icons.icChatBubble.svg(),
                          mode: GradientButtonMode.lavenderMode,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MessagesPreview extends StatelessWidget {
  final String? message;
  const _MessagesPreview({
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(Spacing.xSmall),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(LemonRadius.small),
            color: LemonColor.atomicBlack,
          ),
          child: Text(
            t.collaborator.likedYourProfile,
            style: Typo.medium.copyWith(
              color: colorScheme.onSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        // TODO: clarify with Designer
        // SizedBox(height: 2.w),
        // Container(
        //   padding: EdgeInsets.all(Spacing.xSmall),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(LemonRadius.small),
        //     color: LemonColor.atomicBlack,
        //   ),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //         t.collaborator.needHelpWith,
        //         style: Typo.medium.copyWith(
        //           color: colorScheme.onSecondary,
        //         ),
        //       ),
        //       Text(
        //         'Design advice, Financial advice',
        //         style: Typo.medium.copyWith(
        //           color: colorScheme.onPrimary,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        if (message?.isNotEmpty == true) ...[
          SizedBox(height: 2.w),
          Container(
            padding: EdgeInsets.all(Spacing.xSmall),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.small),
              color: colorScheme.surface,
            ),
            child: Text(
              message!,
              style: Typo.medium.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
