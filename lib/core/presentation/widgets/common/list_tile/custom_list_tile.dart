import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final VoidCallback? onTap;

  const CustomListTile({
    Key? key,
    required this.leading,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Leading Column with CrossAxisAlignment.start
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                leading,
              ],
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
