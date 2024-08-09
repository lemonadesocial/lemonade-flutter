import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubEventHostFilterItemWidget extends StatelessWidget {
  final User host;
  final bool selected;
  final Function()? onTap;

  const SubEventHostFilterItemWidget({
    super.key,
    required this.host,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: ShapeDecoration(
                  shape: CircleBorder(
                    side: BorderSide(
                      color: selected
                          ? colorScheme.onPrimary
                          : colorScheme.outline,
                    ),
                  ),
                ),
                child: Opacity(
                  opacity: selected ? 0.5 : 1,
                  child: LemonNetworkImage(
                    imageUrl: host.imageAvatar ?? '',
                    width: 70.w,
                    height: 70.w,
                    borderRadius: BorderRadius.circular(70.r),
                    placeholder: ImagePlaceholder.avatarPlaceholder(),
                  ),
                ),
              ),
              if (selected)
                Positioned.fill(
                  right: 0,
                  bottom: 0,
                  child: Center(
                    child: Assets.icons.icChecked.svg(),
                  ),
                ),
            ],
          ),
          SizedBox(height: Spacing.superExtraSmall),
          Text(
            host.name ?? '',
            style: Typo.small.copyWith(
              color: selected ? colorScheme.onPrimary : colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
