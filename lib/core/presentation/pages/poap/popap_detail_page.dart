import 'package:app/core/application/badge/badge_detail_bloc/badge_detail_bloc.dart';
import 'package:app/core/application/poap/claim_poap_bloc/claim_poap_bloc.dart';
import 'package:app/core/domain/badge/entities/badge_entities.dart'
    as badge_entities;
import 'package:app/core/domain/poap/entities/poap_entities.dart';
import 'package:app/core/domain/poap/input/poap_input.dart';
import 'package:app/core/domain/token/entities/token_entities.dart';
import 'package:app/core/presentation/widgets/common/bottomsheet/lemon_snap_bottom_sheet_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/poap/poap_claim_builder.dart';
import 'package:app/core/presentation/widgets/poap/poap_policy_bottom_sheet/poap_policy_bottom_sheet.dart';
import 'package:app/core/presentation/widgets/poap/poap_quantity_bar.dart';
import 'package:app/core/utils/bottomsheet_utils.dart';
import 'package:app/core/utils/location_utils.dart';
import 'package:app/core/utils/media_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopapDetailPage extends StatefulWidget {
  const PopapDetailPage({
    super.key,
    this.scrollController,
    this.tokenDetail,
  });

  final ScrollController? scrollController;
  final TokenDetail? tokenDetail;

  @override
  State<PopapDetailPage> createState() => _PopapDetailPageState();
}

