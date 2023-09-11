import 'dart:io';

import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
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
          ? Stack(
              children: [
                Positioned.fill(
                  child: Image.file(
                    File(imageFile!.path),
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  top: 12.w,
                  right: 12.w,
                  child: Container(
                    width: Sizing.medium,
                    height: Sizing.medium,
                    padding: EdgeInsets.all(9.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: const Alignment(0, 1),
                        colors: [
                          LemonColor.arsenic,
                          LemonColor.charlestonGreen
                        ],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x5B000000),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Assets.icons.icRefresh.svg(),
                  ),
                ),
              ],
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
