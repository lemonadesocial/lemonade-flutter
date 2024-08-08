import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventTeamMemberItemWidget extends StatelessWidget {
  const EventTeamMemberItemWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onTap,
    required this.roleName,
    this.isFirst = false,
    this.isLast = false,
  });

  final String title;
  final String subTitle;
  final String roleName;
  final VoidCallback onTap;
  final bool? isFirst;
  final bool? isLast;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            isFirst == true ? LemonRadius.medium : LemonRadius.extraSmall,
          ),
          topRight: Radius.circular(
            isFirst == true ? LemonRadius.medium : LemonRadius.extraSmall,
          ),
          bottomLeft: Radius.circular(
            isLast == true ? LemonRadius.medium : LemonRadius.extraSmall,
          ),
          bottomRight: Radius.circular(
            isLast == true ? LemonRadius.medium : LemonRadius.extraSmall,
          ),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(Spacing.small),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Sizing.medium),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: Sizing.medium,
                    height: Sizing.medium,
                    imageUrl: '',
                    placeholder: (_, __) =>
                        ImagePlaceholder.defaultPlaceholder(),
                    errorWidget: (_, __, ___) =>
                        ImagePlaceholder.defaultPlaceholder(),
                  ),
                ),
                SizedBox(
                  width: Spacing.xSmall,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Typo.medium.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 3.w,
                      ),
                      subTitle == ''
                          ? const SizedBox.shrink()
                          : Text(
                              subTitle,
                              style: Typo.small.copyWith(
                                color: colorScheme.onSecondary,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                    ],
                  ),
                ),
                SizedBox(width: Spacing.xSmall),
                _RoleName(roleName: roleName),
                SizedBox(width: Spacing.xSmall),
                Assets.icons.icMoreHoriz.svg(
                  width: Sizing.xSmall,
                  height: Sizing.xSmall,
                  color: colorScheme.onSecondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleName extends StatelessWidget {
  const _RoleName({
    required this.roleName,
  });

  final String roleName;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.xSmall,
        vertical: Spacing.smMedium / 2,
      ),
      decoration: ShapeDecoration(
        color: LemonColor.white06,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LemonRadius.normal),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            roleName,
            style: Typo.small.copyWith(
              height: 0,
              color: colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
