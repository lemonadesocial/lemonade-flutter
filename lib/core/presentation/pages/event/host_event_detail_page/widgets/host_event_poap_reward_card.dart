import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HostEventPoapRewardCard extends StatelessWidget {
  const HostEventPoapRewardCard({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Container(
      width: double.infinity,
      height: 229.h,
      padding: EdgeInsets.symmetric(horizontal: Spacing.medium, vertical: 24.h),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 2.w,
            color: colorScheme.outline,
          ),
          borderRadius: BorderRadius.circular(LemonRadius.medium),
        ),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 72.w,
                      height: 72.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: LemonColor.white06,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(LemonRadius.xSmall),
                        ),
                      ),
                    ),
                    SizedBox(width: 18.w),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 60.w,
                            height: 18.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: 36.w,
                              vertical: 18.h,
                            ),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: LemonColor.white06,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.r),
                              ),
                            ),
                          ),
                          SizedBox(height: 9.h),
                          Container(
                            width: double.infinity,
                            height: 27.h,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 12.h,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 36.w,
                                    vertical: 18.h,
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: LemonColor.white06,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3.r),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 3.h),
                                Container(
                                  width: 160.w,
                                  height: 12.h,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 36.w,
                                    vertical: 18.h,
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: LemonColor.white06,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3.r),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                height: 85.h,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 28,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60.w,
                                  height: 18.h,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 36.w,
                                    vertical: 18.h,
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: LemonColor.white06,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3.r),
                                    ),
                                  ),
                                ),
                                SizedBox(width: Spacing.xSmall),
                                Container(
                                  width: 60.w,
                                  height: 18.h,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 36.w,
                                    vertical: 18.h,
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: LemonColor.white06,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3.r),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Container(
                      width: double.infinity,
                      height: 42.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 36.w,
                        vertical: 18.h,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: LemonColor.white06,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  t.event.rewards,
                  textAlign: TextAlign.center,
                  style: Typo.extraMedium.copyWith(
                    fontFamily: FontFamily.nohemiVariable,
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                SizedBox(
                  height: Spacing.extraSmall,
                ),
                Text(
                  t.event.rewardsDescription,
                  textAlign: TextAlign.center,
                  style: Typo.small.copyWith(color: colorScheme.onSecondary),
                ),
                SizedBox(
                  height: Spacing.smMedium,
                ),
                LinearGradientButton(
                  width: 108.w,
                  label: t.event.addPoap,
                  trailing: ThemeSvgIcon(
                    builder: (filter) =>
                        Assets.icons.icSendMessage.svg(colorFilter: filter),
                  ),
                  mode: GradientButtonMode.lavenderMode,
                  radius: BorderRadius.circular(LemonRadius.normal),
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.xSmall,
                    vertical: 9.h,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
