import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final VoidCallback? onTap;
  final Widget? additionalInfoSection;

  const CustomListTile({
    super.key,
    required this.leading,
    required this.title,
    this.onTap,
    this.additionalInfoSection,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                  if (additionalInfoSection != null) ...[
                    SizedBox(height: Spacing.small),
                    additionalInfoSection ?? const SizedBox(),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
