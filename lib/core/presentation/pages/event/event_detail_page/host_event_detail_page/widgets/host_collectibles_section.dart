import 'dart:ui';

import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/domain/poap/input/poap_input.dart';
import 'package:app/core/domain/poap/poap_repository.dart';
import 'package:app/core/domain/token/input/get_tokens_input.dart';
import 'package:app/core/domain/token/token_repository.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/media_utils.dart';
import 'package:app/core/utils/modal_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

final _poapRepository = getIt<PoapRepository>();

class HostCollectiblesSection extends StatelessWidget {
  const HostCollectiblesSection({
    super.key,
    required this.event,
  });

  final Event event;

  List<EventOffer> get eventPoapOffers => (event.offers ?? [])
      .where((offer) => offer.provider == OfferProvider.poap)
      .toList();

  @override
  Widget build(BuildContext context) {
    if (eventPoapOffers.isEmpty) {
      return _buildEmptyCollectibles(context);
    }
    return FutureBuilder(
      future: getIt<TokenRepository>().tokens(
        input: GetTokenComplexInput(
          where: TokenWhereComplex(
            contractIn:
                eventPoapOffers.map((offer) => offer.providerId ?? '').toList(),
            networkIn: eventPoapOffers
                .map((offer) => offer.providerNetwork ?? '')
                .toList(),
            tokenIdEq: '0',
          ),
        ),
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return SizedBox(
            child: EmptyList(
              emptyText: t.common.somethingWrong,
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            child: Loading.defaultLoading(context),
          );
        }

        if (!snapshot.hasData) {
          return SizedBox(
            child: EmptyList(
              emptyText: t.common.somethingWrong,
            ),
          );
        }

        var tokens = snapshot.data?.fold((l) => [], (list) => list) ?? [];

        if (tokens.isEmpty) {
          return SizedBox(
            child: EmptyList(
              emptyText: t.common.somethingWrong,
            ),
          );
        }
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: Spacing.xSmall,
            mainAxisSpacing: Spacing.xSmall,
            childAspectRatio: 1,
          ),
          itemCount: tokens.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return _buildAddAnotherCollectible(context);
            }
            return _buildCollectibleCard(context, tokens, index);
          },
        );
      },
    );
  }

  Widget _buildAddAnotherCollectible(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DottedBorder(
      strokeWidth: 2.w,
      color: colorScheme.outline,
      dashPattern: [8.w],
      borderType: BorderType.RRect,
      radius: Radius.circular(LemonRadius.medium),
      child: InkWell(
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          showComingSoonDialog(context);
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ThemeSvgIcon(
                builder: (colorFilter) => Assets.icons.icGiftOutline.svg(),
              ),
              SizedBox(
                height: Spacing.xSmall,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.medium),
                child: Text(
                  t.event.collectibles.addAnotherCollectble,
                  textAlign: TextAlign.center,
                  style: Typo.small.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCollectibleCard(BuildContext context, List tokens, int index) {
    final token = tokens.isNotEmpty && index - 1 <= tokens.length - 1
        ? tokens[index - 1]
        : null;

    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.onPrimary.withOpacity(0.06),
        borderRadius: BorderRadius.circular(LemonRadius.medium),
      ),
      child: FutureBuilder(
        future: MediaUtils.getNftMedia(
          token?.metadata?.image,
          token?.metadata?.animation_url,
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
                network: token?.network ?? '',
                contract: token?.contract?.toLowerCase() ?? '',
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyCollectibles(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DottedBorder(
      strokeWidth: 2.w,
      color: colorScheme.outline,
      dashPattern: [8.w],
      borderType: BorderType.RRect,
      radius: Radius.circular(LemonRadius.medium),
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.small,
        vertical: Spacing.small,
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 133.w,
                      height: 133.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: colorScheme.onPrimary.withOpacity(0.06),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(LemonRadius.xSmall),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Spacing.xSmall,
                    ),
                    Container(
                      width: 133.w,
                      height: 133.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: colorScheme.onPrimary.withOpacity(0.06),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(LemonRadius.xSmall),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 134.h,
            padding: EdgeInsets.all(Spacing.small),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  t.event.addCollectibleDescription,
                  textAlign: TextAlign.center,
                  style: Typo.medium.copyWith(color: colorScheme.onSecondary),
                ),
                SizedBox(
                  height: Spacing.xSmall,
                ),
                InkWell(
                  onTap: () {
                    Vibrate.feedback(FeedbackType.light);
                    showComingSoonDialog(context);
                  },
                  child: LinearGradientButton(
                    width: 134.w,
                    label: t.event.addCollectible,
                    trailing: ThemeSvgIcon(
                      builder: (filter) =>
                          Assets.icons.icSendMessage.svg(colorFilter: filter),
                    ),
                    mode: GradientButtonMode.lavenderMode,
                    radius: BorderRadius.circular(LemonRadius.normal),
                    padding: EdgeInsets.symmetric(
                      horizontal: Spacing.xSmall,
                      vertical: 9.h,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
