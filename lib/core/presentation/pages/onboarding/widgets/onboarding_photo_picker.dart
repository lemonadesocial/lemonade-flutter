import 'dart:io';

import 'package:app/core/application/onboarding/onboarding_bloc/onboarding_bloc.dart';
import 'package:app/core/presentation/widgets/floating_frosted_glass_dropdown_widget.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../i18n/i18n.g.dart';
import '../../../dpos/common/dropdown_item_dpo.dart';
import '../../../widgets/theme_svg_icon_widget.dart';

class OnboardingPhotoPicker extends StatelessWidget {
  const OnboardingPhotoPicker({
    Key? key,
    this.imageFile,
  }) : super(key: key);

  final XFile? imageFile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context);
    final bloc = context.read<OnboardingBloc>();
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
                  child: FloatingFrostedGlassDropdown(
                    items: <DropdownItemDpo<ImageAction>>[
                      DropdownItemDpo(
                        label: t.onboarding.selectImage,
                        value: ImageAction.selectImage,
                        leadingIcon: Assets.icons.icPhotos.svg(
                          width: 15.w,
                          height: 15.w,
                        ),
                        customColor: theme.colorScheme.onPrimary,
                      ),
                      DropdownItemDpo(
                        label: t.onboarding.deleteImage,
                        value: ImageAction.deleteImage,
                        leadingIcon: Assets.icons.icDelete.svg(
                          width: 15.w,
                          height: 15.w,
                        ),
                        // No need to apply theme here since both dart theme and light theme will use the same error color
                        customColor: LemonColor.onboardingRed,
                      ),
                    ],
                    onItemPressed: (item) {
                      if (item?.value != null) {
                        switch (item!.value!) {
                          case ImageAction.selectImage:
                            bloc.selectProfileImage();
                            break;
                          case ImageAction.deleteImage:
                            bloc.removeImage();
                            break;
                        }
                      }
                    },
                    child: Container(
                      width: Sizing.medium,
                      height: Sizing.medium,
                      padding: EdgeInsets.all(9.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            LemonColor.arsenic,
                            LemonColor.charlestonGreen,
                          ],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: LemonColor.shadow5b,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Assets.icons.icRefresh.svg(),
                    ),
                  ),
                ),
              ],
            )
          : InkWell(
              onTap: bloc.selectProfileImage,
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

enum ImageAction {
  selectImage,
  deleteImage,
}
