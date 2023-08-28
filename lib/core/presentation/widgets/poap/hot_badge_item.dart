// ignore_for_file: unused_element

import 'dart:math';
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

final _badgeThumbnailHeight = 144.w;
final _badgeCollectionThumbnailHeight = 65.w;
final _badgeQuantityBarSize = Size(94.w, 94.w);

class HotBadgeItem extends StatefulWidget {
  const HotBadgeItem({super.key});

  @override
  State<HotBadgeItem> createState() => _HotBadgeItemState();
}

class _HotBadgeItemState extends State<HotBadgeItem> {
  late final Tween<double> _tween = Tween<double>(begin: 0, end: 0.9);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _badgeThumbnailHeight,
      height: _badgeCollectionThumbnailHeight * 1.6,
      child: Stack(
        children: [
          const _BadgeThumbnail(),
          const Align(
            alignment: Alignment(0, 0.3),
            child: _BadgeCollectionThumbnail(),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: _BadgeName(),
          ),
          Positioned(
            top: Spacing.superExtraSmall,
            right: Spacing.superExtraSmall,
            child: const _BadgeLocationTag(),
          ),
          Align(
            alignment: const Alignment(0, 0.3),
            child: Stack(
              children: [
                Transform.flip(
                  flipY: true,
                  child: CustomPaint(
                    painter: _BadgeQuantityBarPainter(),
                    size: _badgeQuantityBarSize,
                  ),
                ),
                Transform.flip(
                  flipY: true,
                  child: TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 500),
                    tween: _tween,
                    builder: (context, animationValue, _) => CustomPaint(
                      painter: _BadgeQuantityBarPainter(isGradient: true, progress: animationValue),
                      size: _badgeQuantityBarSize,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _BadgeQuantityBarPainter extends CustomPainter {
  _BadgeQuantityBarPainter({
    this.isGradient = false,
    this.progress = 1,
  }) : super();
  final bool isGradient;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(0, 0, size.width, size.height);
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.w;

    if (isGradient) {
      paint.shader = SweepGradient(
        center: Alignment.centerRight,
        endAngle: 1,
        colors: [
          LemonColor.white,
          LemonColor.paleViolet,
        ],
      ).createShader(rect);
    } else {
      paint.color = LemonColor.paleViolet36;
    }

    const startAngle = 0.6 + pi;
    final sweepAngle = (pi - 1.2) * progress;
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _BadgeLocationTag extends StatelessWidget {
  const _BadgeLocationTag();

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
          child: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ThemeSvgIcon(
                  color: colorScheme.onPrimary,
                  builder: (filter) => Assets.icons.icNavigationFilled.svg(colorFilter: filter),
                ),
                SizedBox(width: Spacing.superExtraSmall / 2),
                Text(
                  '1.2km',
                  style: Typo.xSmall.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BadgeName extends StatelessWidget {
  const _BadgeName();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Spacing.extraSmall,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Raging Burger',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Typo.small.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.w),
          Text(
            '82/100 claimed',
            style: Typo.xSmall.copyWith(
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

const collectionThumbnails = [
  'https://s3-alpha-sig.figma.com/img/b2b5/81b9/060fc740efe7a7c28ec3b2acd4147df2?Expires=1693785600&Signature=TGMwFv-Tke6mJzC70ESjbSGLEdK99fjgYEpp6janm8RsKyVLZJOOmBRwP9~m8DLJycz8q7hkEIevkOumQ8MkU910Rblt2efcd4pmexwyWdeMgb7eLz748W4tw7X5uN0Lh0zUF720Kzs7LogYosiIz-FXAzskCL9K8aZ9pXspjKaNymugET6mGPLQ78doux5m~VbBy2Mjf293rTyUD88VeIJ2hBxYLsOMCiaVoeJF6lB4VQBpPlYES~ljRY~WXeYxxV1i7TdLql3JylEEqCjirONolstSycm6rgc8SCSDLFmTmTxY6~0mwvs3qAL9lhQ8mahn3kb3dJOvgHbVklPdUA__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4',
  'https://s3-alpha-sig.figma.com/img/1a60/9488/951de67469eeda9d8620bbe234f635f9?Expires=1693785600&Signature=L6NB82-IsGn7EEjFHmpLtuvFluuSvNO6EZat2yWZ4yPsPMMrxl-8as~3o-QY4IZi7~XmxWYfpicaK0lphYgnFABh65GHYLo4SKVbPekBZuKWzRsoMtihZhY7rDwKCrzpjqRS9pzN2Ss3VfCj6zjlqhbXh5HM-KAMTqH8lnPdSgJxGhgoLwI6owo4XVUzDrsGVZ7BXa0Av5EjGrsnssJCCbntIWso5LmsKGmtehvxRJxHR1jmcHMjrFzNirAIcVOv~3VtioTTUKAFIJLssPU585mmdNWx5gDGvFBzsbIZQeKH-~OoVhK8c5cgG6UPzTinDCEbJ8ErlQIzeYkMv34xCA__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4',
  'https://s3-alpha-sig.figma.com/img/3d60/bcfe/eae148f9a38b5ac2ff50115261ba41a9?Expires=1693785600&Signature=WEMkpnI9spQnCb2rymoOM8xn~wIx57hYiB0usdGOJcIRVxiPYdGRKRDrCbnOXeDj01J-l4PASkpGH9KL4gpp6wfEVkijD9KpvMuV0VrvjxHtrhf5lVzqDAmyArRQSuUapqkmnvQ6bGAr-JJwNOwqU1YoH2ee56Sc6T1ZIGOtZhlEI5JAL3dAJ7CR21jqIlvb6CmJKvbENztflSP9IncGDnwrQLi60pV-QBBhmr2-4KmPd8KWuUCG-2jwXaL6RNM5M4snby15cXZctiiypXzHICiBRTAPxhw94NHpapR59DuRBv1Gj8wIFcYiOZ-74u6mwAz8KNZv75wza0T1lHZQYg__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4',
];

class _BadgeCollectionThumbnail extends StatelessWidget {
  const _BadgeCollectionThumbnail();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _badgeCollectionThumbnailHeight,
      width: _badgeCollectionThumbnailHeight,
      decoration: ShapeDecoration(
        shape: CircleBorder(
          side: BorderSide(color: Colors.white, width: 4.w),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: collectionThumbnails[Random().nextInt(2)],
          placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
          errorWidget: (_, __, ___) => ImagePlaceholder.defaultPlaceholder(),
        ),
      ),
    );
  }
}

const badgeThumbnails = [
  'https://s3-alpha-sig.figma.com/img/2612/46f7/1df532592e016bc83de3d5f4a22bc83e?Expires=1693785600&Signature=fek6RMir4GR~4xlsFEswggSSuGNRoFLjZLwGRkCa0F2~ODODrMKRTBc6Ggi1xiTRlEvQDD5hxpaOb-j81UFMEwQ8SS2P98Bj73XmU6Bz2x7Gxa9hcWLef4eENozYcLMrCi7bp7YAidCJefzJH0-UGA5rMRwtpms5RuTu0SzN-TKJyvoiHn3hPiLmMc9NYIiDkaEQUrgtQzbvNLetMGAfKsKgLm~G7S9xuPqeXimEmQqagrLJuB-dDdJbCRoxabtCf8U7foJW5bKeV26Nk0XN76pDStbJBnk~zvSy2k14jv6gCopqAQtIZ18~mEwYupy4FJPitKs6dEAQ3vnTKPG4Yw__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4',
  'https://s3-alpha-sig.figma.com/img/cf33/55d0/c0fa2ddcb4c2452336a845efab9d13a7?Expires=1693785600&Signature=mFtDaFRZ0pzmwvlwz0NmJXMl1eDE7uNlC-Zx3riFO485oIL92mXER3cSxi2DYza-Bl0XM1RfZfocmpDca3UadzWoaxe44yUW6hYZGuPdh0xzU5j15EevUvvAWAZq9utI7t0kIoHA3KCCp0lfd2QXYHCKepCUsgEpGZKZfUO3dTYzKRcuRH~kTq5MOrSw2iVnoh35S3t7uJuHms59dsrNC2GZD1B0D08HV~rqvrBTh3tQpproD-uG51VFI5imdtwKmFXJ~TzeFU8WSSo4X~1gqyttWGOSe3YUDVwU~Bzk-99iW-PrxmjsnYiF~Zo42tbSqJ8igHSIHIAJsZ5~~X~6dw__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4',
  'https://s3-alpha-sig.figma.com/img/769c/b5bb/27a760109b0d104b9d41d9442fef1838?Expires=1693785600&Signature=p0Pw3YH0vtAZYbsiO0SGy8rPt5e750B~nZk9AOk9hmMkCaMAAoGFZm5ApvSwqXnatzBLwlYzEPAFTOJHlBpuIJB4hqRntDX~h-cSzjPTxNxra~6rMkv6nBaiGu~iipUoNs2O7rpOVijj2YNeEluZuRnLc4IV0GleiEGMcbQLyOFdabiWnVThezZfjdrr-5KaO-WJT1j3~k-vuYJMjN6lDLEgAD9ats6P2jk2q2NBByRFp5~G0jLQXQiHfL~pjvmJ3slvZ7UVPCFORbBCZJvxuL2yBTFMQRt~F-MIuJRviILog4reaYUeIevvqiAmmAUhJQHYg0isn9lKFCo9d9GNMQ__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4'
];

class _BadgeThumbnail extends StatelessWidget {
  const _BadgeThumbnail();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _badgeThumbnailHeight,
      height: _badgeThumbnailHeight,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            LemonRadius.xSmall,
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(LemonRadius.xSmall),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: badgeThumbnails[Random().nextInt(2)],
          placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
          errorWidget: (_, __, ___) => ImagePlaceholder.defaultPlaceholder(),
        ),
      ),
    );
  }
}
