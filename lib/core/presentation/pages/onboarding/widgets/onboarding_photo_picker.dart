import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../theme/color.dart';
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
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 327.w,
        height: 327.w,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: theme.colorScheme.outline,
            width: 0.5.w,
          ),
          color: LemonColor.white.withOpacity(0.06),
        ),
        child: imageFile != null
            ? Image.file(
                File(imageFile!.path),
                fit: BoxFit.fill,
              )
            : Center(
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
