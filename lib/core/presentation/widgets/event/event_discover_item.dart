import 'dart:ui';

import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventDiscoverItem extends StatelessWidget {
  const EventDiscoverItem({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 120.w,
      height: 160.w,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            LemonRadius.small,
          ),
          side: BorderSide(
            width: 1.w,
            color: colorScheme.outline,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                LemonRadius.small,
              ),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl:
                    'https://s3-alpha-sig.figma.com/img/7294/6bfc/384b10e942c4081db6ddefc3b8df1d42?Expires=1693785600&Signature=Fy5UnMZqPt0SYVqO6jTnb-sDHMRVE~6KZ07Z6v2On9NIh8OXwNags9RiFJ7waACcqkDwBiWGYKNc5cA3HB80fW8h3TKCuIfUrVXKYrPLsem~gMZ~PEeMzbXhF3jHHuLjjMDOR8PGrm-n-AlGlg6xr72ieHgRZcZUliE8RbTM9dRSVIEDjivaQAkhj0iW7DHOUk0VTm64WKbe4GJByv92KUhWrgXmWlh-FdNn4h~QY8Wxuk5c2wTtXlIuTOlRGll2GXM2xYZZCUUaYXb6cSYQrxMfyz4e9TJpvOkDN7H1NQrAKeB2jq5QQ2qUSh4vXDc0qvDa1tgPu5Xfbn96eE0aKQ__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4',
                placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
                errorWidget: (_, __, ___) => ImagePlaceholder.defaultPlaceholder(),
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.bottomCenter,
                  radius: 0.8,
                  colors: [
                    LemonColor.black.withOpacity(0.5),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: Spacing.superExtraSmall,
            right: Spacing.superExtraSmall,
            child: const _EventJoinCount(),
          ),
          Positioned(
            left: Spacing.xSmall,
            bottom: Spacing.xSmall,
            child: const _EventInfo(),
          ),
        ],
      ),
    );
  }
}

class _EventInfo extends StatelessWidget {
  const _EventInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            'Early morning y......',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Typo.small.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          'Sun, 22 Dec',
          maxLines: 1,
          style: Typo.xSmall.copyWith(
            fontSize: 9.sp,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        )
      ],
    );
  }
}

class _EventJoinCount extends StatelessWidget {
  const _EventJoinCount();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.superExtraSmall),
      decoration: ShapeDecoration(
        color: colorScheme.primary.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            LemonRadius.extraSmall,
          ),
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ThemeSvgIcon(
                color: colorScheme.onPrimary,
                builder: (filter) => Assets.icons.icProfile.svg(colorFilter: filter),
              ),
              SizedBox(width: Spacing.superExtraSmall / 2),
              Text(
                '129',
                style: Typo.xSmall.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
