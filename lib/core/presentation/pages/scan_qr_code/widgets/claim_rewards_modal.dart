import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class ClaimRewardsModal extends StatelessWidget {
  final Function onClose;

  const ClaimRewardsModal({Key? key, required this.onClose}) : super(key: key);

  void onTapClose() {
    Vibrate.feedback(FeedbackType.light);
    onClose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Container(
        width: 1.sw,
        height: 1.sh,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: LemonColor.atomicBlack,
          border: Border.all(
            color: LemonColor.white06,
          ),
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.only(top: 50.h),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, sectionIndex) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text('Section $sectionIndex'),
                          ),
                          const HorizontalListWidget(),
                        ],
                      );
                    },
                    childCount: 5,
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                clipBehavior: Clip.hardEdge,
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.medium,
                  vertical: Spacing.small,
                ),
                decoration: BoxDecoration(
                  color: LemonColor.atomicBlack,
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      t.event.rewards,
                      style: Typo.large.copyWith(
                        color: colorScheme.onPrimary,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w800,
                        fontFamily: FontFamily.nohemiVariable,
                      ),
                    ),
                    GestureDetector(
                      onTap: onTapClose,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 9.h,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: colorScheme.outline),
                        ),
                        child: ThemeSvgIcon(
                          color: Theme.of(context).colorScheme.onSurface,
                          builder: (filter) => Assets.icons.icClose.svg(
                            colorFilter: filter,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HorizontalListWidget extends StatelessWidget {
  const HorizontalListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // Adjust the height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Replace with your actual number of items
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: SizedBox(
              width: 80,
              child: Center(
                child: Text('Item $index'),
              ),
            ),
          );
        },
      ),
    );
  }
}