class _PopapDetailPageState extends State<PopapDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BadgeDetailBloc>().add(const BadgeDetailEvent.fetch());
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // Note: as this page is inside bottom sheet, will not wrap with scaffold
    return BlocBuilder<BadgeDetailBloc, BadgeDetailState>(
      builder: (context, badgeDetailState) {
        final badge = badgeDetailState.badge;
        return LemonSnapBottomSheet(
          defaultSnapSize: 0.77,
          minSnapSize: 0.77,
          maxSnapSize: 1,
          snapSizes: const [0.77, 1],
          backgroundColor: colorScheme.surfaceVariant,
          builder: (scrollController) => Flexible(
            child: Container(
              color: colorScheme.surfaceVariant,
              child: Column(
                children: [
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: Spacing.smMedium,
                        left: Spacing.smMedium,
                        right: Spacing.smMedium,
                      ),
                      child: CustomScrollView(
                        controller: scrollController,
                        slivers: [
                          SliverToBoxAdapter(
                            child: _PoapImage(tokenDetail: widget.tokenDetail),
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(height: Spacing.medium),
                          ),
                          SliverToBoxAdapter(
                            child: _PoapInfo(
                              tokenDetail: widget.tokenDetail,
                              badge: badge,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(height: Spacing.medium),
                          ),
                          SliverToBoxAdapter(
                            child: PoapQuantityBar(
                              network: badge.network ?? '',
                              contract: badge.contract ?? '',
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(height: Spacing.medium),
                          ),
                          SliverToBoxAdapter(
                            child: _PoapDescription(
                              tokenDetail: widget.tokenDetail,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  PoapDetailFooter(
                    badge: badge,
                    onPressClaim: () {
                      context.read<ClaimPoapBloc>().add(
                            ClaimPoapEvent.claim(
                              input: ClaimInput(
                                address: badge.contract?.toLowerCase() ?? '',
                                network: badge.network ?? '',
                              ),
                            ),
                          );
                    },
                    onPressGrantAccess: () async {
                      try {
                        final isGranted = await getIt<LocationUtils>()
                            .checkAndRequestPermission(
                          onPermissionDeniedForever: () =>
                              LocationUtils.goToSetting(context),
                        );
                        if (isGranted) {
                          context
                              .read<BadgeDetailBloc>()
                              .add(const BadgeDetailEvent.fetch());
                        }
                      } catch (error) {
                        if (kDebugMode) {
                          print('Error onPressGrantAccess: $error');
                        }
                      }
                    },
                    onPressViewRequirements: (policy) {
                      if (policy?.result == null) return;
                      BottomSheetUtils.showSnapBottomSheet(
                        context,
                        builder: (_) => MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                              value: BlocProvider.of<ClaimPoapBloc>(context),
                            ),
                            BlocProvider.value(
                              value: BlocProvider.of<BadgeDetailBloc>(context),
                            ),
                          ],
                          child: const PoapPolicyBottomSheet(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PoapDescription extends StatelessWidget {
  const _PoapDescription({
    required this.tokenDetail,
  });

  final TokenDetail? tokenDetail;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          StringUtils.capitalize(t.common.description),
          style: Typo.small.copyWith(color: colorScheme.outline),
        ),
        Text(
          tokenDetail?.metadata?.description ?? '--',
          style: Typo.medium.copyWith(
            color: colorScheme.onPrimary.withOpacity(0.87),
          ),
        )
      ],
    );
  }
}

class _PoapInfo extends StatelessWidget {
  const _PoapInfo({
    required this.tokenDetail,
    required this.badge,
  });

  final TokenDetail? tokenDetail;
  final badge_entities.Badge badge;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tokenDetail?.metadata?.name ?? '--',
          style: Typo.extraMedium.copyWith(fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        const SizedBox(height: 2),
        Text(
          badge.listExpanded?.title ?? '--',
          style: Typo.medium.copyWith(color: colorScheme.onSurfaceVariant),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ],
    );
  }
}

class _PoapImage extends StatelessWidget {
  const _PoapImage({
    required this.tokenDetail,
  });

  final TokenDetail? tokenDetail;

  @override
  Widget build(BuildContext context) {
    final imagePlaceholder = ImagePlaceholder.defaultPlaceholder(
      radius: BorderRadius.circular(
        LemonRadius.extraSmall,
      ),
    );
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        height: constraints.maxWidth,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            LemonRadius.extraSmall,
          ),
          child: FutureBuilder(
            future: MediaUtils.getNftMedia(
              tokenDetail?.metadata?.image,
              tokenDetail?.metadata?.animation_url,
            ),
            builder: (context, snapshot) => CachedNetworkImage(
              imageUrl: snapshot.data?.url ?? '',
              fit: BoxFit.cover,
              placeholder: (_, __) => imagePlaceholder,
              errorWidget: (_, __, ___) => imagePlaceholder,
            ),
          ),
        ),
      ),
    );
  }
}

class PoapDetailFooter extends StatefulWidget {
  const PoapDetailFooter({
    super.key,
    required this.badge,
    required this.onPressGrantAccess,
    required this.onPressClaim,
    required this.onPressViewRequirements,
  });

  final badge_entities.Badge badge;
  final Function() onPressGrantAccess;
  final Function() onPressClaim;
  final Function(PoapPolicy? poapPolicy) onPressViewRequirements;

  @override
  State<PoapDetailFooter> createState() => _PoapDetailFooterState();
}

class _PoapDetailFooterState extends State<PoapDetailFooter>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        setState(() {});
        context.read<BadgeDetailBloc>().add(const BadgeDetailEvent.fetch());
        break;
      // ignore: no_default_cases
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return PoapClaimBuilder(
      badge: widget.badge,
      builder: (context, claimPoapState, locationEnabled) {
        final ableToClaim = widget.badge.claimable ?? false;
        final buttonDisabled = !locationEnabled ||
            widget.badge.claimable != true ||
            claimPoapState.claimed ||
            claimPoapState.claiming;
        return Container(
          padding: EdgeInsets.only(
            left: Spacing.smMedium,
            right: Spacing.smMedium,
            top: Spacing.smMedium,
            bottom: 2 * Spacing.smMedium,
          ),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: colorScheme.onPrimary.withOpacity(0.09),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!claimPoapState.claimed)
                Flexible(
                  child: Text.rich(
                    TextSpan(
                      text: !locationEnabled
                          ? t.nft.needLocationToClaimPoap
                          : !ableToClaim
                              ? t.nft.ineligibleToClaimPoap
                              : t.nft.ableToClaimPoap,
                      children: [
                        if (!locationEnabled || !ableToClaim)
                          TextSpan(
                            text: !locationEnabled
                                ? t.common.grantAccess
                                : t.common.viewRequirements,
                            style: Typo.small
                                .copyWith(color: LemonColor.paleViolet),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                if (!locationEnabled) {
                                  await widget.onPressGrantAccess();
                                  setState(() {});
                                }
                                if (!ableToClaim) {
                                  widget.onPressViewRequirements(
                                    claimPoapState.policy,
                                  );
                                }
                              },
                          )
                      ],
                    ),
                    style: Typo.small
                        .copyWith(color: colorScheme.onSurfaceVariant),
                  ),
                ),
              SizedBox(
                width: Spacing.medium * 2,
              ),
              SizedBox(
                width: 90,
                height: 42,
                child: Opacity(
                  opacity: buttonDisabled ? 0.36 : 1,
                  child: LinearGradientButton(
                    onTap: !buttonDisabled ? widget.onPressClaim : null,
                    mode: GradientButtonMode.lavenderMode,
                    label: claimPoapState.claiming
                        ? '${StringUtils.capitalize(t.nft.claiming)}...'
                        : claimPoapState.claimed
                            ? StringUtils.capitalize(t.nft.claimed)
                            : StringUtils.capitalize(t.nft.claim),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
