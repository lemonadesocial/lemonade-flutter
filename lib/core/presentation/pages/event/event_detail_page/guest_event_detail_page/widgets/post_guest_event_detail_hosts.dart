import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/profile/user_follows_bloc/user_follows_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/core/utils/matrix_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
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

class PostGuestEventDetailHosts extends StatelessWidget {
  const PostGuestEventDetailHosts({
    super.key,
    required this.event,
  });

  final Event event;

  List<User?> get hosts {
    final coHosts = event.cohostsExpanded ?? [];
    return [event.hostExpanded, ...coHosts]
        .where((item) => item != null)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final userId = context.read<AuthBloc>().state.maybeWhen(
          orElse: () => '',
          authenticated: (session) => session.userId,
        );
    final isAttending = EventUtils.isAttending(event: event, userId: userId);

    if (hosts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
          child: Text(
            StringUtils.capitalize(t.common.host(n: 2)),
            style: Typo.extraMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onPrimary,
            ),
          ),
        ),
        SizedBox(
          height: Spacing.xSmall,
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
          shrinkWrap: true,
          separatorBuilder: (context, index) => SizedBox(
            height: Spacing.xSmall,
          ),
          itemCount: hosts.length,
          itemBuilder: (context, index) {
            final host = hosts[index];
            return _EventHostItem(
              host: host,
              colorScheme: colorScheme,
              isAttending: isAttending,
            );
          },
        ),
      ],
    );
  }
}

class _EventHostItem extends StatelessWidget {
  const _EventHostItem({
    required this.host,
    required this.colorScheme,
    this.isAttending = false,
  });

  final User? host;
  final ColorScheme colorScheme;
  final bool isAttending;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserFollowsBloc(
        getIt<UserRepository>(),
      )..add(
          UserFollowsEvent.fetch(followee: host?.userId ?? ''),
        ),
      child: InkWell(
        onTap: () {
          AutoRouter.of(context)
              .navigate(ProfileRoute(userId: host?.userId ?? ''));
        },
        child: Container(
          padding: EdgeInsets.all(Spacing.small),
          decoration: BoxDecoration(
            color: LemonColor.atomicBlack,
            borderRadius: BorderRadius.circular(LemonRadius.medium),
            border: Border.all(
              color: colorScheme.outline,
              width: 0.5.w,
            ),
          ),
          child: Row(
            children: [
              LemonNetworkImage(
                width: Sizing.medium,
                height: Sizing.medium,
                borderRadius: BorderRadius.circular(Sizing.medium),
                border: Border.all(
                  color: colorScheme.outline,
                  width: 0.5.w,
                ),
                fit: BoxFit.cover,
                placeholder: ImagePlaceholder.avatarPlaceholder(),
                imageUrl: ImageUtils.generateUrl(
                  file: host?.newPhotosExpanded?.isNotEmpty == true
                      ? host?.newPhotosExpanded?.firstOrNull
                      : null,
                  imageConfig: ImageConfig.eventPhoto,
                ),
              ),
              SizedBox(width: Spacing.small),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      host?.displayName ?? host?.name ?? '',
                      style: Typo.medium.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3.w),
                    if (host?.username?.isNotEmpty == true)
                      Text(
                        '@${host?.username}',
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              if (isAttending) ...[
                SizedBox(height: Spacing.xSmall),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _FollowButton(host: host),
                    SizedBox(width: Spacing.superExtraSmall),
                    InkWell(
                      onTap: () async {
                        final response = await showFutureLoadingDialog(
                          context: context,
                          future: () async {
                            return getIt<MatrixService>()
                                .client
                                .startDirectChat(
                                  LemonadeMatrixUtils.generateMatrixUserId(
                                    lemonadeMatrixLocalpart:
                                        host?.matrixLocalpart ?? '',
                                  ),
                                );
                          },
                        );
                        if (response.result?.isNotEmpty == true) {
                          AutoRouter.of(context).push(
                            ChatRoute(
                              roomId: response.result!,
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: Sizing.medium,
                        height: Sizing.medium,
                        padding: EdgeInsets.symmetric(
                          horizontal: Spacing.superExtraSmall,
                        ),
                        decoration: BoxDecoration(
                          color: LemonColor.chineseBlack,
                          borderRadius: BorderRadius.circular(
                            Sizing.medium,
                          ),
                          border: Border.all(
                            color: colorScheme.outline,
                            width: 0.5.w,
                          ),
                        ),
                        child: Center(
                          child: ThemeSvgIcon(
                            color: colorScheme.onSecondary,
                            builder: (filter) => Assets.icons.icChatBubble.svg(
                              colorFilter: filter,
                              width: Sizing.xSmall,
                              height: Sizing.xSmall,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _FollowButton extends StatelessWidget {
  final User? host;
  const _FollowButton({
    this.host,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: Sizing.medium,
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.xSmall,
      ),
      decoration: BoxDecoration(
        color: LemonColor.chineseBlack,
        borderRadius: BorderRadius.circular(
          LemonRadius.normal,
        ),
        border: Border.all(
          color: colorScheme.outline,
          width: 0.5.w,
        ),
      ),
      child: BlocBuilder<UserFollowsBloc, UserFollowsState>(
        builder: (context, state) {
          final following = state.maybeWhen(
            orElse: () => false,
            fetched: (userFollows) => userFollows.isNotEmpty,
          );
          final isLoading = state.maybeWhen(
            orElse: () => false,
            loading: () => true,
          );

          return InkWell(
            onTap: () {
              if (isLoading) {
                return;
              }
              if (following) {
                context.read<UserFollowsBloc>().add(
                      UserFollowsEvent.unfollow(followee: host?.userId ?? ''),
                    );
              } else {
                context.read<UserFollowsBloc>().add(
                      UserFollowsEvent.follow(followee: host?.userId ?? ''),
                    );
              }
            },
            child: Center(
              child: isLoading
                  ? Loading.defaultLoading(context)
                  : Text(
                      following ? t.common.followed : t.common.actions.follow,
                      style: Typo.small.copyWith(
                        color: colorScheme.onSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
