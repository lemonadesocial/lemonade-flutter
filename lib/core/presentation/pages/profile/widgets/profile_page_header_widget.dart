import 'package:app/core/application/profile/user_follows_bloc/user_follows_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/common/badge/username_badge_widget.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:share_plus/share_plus.dart';
import 'package:app/app_theme/app_theme.dart';

class ProfilePageHeader extends StatelessWidget {
  final User user;

  const ProfilePageHeader({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    return Container(
      color: appColors.pageBg,
      padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ProfileAvatar(user: user),
              SizedBox(width: Spacing.small),
              _ProfileUserNameAndTitle(user: user),
            ],
          ),
          SizedBox(height: 21.h),
          _ProfileUserFollow(user: user),
          SizedBox(height: 21.h),
          _ActionButtons(user: user),
          SizedBox(height: Spacing.xSmall),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final User user;

  const _ActionButtons({required this.user});

  _shareProfileLink(context, {required User user}) async {
    try {
      final box = context.findRenderObject() as RenderBox?;
      await Share.share(
        '${AppConfig.webUrl}/${user.username}',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error _shareProfileLink $e");
      }
    }
  }

  _buildMyActionsButton(BuildContext context) {
    final t = Translations.of(context);
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: LinearGradientButton(
            onTap: () => context.router.push(const EditProfileRoute()),
            label: t.common.actions.editProfile,
          ),
        ),
        SizedBox(width: Spacing.superExtraSmall),
        Expanded(
          child: LinearGradientButton(
            onTap: () => _shareProfileLink(context, user: user),
            label: t.common.actions.shareProfile,
          ),
        ),
        SizedBox(width: Spacing.superExtraSmall),
      ],
    );
  }

  _buildOtherActionsButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return BlocBuilder<UserFollowsBloc, UserFollowsState>(
      builder: (context, state) {
        return state.maybeWhen(
          fetched: (userFollows) {
            // If already follow this user
            if (userFollows.isNotEmpty) {
              return (LemonOutlineButton(
                onTap: () {
                  Vibrate.feedback(FeedbackType.light);
                  context.read<UserFollowsBloc>().add(
                        UserFollowsEvent.unfollow(followee: user.userId),
                      );
                },
                label: t.common.followed,
                leading: ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (filter) =>
                      Assets.icons.icDone.svg(colorFilter: filter),
                ),
              ));
            }
            return LinearGradientButton(
              onTap: () {
                Vibrate.feedback(FeedbackType.light);
                context.read<UserFollowsBloc>().add(
                      UserFollowsEvent.follow(followee: user.userId),
                    );
              },
              label: t.common.actions.follow,
              mode: GradientButtonMode.lavenderMode,
            );
          },
          loading: () => SizedBox(
            height: 48.h,
            child: Center(
              child: Loading.defaultLoading(context),
            ),
          ),
          orElse: () => SizedBox(
            height: 48.h,
            child: Center(
              child: Text(t.common.somethingWrong),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMe = AuthUtils.isMe(context, user: user);
    return isMe
        ? _buildMyActionsButton(context)
        : _buildOtherActionsButton(
            context,
          );
  }
}

class _ProfileAvatar extends StatelessWidget {
  final User user;

  const _ProfileAvatar({required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        LemonCircleAvatar(
          url: user.imageAvatar ?? '',
          size: 72,
        ),
      ],
    );
  }
}

class _ProfileUserFollow extends StatelessWidget {
  final User user;

  const _ProfileUserFollow({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (user.tagline?.isNotEmpty == true) ...[
          Text(
            '${user.tagline}',
            style: Typo.medium.copyWith(
              color: LemonColor.white72,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: Spacing.superExtraSmall),
        ],
        Row(
          children: [
            Text(
              '${NumberUtils.formatCompact(amount: user.followers)} ${StringUtils.capitalize(t.common.follower(n: user.followers ?? 0))}',
              style: Typo.medium.copyWith(color: colorScheme.onSurfaceVariant),
            ),
            Text(
              '  •  ${NumberUtils.formatCompact(amount: user.following)} ${StringUtils.capitalize(t.common.following)}',
              style: Typo.medium.copyWith(color: colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProfileUserNameAndTitle extends StatelessWidget {
  final User user;

  const _ProfileUserNameAndTitle({
    required this.user,
  });

  String? get displayName {
    return user.displayName ?? user.username;
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (user.username?.isNotEmpty == true)
                TextBadge(label: '@${user.username}'),
            ],
          ),
          Text(
            displayName ?? t.common.anonymous,
            style: Typo.extraMedium,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          Text(
            user.jobTitle ?? user.tagline ?? '...',
            style: Typo.medium.copyWith(color: colorScheme.onSecondary),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
