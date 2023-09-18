import 'package:app/core/presentation/widgets/chat/matrix_avatar.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchUserItem extends StatelessWidget {
  final String name;
  final Uri? avatarUrl;
  final bool isSelected;
  final void Function() onTap;

  SearchUserItem({
    required this.name,
    this.avatarUrl,
    required this.isSelected,
    required this.onTap,
  });

  Widget _buildAvatar() {
    return MatrixAvatar(
      size: 42.w,
      radius: 42.w,
      mxContent: avatarUrl,
      name: name,
      fontSize: Typo.small.fontSize!,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Spacing.extraSmall,
          horizontal: Spacing.small,
        ),
        child: Row(
          children: [
            _buildAvatar(),
            SizedBox(width: Spacing.xSmall),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Typo.medium.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: Spacing.xSmall),
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme.onPrimary,
                  width: 2.0,
                ),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: 18.w,
                      color: colorScheme.onPrimary,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}