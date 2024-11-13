import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VotingOptionCard extends StatelessWidget {
  final User user;
  final bool isLeft;
  final bool isWinner;
  const VotingOptionCard({
    super.key,
    required this.user,
    this.isLeft = true,
    this.isWinner = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Container(
      padding: EdgeInsets.only(
        bottom: 4.w,
      ),
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(LemonRadius.medium),
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: LemonColor.chineseBlack,
          borderRadius: BorderRadius.circular(LemonRadius.medium),
          border: Border.all(
            color: colorScheme.outlineVariant,
            width: 1.w,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.extraSmall,
                vertical: Spacing.superExtraSmall,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin:
                      isLeft ? const Alignment(-1, 0) : const Alignment(1, 0),
                  end: isLeft ? const Alignment(1, 0) : const Alignment(-1, 0),
                  colors: [colorScheme.outline, Colors.white.withOpacity(0)],
                ),
              ),
              child: Text(
                isLeft
                    ? t.event.eventVoting.forVoting
                    : t.event.eventVoting.againstVoting,
                textAlign: isLeft ? TextAlign.start : TextAlign.end,
                style: Typo.small.copyWith(
                  color: isLeft ? LemonColor.blueBerry : LemonColor.royalOrange,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: Spacing.xSmall,
                left: Spacing.small,
                right: Spacing.small,
                bottom: Spacing.small,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      LemonNetworkImage(
                        imageUrl: user.imageAvatar ?? '',
                        width: 96.w,
                        height: 96.w,
                        borderRadius: BorderRadius.circular(96.r),
                        border: Border.all(
                          color: colorScheme.onPrimary,
                          width: 2.w,
                        ),
                        placeholder: ImagePlaceholder.avatarPlaceholder(),
                      ),
                      if (isWinner) ...[
                        Positioned(
                          top: 0,
                          right: -5.w,
                          child: Assets.icons.icWinnerBadge.svg(
                            width: Sizing.medium,
                            height: Sizing.medium,
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: Spacing.smMedium),
                  Text(
                    user.name ?? user.displayName ?? '',
                    textAlign: TextAlign.center,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (user.jobTitle?.isNotEmpty == true) ...[
                    SizedBox(height: 2.w),
                    Text(
                      user.jobTitle ?? '',
                      textAlign: TextAlign.center,
                      style: Typo.small.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
