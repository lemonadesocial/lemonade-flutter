import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/utils/avatar_utils.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class GuestDetailInformationView extends StatelessWidget {
  const GuestDetailInformationView({
    super.key,
    this.user,
  });

  final User? user;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        LemonCircleAvatar(
          size: Sizing.xLarge,
          url: AvatarUtils.getAvatarUrl(user: user),
        ),
        SizedBox(height: Spacing.small),
        if (user?.name != null)
          Text(
            user?.name ?? '',
            style: Typo.large.copyWith(
              fontWeight: FontWeight.w500,
              color: colorScheme.onPrimary,
            ),
          ),
        if (user?.email != null)
          Text(
            user?.email ?? '',
            style: Typo.medium.copyWith(
              fontWeight: FontWeight.w400,
              color: colorScheme.onSecondary,
            ),
          ),
      ],
    );
  }
}
