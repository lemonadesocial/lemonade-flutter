import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final VoidCallback? onTap;
  final Widget? additionalInfoSection;

  const CustomListTile({
    Key? key,
    required this.leading,
    required this.title,
    this.onTap,
    this.additionalInfoSection,
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
            leading,
            SizedBox(width: Spacing.small),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                  additionalInfoSection != null
                      ? SizedBox(height: Spacing.small)
                      : const SizedBox(),
                  additionalInfoSection ?? const SizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
