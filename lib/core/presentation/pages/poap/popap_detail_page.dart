import 'package:app/core/presentation/widgets/common/bottomsheet/lemon_snap_bottom_sheet_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PopapDetailPage extends StatelessWidget {
  final ScrollController? scrollController;
  const PopapDetailPage({
    super.key,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // Note: as this page is inside bottom sheet, will not wrap with scaffold
    return LemonSnapBottomSheet(
      defaultSnapSize: 0.77,
      minSnapSize: 0.77,
      maxSnapSize: 1,
      snapSizes: [0.77, 1],
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
                        child: _buildPopapImage(context),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(height: Spacing.medium),
                      ),
                      SliverToBoxAdapter(
                        child: _buildPoapInfo(context),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(height: Spacing.medium),
                      ),
                      SliverToBoxAdapter(
                        child: _buildPoapQuantityBar(context),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(height: Spacing.medium),
                      ),
                      SliverToBoxAdapter(
                        child: _buildPopapDescription(context),
                      ),
                    ],
                  ),
                ),
              ),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  _buildPopapImage(BuildContext context) {
    final imagePlaceholder = ImagePlaceholder.defaultPlaceholder(
      radius: BorderRadius.circular(
        LemonRadius.extraSmall,
      ),
    );
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        height: constraints.maxWidth,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            LemonRadius.extraSmall,
          ),
          child: CachedNetworkImage(
            imageUrl: "https://static.vecteezy.com/system/resources/thumbnails/013/003/046/small_2x/burger-cartoon-illustration-suitable-for-sticker-symbol-logo-icon-clipart-etc-free-vector.jpg",
            fit: BoxFit.cover,
            placeholder: (_, __) => imagePlaceholder,
            errorWidget: (_, __, ___) => imagePlaceholder,
          ),
        ),
      ),
    );
  }

  _buildPoapInfo(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Raging Burger",
          style: Typo.extraMedium.copyWith(fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        SizedBox(height: 2),
        Text(
          "Burger Nation",
          style: Typo.medium.copyWith(color: colorScheme.onSurfaceVariant),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildPoapQuantityBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final smallTextStyle = Typo.small.copyWith(color: colorScheme.onSurfaceVariant);
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: LinearProgressIndicator(
            value: 12 / 100,
            color: LemonColor.paleViolet,
            backgroundColor: LemonColor.paleViolet18,
            minHeight: 2,
          ),
        ),
        SizedBox(height: Spacing.extraSmall),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text("12 ${t.nft.claimed}", style: smallTextStyle),
            Text("100", style: smallTextStyle),
          ],
        ),
      ],
    );
  }

  Widget _buildPopapDescription(BuildContext context) {
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
            'Introducing "Raging Burger," an NFT collection merging art and culinary pleasure. Each masterpiece unlocks hidden menus and discounts at renowned eateries. Immerse yourself in extraordinary gastronomic experiences, savoring tantalizing flavors where art and cuisine collide.',
            style: Typo.medium.copyWith(
              color: colorScheme.onPrimary.withOpacity(0.87),
            ))
      ],
    );
  }

  Container _buildFooter(BuildContext context) {
    // TODO: just for illustration
    var needLocation = false;
    var ableToClaim = false;
    var buttonDisabled = needLocation || !ableToClaim;
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Container(
      padding: EdgeInsets.only(
        left: Spacing.smMedium,
        right: Spacing.smMedium,
        top: Spacing.smMedium,
        bottom: 2 * Spacing.smMedium,
      ),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: colorScheme.onPrimary.withOpacity(0.09)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
              child: Text.rich(
                  TextSpan(
                    text: needLocation
                        ? t.nft.needLocationToClaimPoap
                        : !ableToClaim
                            ? t.nft.ineligibleToClaimPoap
                            : t.nft.ableToClaimPoap,
                    children: [
                      if (needLocation || !ableToClaim)
                        TextSpan(
                          text: needLocation ? t.common.grantAccess : t.common.viewRequirements,
                          style: Typo.small.copyWith(color: LemonColor.paleViolet),
                          recognizer: TapGestureRecognizer()..onTap = () => print('hello world'),
                        )
                    ],
                  ),
                  style: Typo.small.copyWith(color: colorScheme.onSurfaceVariant))),
          SizedBox(
            width: Spacing.medium * 2,
          ),
          SizedBox(
            width: 90,
            height: 42,
            child: Opacity(
              opacity: buttonDisabled ? 0.36 : 1,
              child: LinearGradientButton(
                onTap: () {},
                mode: GradientButtonMode.lavenderMode,
                label: StringUtils.capitalize(t.nft.claim),
              ),
            ),
          )
        ],
      ),
    );
  }
}
