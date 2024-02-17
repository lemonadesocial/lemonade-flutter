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
  const JoinRequestUserAvatar({
    super.key,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Sizing.medium),
          child: CachedNetworkImage(
            width: Sizing.medium,
            height: Sizing.medium,
            imageUrl: user?.imageAvatar ?? '',
            placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
            errorWidget: (_, __, ___) => ImagePlaceholder.defaultPlaceholder(),
          ),
        ),
        SizedBox(width: Spacing.xSmall),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user?.displayName ?? t.common.anonymous,
              style: Typo.medium.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
            SizedBox(height: 2.w),
            Text(
              '@${user?.username ?? t.common.anonymous}',
              style: Typo.small.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
