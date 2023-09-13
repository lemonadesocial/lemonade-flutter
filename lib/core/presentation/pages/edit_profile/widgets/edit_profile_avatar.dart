import 'dart:io';

import 'package:app/core/application/profile/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileAvatar extends StatelessWidget {
  const EditProfileAvatar({
    Key? key,
    this.imageFile,
  }) : super(key: key);

  final XFile? imageFile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.read<EditProfileBloc>();
    return SizedBox(
      width: 80.w,
      height: 80.w,
      child: imageFile != null
          ? Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Image.file(
                      File(imageFile!.path),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: bloc.selectProfileImage,
                    child: Container(
                      width: 36.w,
                      height: 36.w,
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: LemonColor.greyBg,
                        shape: BoxShape.circle,
                      ),
                      child: Assets.icons.icEdit
                          .svg(color: theme.colorScheme.onPrimary),
                    ),
                  ),
                ),
              ],
            )
          : InkWell(
              onTap: bloc.selectProfileImage,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.onPrimary.withOpacity(0.09),
                    width: 0.5.w,
                  ),
                  color: theme.colorScheme.onPrimary.withOpacity(0.12),
                ),
                alignment: Alignment.center,
                child: ThemeSvgIcon(
                  color: theme.colorScheme.onSurfaceVariant,
                  builder: (colorFilter) => Assets.icons.icAddPhoto.svg(
                    colorFilter: colorFilter,
                  ),
                ),
              ),
            ),
    );
  }
}
