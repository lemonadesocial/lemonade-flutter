import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

class EventDashboardItem extends StatelessWidget {
  const EventDashboardItem({
    super.key,
    required this.icon,
    required this.onTap,
    this.loading = false,
  });

  final Widget icon;
  final Function() onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;

    return Flexible(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(
            top: 1.w,
            left: 1.w,
            right: 1.w,
            bottom: Spacing.superExtraSmall,
          ),
          decoration: ShapeDecoration(
            color: appColors.cardBg,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(21.r),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  height: 52.w,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: appColors.cardBg,
                    // gradient: LinearGradient(
                    //   begin: const Alignment(0.00, -1.00),
                    //   end: const Alignment(0, 1),
                    //   colors: [
                    //     colorScheme.outlineVariant,
                    //     colorScheme.onPrimary.withOpacity(0.06),
                    //   ],
                    // ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: appColors.cardBorder,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: loading
                      ? Loading.defaultLoading(context)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            icon,
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
