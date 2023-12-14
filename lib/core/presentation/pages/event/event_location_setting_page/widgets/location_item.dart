import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationItem extends StatelessWidget {
  final Address location;
  final Function onPressEdit;
  final Function onPressDelete;
  const LocationItem({
    super.key,
    required this.location,
    required this.onPressEdit,
    required this.onPressDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.circle_outlined,
                      size: Spacing.medium,
                      color: colorScheme.onSurface,
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
                            style: Typo.medium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2.w),
                          Text(
                            location.street1 ?? '',
                            style: Typo.small.copyWith(
                              color: colorScheme.onSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      onPressEdit();
                    },
                    icon: ThemeSvgIcon(
                      color: colorScheme.onPrimary,
                      builder: (filter) {
                        return Assets.icons.icEdit.svg(
                          colorFilter: filter,
                          width: 20.w,
                          height: 20.w,
                        );
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      onPressDelete();
                    },
                    icon: ThemeSvgIcon(
                      color: colorScheme.onPrimary,
                      builder: (filter) {
                        return Assets.icons.icDelete.svg(
                          colorFilter: filter,
                          width: 20.w,
                          height: 20.w,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
