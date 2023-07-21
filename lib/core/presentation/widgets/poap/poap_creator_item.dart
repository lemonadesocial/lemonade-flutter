import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class PoapCreatorItem extends StatelessWidget {
  const PoapCreatorItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 78,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  border: Border.all(color: colorScheme.outline), borderRadius: BorderRadius.circular(70)),
              child: LemonCircleAvatar(
                url:
                    "https://static.vecteezy.com/system/resources/thumbnails/013/003/046/small_2x/burger-cartoon-illustration-suitable-for-sticker-symbol-logo-icon-clipart-etc-free-vector.jpg",
                size: 70,
              ),
            ),
            SizedBox(height: Spacing.superExtraSmall),
            Text(
              "Burger Nation",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Typo.xSmall,
            )
          ],
        ),
      ),
    );
  }
}
