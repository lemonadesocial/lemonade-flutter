import 'dart:io';

import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../widgets/theme_svg_icon_widget.dart';

class OnboardingPhotoPicker extends StatelessWidget {
  const OnboardingPhotoPicker({
    Key? key,
    required this.onTap,
    this.imageFile,
  }) : super(key: key);

  final VoidCallback onTap;
  final XFile? imageFile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 327.w,
      height: 327.w,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LemonRadius.small),
        border: Border.all(
          color: theme.colorScheme.outline,
          width: 0.5.w,
        ),
        color: theme.colorScheme.onPrimary.withOpacity(0.06),
      ),
      child: imageFile != null
          ? Image.file(
              File(imageFile!.path),
              fit: BoxFit.fill,
            )
          : InkWell(
              onTap: onTap,
              child: Center(
                child: ThemeSvgIcon(
                  color: theme.colorScheme.onSurfaceVariant,
                  builder: (colorFilter) => Assets.icons.icSelectImage.svg(
                    colorFilter: colorFilter,
                  ),
                ),
              ),
            ),
    );
  }
}
