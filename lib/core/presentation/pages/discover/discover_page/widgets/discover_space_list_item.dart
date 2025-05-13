import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscoverSpaceListItem extends StatelessWidget {
  final Space space;
  final VoidCallback? onTap;

  const DiscoverSpaceListItem({
    super.key,
    required this.space,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: LemonColor.atomicBlack,
          borderRadius: BorderRadius.circular(LemonRadius.medium),
          border: Border.all(
            color: colorScheme.outline,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(Spacing.small),
          child: Row(
            children: [
              LemonNetworkImage(
                width: Sizing.large,
                height: Sizing.large,
                imageUrl: space.imageAvatar?.url ?? '',
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(LemonRadius.xSmall),
                placeholder: ImagePlaceholder.spaceThumbnail(
                  iconColor: colorScheme.onSecondary,
                ),
              ),
              SizedBox(width: Spacing.medium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      space.title ?? '',
                      style: Typo.mediumPlus.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (space.description != null &&
                        space.description!.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Text(
                        space.description!,
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
