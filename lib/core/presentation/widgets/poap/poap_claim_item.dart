import 'package:app/core/domain/badge/entities/badge_entities.dart' as badgeEntities;
import 'package:app/core/domain/token/entities/token_entities.dart';
import 'package:app/core/domain/token/input/get_tokens_input.dart';
import 'package:app/core/domain/token/token_repository.dart';
import 'package:app/core/presentation/pages/poap/popap_detail_page.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/poap/poap_quantity_bar.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/bottomsheet_utils.dart';
import 'package:app/core/utils/media_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class POAPClaimItem extends StatelessWidget {
  const POAPClaimItem({
    super.key,
    required this.badge,
  });
  final badgeEntities.Badge badge;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return FutureBuilder(
      future: getIt<TokenRepository>().getToken(
        input: GetTokenDetailInput(
          id: '${badge.contract!}-0'.toLowerCase(),
          network: badge.network,
        ),
      ),
      builder: (context, snapshot) {
        final tokenDetail = snapshot.data?.fold((l) => null, (r) => r);
        return InkWell(
          onTap: () {
            BottomSheetUtils.showSnapBottomSheet(
              context,
              builder: (context) => PopapDetailPage(
                badge: badge,
                tokenDetail: tokenDetail,
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Spacing.small, vertical: Spacing.small),
            decoration: ShapeDecoration(
              color: colorScheme.surfaceVariant,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(LemonRadius.small),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPoapImage(tokenDetail?.metadata),
                SizedBox(width: Spacing.small),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPoapInfo(colorScheme, tokenDetail?.metadata),
                      SizedBox(height: Spacing.xSmall),
                      PoapQuantityBar(badge: badge),
                      SizedBox(height: Spacing.small),
                      _buildButtons(context),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPoapImage(TokenMetadata? tokenMetadata) {
    return Container(
      width: 72,
      height: 72,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
        child: FutureBuilder<Media>(
          future: MediaUtils.getNftMedia(tokenMetadata?.image, tokenMetadata?.animation_url),
          builder: (context, snapshot) => CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: snapshot.data?.url ?? '',
            errorWidget: (_, __, ___) => ImagePlaceholder.defaultPlaceholder(
              radius: BorderRadius.circular(LemonRadius.extraSmall),
            ),
            placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(
              radius: BorderRadius.circular(LemonRadius.extraSmall),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPoapInfo(ColorScheme colorScheme, TokenMetadata? metadata) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (metadata?.name != null)
          Text(
            '${metadata?.name}',
            style: Typo.medium.copyWith(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        if (metadata?.description != null) ...[
          const SizedBox(height: 2),
          Text(
            '${metadata?.description}',
            style: Typo.small.copyWith(color: colorScheme.onSurfaceVariant),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ]
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final distanceInKm = (badge.distance ?? 0) / 1000;
    String displayDistance;
    if (distanceInKm >= 1) {
      displayDistance = NumberFormat.compact().format(distanceInKm);
    } else {
      displayDistance = NumberFormat('##.##').format(badge.distance ?? 0);
    }
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          LemonOutlineButton(
            onTap: () {},
            leading: ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icShare.svg(
                colorFilter: filter,
                width: Sizing.xSmall,
                height: Sizing.xSmall,
              ),
            ),
            radius: BorderRadius.circular(LemonRadius.extraSmall),
            padding: EdgeInsets.symmetric(horizontal: Spacing.superExtraSmall, vertical: Spacing.superExtraSmall),
          ),
          SizedBox(width: Spacing.superExtraSmall),
          LemonOutlineButton(
            onTap: () {},
            leading: ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icNavigationLine.svg(colorFilter: filter),
            ),
            label: '$displayDistance ${distanceInKm >= 1 ? t.common.unit.km : t.common.unit.m}',
            radius: BorderRadius.circular(LemonRadius.extraSmall),
            padding: EdgeInsets.symmetric(horizontal: Spacing.extraSmall, vertical: Spacing.superExtraSmall),
          ),
          const Spacer(),
          LinearGradientButton(
            label: t.nft.claim,
            leading: Assets.icons.icDownload.svg(),
            padding: EdgeInsets.symmetric(horizontal: Spacing.extraSmall, vertical: Spacing.extraSmall),
            radius: BorderRadius.circular(LemonRadius.extraSmall),
          )
        ],
      ),
    );
  }
}