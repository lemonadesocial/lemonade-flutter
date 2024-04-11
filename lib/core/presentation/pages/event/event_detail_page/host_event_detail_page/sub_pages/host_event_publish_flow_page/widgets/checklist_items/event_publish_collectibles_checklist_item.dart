import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/domain/poap/input/poap_input.dart';
import 'package:app/core/domain/poap/poap_repository.dart';
import 'package:app/core/domain/token/entities/token_entities.dart';
import 'package:app/core/domain/token/input/get_tokens_input.dart';
import 'package:app/core/domain/token/token_repository.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/checklist_item_base_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/media_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventPublishCollectiblesChecklistItem extends StatelessWidget {
  final bool fulfilled;
  final Event event;
  const EventPublishCollectiblesChecklistItem({
    super.key,
    required this.fulfilled,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final collectibles = (event.offers ?? [])
        .where(
          (item) => item.provider == OfferProvider.poap,
        )
        .toList();

    return CheckListItemBaseWidget(
      onTap: () => SnackBarUtils.showComingSoon(),
      title: t.event.eventPublish.addCollectible,
      icon: Assets.icons.icCrystal,
      fulfilled: fulfilled,
      child: fulfilled
          ? FutureBuilder(
              future: getIt<TokenRepository>().tokens(
                input: GetTokenComplexInput(
                  where: TokenWhereComplex(
                    contractIn: collectibles
                        .map((offer) => offer.providerId ?? '')
                        .toList(),
                    networkIn: collectibles
                        .map((offer) => offer.providerNetwork ?? '')
                        .toList(),
                    tokenIdEq: '0',
                  ),
                ),
              ),
              builder: (context, snapshot) {
                if (snapshot.hasError ||
                    snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.data == null) {
                  return const SizedBox.shrink();
                }
                var tokens = snapshot.data?.fold((l) => [], (list) => list) ??
                    ([] as List<TokenComplex>);

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...tokens.asMap().entries.map((entry) {
                      final isLast = entry.key == tokens.length - 1;
                      return _CollectibleItem(
                        token: entry.value,
                        isLast: isLast,
                      );
                    }),
                  ],
                );
              },
            )
          : null,
    );
  }
}

class _CollectibleItem extends StatelessWidget {
  final TokenComplex token;
  final bool isLast;

  const _CollectibleItem({
    required this.token,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: isLast ? 0 : Spacing.small,
        ),
        child: Row(
          children: [
            FutureBuilder(
              future: MediaUtils.getNftMedia(
                token.metadata?.image,
                token.metadata?.animation_url,
              ),
              builder: (context, snapshot) => ClipRRect(
                borderRadius: BorderRadius.circular(3.w),
                child: Container(
                  width: Sizing.xSmall,
                  height: Sizing.xSmall,
                  color: LemonColor.atomicBlack,
                  child: CachedNetworkImage(
                    width: Sizing.xSmall,
                    height: Sizing.xSmall,
                    imageUrl: snapshot.data?.url ?? '',
                    placeholder: (_, __) =>
                        ImagePlaceholder.defaultPlaceholder(),
                    errorWidget: (_, __, ___) =>
                        ImagePlaceholder.defaultPlaceholder(),
                  ),
                ),
              ),
            ),
            SizedBox(width: Spacing.xSmall),
            Expanded(
              flex: 1,
              child: Text.rich(
                TextSpan(
                  text: token.metadata?.name ?? '',
                  style: Typo.medium.copyWith(color: colorScheme.onSecondary),
                ),
              ),
            ),
            FutureBuilder(
              future: getIt<PoapRepository>().getPoapViewSupply(
                input: GetPoapViewSupplyInput(
                  network: token.network ?? '',
                  address: token.contract?.toLowerCase() ?? '',
                ),
              ),
              builder: (context, snapshot) {
                if (snapshot.hasError ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox.shrink();
                }
                final poapViewSupply =
                    snapshot.data?.fold((l) => null, (poapView) => poapView);
                final quantity = poapViewSupply?.quantity ?? 0;
                return Text(
                  quantity.toString(),
                  style: Typo.medium.copyWith(color: colorScheme.onSecondary),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
