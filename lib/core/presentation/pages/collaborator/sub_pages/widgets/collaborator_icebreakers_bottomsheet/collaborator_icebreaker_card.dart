import 'package:app/core/domain/user/entities/user_icebreaker.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollaboratorIceBreakerCard extends StatelessWidget {
  final UserIcebreaker icebreaker;
  const CollaboratorIceBreakerCard({
    super.key,
    required this.icebreaker,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.smMedium),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: LemonColor.white06,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LemonRadius.normal),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ThemeSvgIcon(
                builder: (colorFilter) => Assets.icons.icQuote.svg(
                  width: 18.w,
                  height: 18.w,
                ),
              ),
              SizedBox(width: Spacing.smMedium / 2),
              Expanded(
                child: Text(
                  icebreaker.questionExpanded?.title ?? '',
                  style: Typo.medium.copyWith(
                    color: colorScheme.onSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Spacing.smMedium / 2),
          Text(
            icebreaker.value ?? '',
            style: Typo.mediumPlus.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
