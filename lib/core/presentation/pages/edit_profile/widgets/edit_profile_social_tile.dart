import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileSocialTile extends StatelessWidget {
  const EditProfileSocialTile({
    super.key,
    required this.label,
    required this.leadingIcon,
    required this.onTap,
    this.content,
  });

  final String label;
  final Widget leadingIcon;
  final VoidCallback onTap;
  final String? content;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Typo.medium.copyWith(
              fontWeight: FontWeight.normal,
              color: colorScheme.onPrimary.withOpacity(0.36),
            ),
          ),
          SizedBox(height: Spacing.superExtraSmall),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 18.w),
            child: Row(
              children: [
                leadingIcon,
                SizedBox(width: Spacing.xSmall),
                Text(
                  content ?? '',
                  style: Typo.mediumPlus.copyWith(
                    fontWeight: FontWeight.normal,
                    color: colorScheme.outlineVariant,
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
