import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/widgets/collaborator_icebreakers_bottomsheet/collaborator_icebreakers_bottomsheet.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CollaboratorDiscoverIcebreakersSection extends StatelessWidget {
  final User? user;
  const CollaboratorDiscoverIcebreakersSection({
    super.key,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final icebreakersCount = user?.icebreakers?.length ?? 0;
    final firstIcebreaker = user?.icebreakers?.firstOrNull;

    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(Spacing.smMedium),
        decoration: ShapeDecoration(
          color: appColors.cardBg,
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
                    t.collaborator.iceBreakers,
                    style: appText.md,
                  ),
                ),
                if (icebreakersCount > 1)
                  InkWell(
                    onTap: () {
                      showCupertinoModalBottomSheet(
                        context: context,
                        backgroundColor: colorScheme.secondaryContainer,
                        topRadius: Radius.circular(30.r),
                        builder: (mContext) {
                          return CollaboratorIceBreakersBottomSheet(
                            icebreakers: user?.icebreakers ?? [],
                          );
                        },
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 9.r, vertical: 3.r),
                      decoration: ShapeDecoration(
                        color: colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(LemonRadius.medium),
                        ),
                      ),
                      child: Text(
                        t.common.more(count: icebreakersCount - 1),
                        style: appText.sm.copyWith(
                          color: appColors.textTertiary,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: Spacing.smMedium),
            Text(
              firstIcebreaker?.questionExpanded?.title ?? '',
              style: appText.md.copyWith(
                color: appColors.textTertiary,
              ),
            ),
            SizedBox(height: Spacing.smMedium / 2),
            Text(
              firstIcebreaker?.value ?? '',
              style: appText.md.copyWith(
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.clashDisplay,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
