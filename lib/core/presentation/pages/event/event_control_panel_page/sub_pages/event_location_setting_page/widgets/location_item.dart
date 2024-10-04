import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationItem extends StatelessWidget {
  final Address location;
  final Function? onPressEdit;
  final bool isDeleting;
  final Function? onPressDelete;
  final Function? onPressItem;
  final bool? isGooglePrediction;

  const LocationItem({
    super.key,
    required this.location,
    this.onPressEdit,
    this.onPressDelete,
    this.isDeleting = false,
    this.onPressItem,
    this.isGooglePrediction = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        if (onPressItem != null) {
          onPressItem!();
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Spacing.xSmall),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: Sizing.medium,
                    height: Sizing.medium,
                    decoration: ShapeDecoration(
                      color: colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(LemonRadius.normal),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Sizing.mSmall,
                          height: Sizing.mSmall,
                          child: isGooglePrediction != null &&
                                  isGooglePrediction == true
                              ? ThemeSvgIcon(
                                  color: colorScheme.onSecondary,
                                  builder: (filter) =>
                                      Assets.icons.icLocationPin.svg(
                                    colorFilter: filter,
                                    width: 15.w,
                                    height: 15.w,
                                  ),
                                )
                              : ThemeSvgIcon(
                                  color: colorScheme.onSurface,
                                  builder: (filter) =>
                                      Assets.icons.icRoundHistory.svg(
                                    colorFilter: filter,
                                    width: 15.w,
                                    height: 15.w,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Spacing.small,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          location.title ?? '',
                          style: Typo.small.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,
                            height: 0,
                          ),
                        ),
                        SizedBox(height: 2.w),
                        Text(
                          location.street1 ?? '',
                          style: Typo.small.copyWith(
                            color: colorScheme.onSecondary,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (isGooglePrediction == false)
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      onPressEdit?.call();
                    },
                    child: ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (filter) {
                        return Assets.icons.icEdit.svg(
                          colorFilter: filter,
                          width: Sizing.xSmall,
                          height: Sizing.xSmall,
                        );
                      },
                    ),
                  ),
                  SizedBox(width: Spacing.xSmall),
                  isDeleting
                      ? Loading.defaultLoading(context)
                      : InkWell(
                          onTap: () async {
                            onPressDelete?.call();
                          },
                          child: ThemeSvgIcon(
                            color: colorScheme.onSecondary,
                            builder: (filter) {
                              return Assets.icons.icDelete.svg(
                                colorFilter: filter,
                                width: Sizing.xSmall + 2.w,
                                height: Sizing.xSmall + 2.w,
                              );
                            },
                          ),
                        ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
