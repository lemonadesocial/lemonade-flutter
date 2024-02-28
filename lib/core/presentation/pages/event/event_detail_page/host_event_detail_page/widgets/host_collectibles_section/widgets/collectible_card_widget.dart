import 'dart:ui';

import 'package:app/core/domain/poap/input/poap_input.dart';
import 'package:app/core/domain/poap/poap_repository.dart';
import 'package:app/core/domain/token/entities/token_entities.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/media_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

final _poapRepository = getIt<PoapRepository>();

class CollectibleCardWidget extends StatelessWidget {
  final TokenComplex token;
  const CollectibleCardWidget({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.onPrimary.withOpacity(0.06),
        borderRadius: BorderRadius.circular(LemonRadius.medium),
      ),
      child: FutureBuilder(
        future: MediaUtils.getNftMedia(
          token.metadata?.image,
          token.metadata?.animation_url,
        ),
        builder: (context, snapshot) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(
                    LemonRadius.medium,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(LemonRadius.medium),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) =>
                        ImagePlaceholder.defaultPlaceholder(),
                    placeholder: (_, __) =>
                        ImagePlaceholder.defaultPlaceholder(),
                    imageUrl: snapshot.data?.url ?? '',
                  ),
                ),
              ),
              _ClaimInfo(
                network: token.network ?? '',
                contract: token.contract?.toLowerCase() ?? '',
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ClaimInfo extends StatelessWidget {
  const _ClaimInfo({
    required this.network,
    required this.contract,
  });

  final String network;
  final String contract;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Positioned(
      top: Spacing.superExtraSmall,
      right: Spacing.superExtraSmall,
      child: FutureBuilder(
        future: _poapRepository.getPoapViewSupply(
          input: GetPoapViewSupplyInput(
            network: network,
            address: contract.toLowerCase(),
          ),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              width: Sizing.medium,
              child: Loading.defaultLoading(context),
            );
          }

          final poapViewSupply =
              snapshot.data?.fold((l) => null, (poapView) => poapView);
          final claimedQuantity = poapViewSupply?.claimedQuantity ?? 0;
          final quantity = poapViewSupply?.quantity ?? 0;
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.extraSmall,
              vertical: Spacing.superExtraSmall,
            ),
            decoration: ShapeDecoration(
              color: colorScheme.primary.withOpacity(0.36),
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
                  children: [
                    Text(
                      '$claimedQuantity/$quantity ${t.nft.claimed}',
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
        },
      ),
    );
  }
}
