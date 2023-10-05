import 'package:app/core/application/badge/badge_detail_bloc/badge_detail_bloc.dart';
import 'package:app/core/application/poap/claim_poap_bloc/claim_poap_bloc.dart';
import 'package:app/core/domain/badge/entities/badge_entities.dart'
    as badge_entities;
import 'package:app/core/domain/poap/input/poap_input.dart';
import 'package:app/core/domain/token/entities/token_entities.dart';
import 'package:app/core/domain/token/input/get_tokens_input.dart';
import 'package:app/core/domain/token/token_repository.dart';
import 'package:app/core/presentation/pages/poap/popap_detail_page.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/dialog/lemon_alert_dialog.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/poap/poap_claim_builder.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class PoapItem extends StatelessWidget {
  const PoapItem({
    super.key,
    required this.badge,
  });
  final badge_entities.Badge badge;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ClaimPoapBloc(
            network: badge.network ?? '',
            contract: badge.contract ?? '',
          )..add(
              const ClaimPoapEvent.checkHasClaimed(),
            ),
        ),
        BlocProvider(
          create: (context) => BadgeDetailBloc(defaultBadge: badge),
        )
      ],
      child: const _PoapItemView(),
    );
  }
}

class _PoapItemView extends StatelessWidget {
  const _PoapItemView();
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocListener<ClaimPoapBloc, ClaimPoapState>(
      listener: (_, state) {
        showDialog(
          context: context,
          builder: (context) => LemonAlertDialog(
            child: Text(state.failure?.message ?? ''),
          ),
        );
      },
      listenWhen: (prev, cur) =>
          prev.failure != cur.failure && cur.failure != null,
      child: BlocBuilder<BadgeDetailBloc, BadgeDetailState>(
        builder: (context, badgeDetailState) {
          final badge = badgeDetailState.badge;
          return FutureBuilder(
            future: getIt<TokenRepository>().getToken(
              input: GetTokenDetailInput(
                id: '${badge.contract!}-0'.toLowerCase(),
                network: badge.network,
              ),
            ),
            builder: (innerContext, snapshot) {
              final tokenDetail = snapshot.data?.fold((l) => null, (r) => r);
              return InkWell(
                onTap: () {
                  BottomSheetUtils.showSnapBottomSheet(
                    innerContext,
                    builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: BlocProvider.of<ClaimPoapBloc>(context),
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<BadgeDetailBloc>(context),
                        ),
                      ],
                      child: PopapDetailPage(
                        tokenDetail: tokenDetail,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.small,
                    vertical: Spacing.small,
                  ),
                  decoration: ShapeDecoration(
                    color: colorScheme.surfaceVariant,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(LemonRadius.small),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _PoapItemImage(tokenMetadata: tokenDetail?.metadata),
                      SizedBox(width: Spacing.small),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _PoapItemInfo(metadata: tokenDetail?.metadata),
                            SizedBox(height: Spacing.xSmall),
                            PoapQuantityBar(
                              network: badge.network ?? '',
                              contract: badge.contract ?? '',
                            ),
                            SizedBox(height: Spacing.small),
                            _PoapItemButtons(badge: badge),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _PoapItemImage extends StatelessWidget {
  const _PoapItemImage({
    required this.tokenMetadata,
  });

  final TokenMetadata? tokenMetadata;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72.w,
      height: 72.w,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
        child: FutureBuilder<Media>(
          future: MediaUtils.getNftMedia(
            tokenMetadata?.image,
            tokenMetadata?.animation_url,
          ),
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
}

class _PoapItemInfo extends StatelessWidget {
  const _PoapItemInfo({
    required this.metadata,
  });

  final TokenMetadata? metadata;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
}

class _PoapItemButtons extends StatelessWidget {
  const _PoapItemButtons({
    required this.badge,
  });

  final badge_entities.Badge badge;

  @override
  Widget build(BuildContext context) {
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
      height: 30.w,
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
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.superExtraSmall,
              vertical: Spacing.superExtraSmall,
            ),
          ),
          SizedBox(width: Spacing.superExtraSmall),
          LemonOutlineButton(
            onTap: () {},
            leading: ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) =>
                  Assets.icons.icNavigationLine.svg(colorFilter: filter),
            ),
            label:
                '$displayDistance ${distanceInKm >= 1 ? t.common.unit.km : t.common.unit.m}',
            radius: BorderRadius.circular(LemonRadius.extraSmall),
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.extraSmall,
              vertical: Spacing.superExtraSmall,
            ),
          ),
          const Spacer(),
          PoapClaimBuilder(
            badge: badge,
            builder: (context, claimPoapState, locationEnabled) {
              final buttonDisabled = !locationEnabled ||
                  badge.claimable != true ||
                  claimPoapState.claimed ||
                  claimPoapState.claiming;
              return Opacity(
                opacity: buttonDisabled ? 0.36 : 1,
                child: LinearGradientButton(
                  onTap: !buttonDisabled
                      ? () {
                          context.read<ClaimPoapBloc>().add(
                                ClaimPoapEvent.claim(
                                  input: ClaimInput(
                                    address:
                                        badge.contract?.toLowerCase() ?? '',
                                    network: badge.network ?? '',
                                  ),
                                ),
                              );
                        }
                      : null,
                  label: claimPoapState.claiming
                      ? '${t.nft.claiming}...'
                      : claimPoapState.claimed
                          ? t.nft.claimed
                          : t.nft.claim,
                  leading: Assets.icons.icDownload.svg(),
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.extraSmall,
                    vertical: Spacing.extraSmall,
                  ),
                  radius: BorderRadius.circular(LemonRadius.extraSmall),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
