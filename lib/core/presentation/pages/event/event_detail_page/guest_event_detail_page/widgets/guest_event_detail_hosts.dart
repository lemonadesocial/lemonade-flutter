import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/profile/user_follows_bloc/user_follows_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestEventDetailHosts extends StatelessWidget {
  const GuestEventDetailHosts({
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
            style: Typo.mediumPlus.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onPrimary,
            ),
          ),
        ),
        SizedBox(
          height: Spacing.xSmall,
        ),
        SizedBox(
          height: isAttending ? 178.w : 144.w,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(
              width: Spacing.extraSmall,
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
          width: 130.w,
          decoration: ShapeDecoration(
            color: colorScheme.onPrimary.withOpacity(0.06),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Spacing.small,
                    horizontal: Spacing.extraSmall,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60.w),
                          ),
                          width: 60.w,
                          height: 60.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60.r),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              placeholder: (_, __) =>
                                  ImagePlaceholder.defaultPlaceholder(),
                              errorWidget: (_, __, ___) =>
                                  ImagePlaceholder.defaultPlaceholder(),
                              imageUrl: ImageUtils.generateUrl(
                                file:
                                    host?.newPhotosExpanded?.isNotEmpty == true
                                        ? host?.newPhotosExpanded?.firstOrNull
                                        : null,
                                imageConfig: ImageConfig.eventPhoto,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Spacing.xSmall),
                        Text(
                          host?.displayName ?? host?.name ?? '',
                          style: Typo.small.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          host?.jobTitle ?? '',
                          style: Typo.small.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (isAttending) ...[
                          SizedBox(height: Spacing.xSmall),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _FollowButton(host: host),
                              SizedBox(width: Spacing.superExtraSmall),
                              InkWell(
                                onTap: () {
                                  AutoRouter.of(context)
                                      .navigate(const ChatListRoute());
                                },
                                child: Container(
                                  height: 30.w,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Spacing.superExtraSmall,
                                  ),
                                  decoration: ShapeDecoration(
                                    color:
                                        colorScheme.onPrimary.withOpacity(0.06),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        LemonRadius.xSmall,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: ThemeSvgIcon(
                                      color: colorScheme.onSecondary,
                                      builder: (filter) =>
                                          Assets.icons.icChatBubble.svg(
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
              ],
            ),
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
      height: 30.w,
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.xSmall,
      ),
      decoration: ShapeDecoration(
        color: colorScheme.onPrimary.withOpacity(0.06),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            LemonRadius.xSmall,
          ),
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
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
