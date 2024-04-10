import 'package:app/core/domain/community/community_user/community_user.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class CommunityUserTile extends StatelessWidget {
  const CommunityUserTile({
    super.key,
    required this.user,
  });

  final CommunityUser user;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => context.router.push(ProfileRoute(userId: user.id)),
      child: Container(
        padding: EdgeInsets.all(Spacing.small),
        decoration: BoxDecoration(
          color: LemonColor.atomicBlack,
          borderRadius: BorderRadius.circular(LemonRadius.small),
        ),
        child: Row(
          children: [
            LemonCircleAvatar(url: user.imageAvatar ?? ''),
            SizedBox(width: Spacing.xSmall),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.displayName ?? user.userName ?? '',
                    style: Typo.medium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  Text(
                    user.userName ?? '',
                    style: Typo.small.copyWith(
                      fontWeight: FontWeight.w400,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
