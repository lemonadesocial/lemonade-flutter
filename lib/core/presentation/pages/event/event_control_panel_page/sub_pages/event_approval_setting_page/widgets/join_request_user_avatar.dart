import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JoinRequestUserAvatar extends StatelessWidget {
  final EventJoinRequest eventJoinRequest;
  final Axis direction;
  final double? avatarSize;

  const JoinRequestUserAvatar({
    super.key,
    required this.eventJoinRequest,
    this.direction = Axis.horizontal,
    this.avatarSize,
  });

  double get _size => avatarSize ?? Sizing.medium;

  bool get _isNonLoginUser => eventJoinRequest.user == null;

  String get _name => _isNonLoginUser
      ? eventJoinRequest.nonLoginUser?.displayName ?? ''
      : eventJoinRequest.userExpanded?.displayName ?? '';

  String get _email => _isNonLoginUser
      ? eventJoinRequest.nonLoginUser?.email ?? ''
      : eventJoinRequest.userExpanded?.email ?? '';

  String get _imageUrl => _isNonLoginUser
      ? eventJoinRequest.nonLoginUser?.imageAvatar ?? ''
      : eventJoinRequest.userExpanded?.imageAvatar ?? '';

  @override
  Widget build(BuildContext context) {
    return direction == Axis.horizontal
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _avatar(),
              SizedBox(width: Spacing.xSmall),
              _Name(
                name: _name,
                email: _email,
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _avatar(),
              SizedBox(height: Spacing.small),
              _Name(
                name: _name,
                email: _email,
              ),
            ],
          );
  }

  Widget _avatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Sizing.medium),
      child: CachedNetworkImage(
        width: _size,
        height: _size,
        imageUrl: _imageUrl,
        placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
        errorWidget: (_, __, ___) => ImagePlaceholder.defaultPlaceholder(),
      ),
    );
  }
}

class _Name extends StatelessWidget {
  const _Name({
    required this.name,
    required this.email,
  });
  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: Sizing.xLarge * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: Typo.medium.copyWith(
              color: colorScheme.onPrimary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2.w),
          Text(
            email,
            style: Typo.small.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
