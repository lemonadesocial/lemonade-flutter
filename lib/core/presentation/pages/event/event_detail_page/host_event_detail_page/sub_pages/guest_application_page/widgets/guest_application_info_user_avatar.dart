import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestApplicationInfoUserAvatar extends StatelessWidget {
  final User? userInfo;
  final Axis direction;
  final double? avatarSize;

  const GuestApplicationInfoUserAvatar({
    super.key,
    required this.userInfo,
    this.direction = Axis.horizontal,
    this.avatarSize,
  });

  double get _size => avatarSize ?? Sizing.medium;

  String get _name =>
      userInfo?.displayName ??
      userInfo?.username ??
      userInfo?.name ??
      userInfo?.email ??
      '';

  String get _email => userInfo?.email ?? '';

  String get _imageUrl => userInfo?.imageAvatar ?? '';

  @override
  Widget build(BuildContext context) {
    return direction == Axis.horizontal
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _Avatar(
                size: _size,
                imageUrl: _imageUrl,
              ),
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
              _Avatar(
                size: _size,
                imageUrl: _imageUrl,
              ),
              SizedBox(height: Spacing.small),
              _Name(
                name: _name,
                email: _email,
              ),
            ],
          );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    required double size,
    required String imageUrl,
  })  : _size = size,
        _imageUrl = imageUrl;

  final double _size;
  final String _imageUrl;

  @override
  Widget build(BuildContext context) {
    return LemonNetworkImage(
      borderRadius: BorderRadius.circular(Sizing.medium),
      width: _size,
      height: _size,
      imageUrl: _imageUrl,
      placeholder: ImagePlaceholder.avatarPlaceholder(),
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
