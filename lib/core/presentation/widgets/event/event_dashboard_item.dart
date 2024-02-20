import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventDashboardItem extends StatelessWidget {
  const EventDashboardItem({
    super.key,
    required this.icon,
    required this.child,
    required this.onTap,
  });

  final Widget icon;
  final Widget child;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
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
            color: LemonColor.chineseBlack,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  height: 61.w,
                  padding: const EdgeInsets.all(15),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: const Alignment(0.00, -1.00),
                      end: const Alignment(0, 1),
                      colors: [LemonColor.chineseBlack, Colors.black],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  child: Column(
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
