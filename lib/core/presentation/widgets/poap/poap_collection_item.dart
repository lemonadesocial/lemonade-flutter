import 'package:app/core/domain/badge/entities/badge_entities.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PoapCollectionItem extends StatelessWidget {
  const PoapCollectionItem({
    super.key,
    required this.badgeCollection,
    this.onTap,
    this.selected = false,
    this.visible = true,
  });

  final BadgeList badgeCollection;
  final void Function(BadgeList collection)? onTap;
  final bool selected;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (!visible) return SizedBox(width: 70.w);

    return InkWell(
      onTap: () {
        onTap?.call(badgeCollection);
      },
      child: SizedBox(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: selected ? LemonColor.lavender : colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(Sizing.regular * 2),
              ),
              child: LemonCircleAvatar(
                url: badgeCollection.imageUrl ?? '',
                size: Sizing.regular * 2,
              ),
            ),
            SizedBox(height: Spacing.superExtraSmall),
            Text(
              badgeCollection.title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Typo.xSmall,
            ),
          ],
        ),
      ),
    );
  }
}
