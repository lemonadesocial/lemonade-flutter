import 'package:app/core/config.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/common/badge/username_badge_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ProfilePageHeader extends StatelessWidget {
  final User user;
  const ProfilePageHeader({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _ProfileAvatar(user: user),
              SizedBox(width: Spacing.small),
              _ProfileUserNameAndTitle(user: user),
            ],
          ),
          SizedBox(height: Spacing.smMedium),
          _ProfileUserFollow(user: user),
          SizedBox(height: Spacing.smMedium),
          _ActionButtons(user: user),
          SizedBox(height: Spacing.smMedium),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final User user;
  
  _ActionButtons({required this.user});

  _shareProfileLink(context, {required User user}) async {
    try {
      final box = context.findRenderObject() as RenderBox?;
      await Share.share(
        '${AppConfig.webUrl}/${user.username}',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: LinearGradientButton(
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
}

class _ProfileAvatar extends StatelessWidget {
  final User user;
  _ProfileAvatar({required this.user});

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
        if (user.tagline?.isNotEmpty == true)...[
          Text('${user.tagline}', style: Typo.medium.copyWith(color: LemonColor.lavender, fontWeight: FontWeight.w400)),
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
  _ProfileUserNameAndTitle({
    required this.user,
  });

  String? get displayName {
    return user.displayName ?? user.username ?? null;
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(displayName ?? t.common.anonymous, style: Typo.large),
            SizedBox(width: Spacing.extraSmall),
            TextBadge(label: '@${user.username}'),
          ],
        ),
        Text(
          user.jobTitle ?? user.tagline ?? '...',
          style: Typo.medium.copyWith(color: colorScheme.onSecondary),
          maxLines: 2,
        )
      ],
    );
  }
}
