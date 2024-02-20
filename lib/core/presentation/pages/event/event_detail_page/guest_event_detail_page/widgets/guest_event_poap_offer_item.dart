import 'dart:ui';

import 'package:app/core/application/poap/claim_poap_bloc/claim_poap_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/poap/input/poap_input.dart';
import 'package:app/core/domain/token/entities/token_entities.dart';
import 'package:app/core/presentation/widgets/common/app_backdrop/app_backdrop.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/poap/poap_quantity_bar.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/media_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestEventPoapOfferItem extends StatelessWidget {
  const GuestEventPoapOfferItem({
    super.key,
    required this.offer,
    this.token,
  });

  final EventOffer offer;
  final TokenComplex? token;

  @override
  Widget build(BuildContext context) {
    if (token == null) return const SizedBox.shrink();

    return BlocProvider(
      create: (context) => ClaimPoapBloc(
        network: token?.network ?? '',
        contract: token?.contract ?? '',
      )..add(
          const ClaimPoapEvent.checkHasClaimed(),
        ),
      child: GuestEventPoapOfferItemView(
        offer: offer,
        token: token,
      ),
    );
  }
}

class GuestEventPoapOfferItemView extends StatefulWidget {
  const GuestEventPoapOfferItemView({
    super.key,
    required this.offer,
    this.token,
  });

  final EventOffer offer;
  final TokenComplex? token;

  @override
  State<GuestEventPoapOfferItemView> createState() =>
      GuestEventPoapOfferItemState();
}

class GuestEventPoapOfferItemState extends State<GuestEventPoapOfferItemView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 229.w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.r),
        child: Stack(
          children: [
            Positioned(
              top: Spacing.superExtraSmall,
              left: Spacing.superExtraSmall,
              child: SizedBox(
                width: Sizing.xLarge * 2,
                height: Sizing.xLarge * 2,
                child: FutureBuilder(
                  future: MediaUtils.getNftMedia(
                    widget.token?.metadata?.image,
                    widget.token?.metadata?.animation_url,
                  ),
                  builder: (context, snapshot) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        LemonRadius.small,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Opacity(
                          opacity: 0.5,
                          child: ImageFiltered(
                            imageFilter:
                                ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: snapshot.data?.url ?? '',
                              placeholder: (_, __) =>
                                  ImagePlaceholder.defaultPlaceholder(),
                              errorWidget: (_, __, ___) =>
                                  ImagePlaceholder.defaultPlaceholder(),
                            ),
                          ),
                        ),
                        const AppBackdrop(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: colorScheme.onPrimary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(15.r),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.medium,
                vertical: Spacing.medium,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FutureBuilder(
                        future: MediaUtils.getNftMedia(
                          widget.token?.metadata?.image,
                          widget.token?.metadata?.animation_url,
                        ),
                        builder: (context, snapshot) => Container(
                          width: Sizing.medium * 2,
                          height: Sizing.medium * 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              LemonRadius.small,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(LemonRadius.xSmall),
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
                      ),
                      SizedBox(
                        width: Spacing.smMedium,
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.token?.metadata?.name ?? '',
                              style: Typo.mediumPlus.copyWith(
                                color: colorScheme.onPrimary,
                                fontFamily: FontFamily.nohemiVariable,
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: Spacing.superExtraSmall),
                            Text(
                              widget.token?.metadata?.description ?? '',
                              style: Typo.medium.copyWith(
                                color: colorScheme.onSecondary,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Spacing.medium,
                  ),
                  PoapQuantityBar(
                    network: widget.token?.network ?? '',
                    contract: widget.token?.contract?.toLowerCase() ?? '',
                    height: Sizing.xxSmall / 2,
                    color: colorScheme.onPrimary,
                    backgroundColor: colorScheme.onPrimary.withOpacity(0.09),
                  ),
                  SizedBox(
                    height: Spacing.small,
                  ),
                  BlocBuilder<ClaimPoapBloc, ClaimPoapState>(
                    builder: (context, state) {
                      final claiming = state.claiming;
                      final hasClaimed = state.claimed;
                      final isChecking = state.checking;
                      final claimable = state.policy != null
                          ? state.policy?.result?.boolean ?? false
                          : !hasClaimed;

                      if (isChecking) {
                        return SizedBox(
                          height: 42.w,
                          child: Loading.defaultLoading(context),
                        );
                      }

                      if (hasClaimed) {
                        return Container(
                          height: 42.w,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(LemonRadius.xSmall),
                            color: colorScheme.onPrimary.withOpacity(0.06),
                          ),
                          child: DottedBorder(
                            strokeWidth: 1.w,
                            color: colorScheme.outline,
                            dashPattern: [5.w],
                            borderType: BorderType.RRect,
                            radius: Radius.circular(LemonRadius.xSmall),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ThemeSvgIcon(
                                    color: colorScheme.onSurfaceVariant,
                                    builder: (filter) => Assets.icons.icDone
                                        .svg(colorFilter: filter),
                                  ),
                                  SizedBox(width: Spacing.xSmall),
                                  Text(
                                    StringUtils.capitalize(t.nft.claimed),
                                    style: Typo.medium.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: FontFamily.nohemiVariable,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }

                      return SizedBox(
                        height: 42.w,
                        child: Opacity(
                          opacity: claimable && !claiming ? 1 : 0.5,
                          child: LinearGradientButton(
                            onTap: !claimable || claiming
                                ? null
                                : () {
                                    context.read<ClaimPoapBloc>().add(
                                          ClaimPoapEvent.claim(
                                            input: ClaimInput(
                                              address:
                                                  widget.token?.contract ?? '',
                                              network:
                                                  widget.token?.network ?? '',
                                            ),
                                          ),
                                        );
                                  },
                            mode: GradientButtonMode.lavenderMode,
                            label: claiming
                                ? t.common.processing
                                : StringUtils.capitalize(t.nft.claim),
                            textStyle: Typo.medium.copyWith(
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.nohemiVariable,
                              color: colorScheme.onPrimary.withOpacity(0.87),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
