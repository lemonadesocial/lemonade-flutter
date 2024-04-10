import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JoinRequestUserAvatar extends StatelessWidget {
  final User? user;
  final Axis direction;
  final double? avatarSize;

  const JoinRequestUserAvatar({
    super.key,
    this.user,
    this.direction = Axis.horizontal,
    this.avatarSize,
  });

  double get _size => avatarSize ?? Sizing.medium;

  @override
  Widget build(BuildContext context) {
    return direction == Axis.horizontal
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _avatar(),
              SizedBox(width: Spacing.xSmall),
              _Name(user: user),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _avatar(),
              SizedBox(height: Spacing.small),
              _Name(user: user),
            ],
          );
  }

  Widget _avatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Sizing.medium),
      child: CachedNetworkImage(
        width: _size,
        height: _size,
        imageUrl: user?.imageAvatar ?? '',
        placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
        errorWidget: (_, __, ___) => ImagePlaceholder.defaultPlaceholder(),
      ),
    );
  }
}

class _Name extends StatelessWidget {
  const _Name({
    required this.user,
  });
  final User? user;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: Sizing.xLarge * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user?.displayName ?? user?.email ?? t.common.anonymous,
            style: Typo.medium.copyWith(
              color: colorScheme.onPrimary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2.w),
          Text(
            user?.username != null ? '@${user?.username}' : user?.email ?? '',
            style: Typo.small.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
