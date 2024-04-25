import 'package:app/core/presentation/pages/collaborator/sub_pages/widgets/collaborator_counter_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalCollaboratorLikesList extends StatelessWidget {
  const HorizontalCollaboratorLikesList({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
          child: Row(
            children: [
              Text(
                t.collaborator.likes,
                style: Typo.mediumPlus.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
              SizedBox(
                width: Spacing.extraSmall,
              ),
              const CollaboratorCounter(),
              const Spacer(),
              ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icArrowRight.svg(
                  colorFilter: filter,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Spacing.xSmall),
        SizedBox(
          height: 87.w,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => _PersonItem(
              isSeen: index > 2,
            ),
            separatorBuilder: (context, index) => SizedBox(
              width: Spacing.xSmall,
            ),
          ),
        ),
      ],
    );
  }
}

class _PersonItem extends StatelessWidget {
  final bool isSeen;
  const _PersonItem({
    this.isSeen = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 68.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: 64.w,
                height: 64.w,
                padding: EdgeInsets.all(2.w),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: isSeen ? 2.w : 2.w,
                      color:
                          isSeen ? colorScheme.outline : LemonColor.paleViolet,
                    ),
                    borderRadius: BorderRadius.circular(64.r),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60.r),
                  child: SizedBox(
                    width: 60.w,
                    height: 60.w,
                    child: CachedNetworkImage(
                      imageUrl: "https://via.placeholder.com/60x60",
                      width: 60.w,
                      height: 60.w,
                      errorWidget: (_, __, ___) =>
                          ImagePlaceholder.defaultPlaceholder(),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 4.w,
                right: 4.w,
                child: Assets.icons.icCollaboratorBubbleChat.svg(),
              ),
            ],
          ),
          SizedBox(height: Spacing.superExtraSmall),
          Text(
            'Omar Siphron',
            textAlign: TextAlign.center,
            style: Typo.xSmall.copyWith(
              color: isSeen ? colorScheme.onSecondary : colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
