// ignore_for_file: unused_element

import 'dart:math';
import 'dart:ui';

import 'package:app/core/domain/badge/entities/badge_entities.dart' as badge_entities;
import 'package:app/core/domain/poap/input/poap_input.dart';
import 'package:app/core/domain/poap/poap_repository.dart';
import 'package:app/core/domain/token/entities/token_entities.dart';
import 'package:app/core/domain/token/input/get_tokens_input.dart';
import 'package:app/core/domain/token/token_repository.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/media_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

final _badgeThumbnailHeight = 144.w;
final _badgeCollectionThumbnailHeight = 65.w;
final _badgeQuantityBarSize = Size(94.w, 94.w);

class HotBadgeItem extends StatelessWidget {
  const HotBadgeItem({
    super.key,
    required this.badge,
  });

  final badge_entities.Badge badge;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _badgeThumbnailHeight,
      height: _badgeCollectionThumbnailHeight * 1.6,
      child: FutureBuilder(
        future: getIt<TokenRepository>().getToken(
          input: GetTokenDetailInput(
            id: '${badge.contract!}-0'.toLowerCase(),
            network: badge.network,
          ),
        ),
        builder: (context, snapshot) {
          final token = snapshot.data?.fold((l) => null, (token) => token);
          return Stack(
            children: [
              _BadgeThumbnail(tokenMetadata: token?.metadata),
              Align(
                alignment: const Alignment(0, 0.3),
                child: _BadgeCollectionThumbnail(badge: badge),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _BadgeName(
                  tokenMetadata: token?.metadata,
                  badge: badge,
                ),
              ),
              Positioned(
                top: Spacing.superExtraSmall,
                right: Spacing.superExtraSmall,
                child: _BadgeLocationTag(badge: badge),
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
                      child: FutureBuilder(
                        future: getIt<PoapRepository>().getPoapViewSupply(
                          input: GetPoapViewSupplyInput(
                            network: badge.network ?? '',
                            address: badge.contract?.toLowerCase() ?? '',
                          ),
                        ),
                        builder: (context, snapshot) {
                          final poapViewSupply = snapshot.data?.fold((l) => null, (poapView) => poapView);
                          var claimProgress = .0;
                          final claimedQuantity = poapViewSupply?.claimedQuantity ?? 0;
                          final quantity = poapViewSupply?.quantity ?? 0;
                          if(quantity != 0) {
                            claimProgress = claimedQuantity / quantity;
                          }
                          return TweenAnimationBuilder(
                            duration: const Duration(milliseconds: 500),
                            tween: Tween<double>(begin: 0, end: claimProgress),
                            builder: (context, animationValue, _) => CustomPaint(
                              painter: _BadgeQuantityBarPainter(isGradient: true, progress: animationValue),
                              size: _badgeQuantityBarSize,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
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
  const _BadgeLocationTag({
    required this.badge,
  });

  final badge_entities.Badge badge;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final distanceInKm = (badge.distance ?? 0) / 1000;
    String displayDistance;
    if (distanceInKm >= 1) {
      displayDistance = NumberFormat.compact().format(distanceInKm);
    } else {
      displayDistance = NumberFormat('##.##').format(badge.distance ?? 0);
    }

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
                  '$displayDistance ${distanceInKm >= 1 ? t.common.unit.km : t.common.unit.m}',
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
  const _BadgeName({
    required this.tokenMetadata,
    required this.badge,
  });

  final TokenMetadata? tokenMetadata;
  final badge_entities.Badge badge;

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
            tokenMetadata?.name ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Typo.small.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.w),
          FutureBuilder(
            future: getIt<PoapRepository>().getPoapViewSupply(
              input: GetPoapViewSupplyInput(
                network: badge.network ?? '',
                address: badge.contract?.toLowerCase() ?? '',
              ),
            ),
            builder: (context, snapshot) {
              final poapViewSupply = snapshot.data?.fold((l) => null, (poapView) => poapView);
              final claimedQuantity = poapViewSupply?.claimedQuantity ?? 0;
              final quantity = poapViewSupply?.quantity ?? 0;
              return Text(
                '$claimedQuantity/$quantity ${t.nft.claimed}',
                style: Typo.xSmall.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _BadgeCollectionThumbnail extends StatelessWidget {
  const _BadgeCollectionThumbnail({
    required this.badge,
  });

  final badge_entities.Badge badge;

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
          imageUrl: badge.listExpanded?.imageUrl ?? '',
          placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
          errorWidget: (_, __, ___) => ImagePlaceholder.defaultPlaceholder(),
        ),
      ),
    );
  }
}

class _BadgeThumbnail extends StatelessWidget {
  const _BadgeThumbnail({
    required this.tokenMetadata,
  });

  final TokenMetadata? tokenMetadata;

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
        child: FutureBuilder<Media>(
          future: MediaUtils.getNftMedia(tokenMetadata?.image, tokenMetadata?.animation_url),
          builder: (context, snapshot) => CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: snapshot.data?.url ?? '',
            placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
            errorWidget: (_, __, ___) => ImagePlaceholder.defaultPlaceholder(),
          ),
        ),
      ),
    );
  }
}
