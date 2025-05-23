import 'package:app/core/domain/token/entities/token_entities.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/media_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PoapClaimedPopup extends StatelessWidget {
  const PoapClaimedPopup({
    super.key,
    this.token,
    this.onClose,
    this.onTransfer,
    this.onView,
  });

  final TokenDetail? token;
  final Function()? onClose;
  final Function()? onTransfer;
  final Function()? onView;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Dialog(
      backgroundColor: colorScheme.primary,
      insetPadding: EdgeInsets.only(
        left: Spacing.smMedium,
        right: Spacing.smMedium,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                LemonRadius.small,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 339.w,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: FutureBuilder(
                            future: MediaUtils.getNftMedia(
                              token?.metadata?.image,
                              token?.metadata?.animation_url,
                            ),
                            builder: (context, snapshot) => CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: snapshot.data?.url ?? '',
                              placeholder: (_, __) =>
                                  ImagePlaceholder.defaultPlaceholder(
                                radius: BorderRadius.only(
                                  topLeft: Radius.circular(LemonRadius.small),
                                  topRight: Radius.circular(LemonRadius.small),
                                ),
                              ),
                              errorWidget: (_, __, ___) =>
                                  ImagePlaceholder.defaultPlaceholder(
                                radius: BorderRadius.only(
                                  topLeft: Radius.circular(LemonRadius.small),
                                  topRight: Radius.circular(LemonRadius.small),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () => onClose?.call(),
                            child: Container(
                              width: 42.w,
                              height: 42.w,
                              margin: EdgeInsets.all(Spacing.xSmall),
                              decoration: BoxDecoration(
                                color: colorScheme.primary.withOpacity(0.36),
                                borderRadius: BorderRadius.circular(42.w),
                              ),
                              child: Center(
                                child: Assets.icons.icClose.svg(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: LemonColor.dialogBackground,
                    padding: EdgeInsets.all(Spacing.medium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.nft.collectibleClaimed,
                          style: Typo.extraMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.generalSans,
                          ),
                        ),
                        SizedBox(height: Spacing.xSmall),
                        Text(
                          t.nft.collectibleClaimedMintedAndDeposited(
                            tokenName: token?.metadata?.name ?? '',
                          ),
                          style: Typo.medium.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                        SizedBox(height: Spacing.medium),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: LinearGradientButton(
                                label: t.nft.viewInWallet,
                                onTap: () => onView?.call(),
                              ),
                            ),
                            SizedBox(width: Spacing.extraSmall),
                            Expanded(
                              flex: 1,
                              child: LinearGradientButton(
                                label: t.nft.transfer,
                                mode: GradientButtonMode.lavenderMode,
                                onTap: () => onTransfer?.call(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
