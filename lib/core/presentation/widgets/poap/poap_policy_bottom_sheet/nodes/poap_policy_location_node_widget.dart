import 'package:app/core/domain/poap/entities/poap_entities.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/map_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PoapPolicyLocationNodeWidget extends StatelessWidget {
  const PoapPolicyLocationNodeWidget({
    super.key,
    required this.node,
    required this.result,
  });

  final PoapPolicyNode node;
  final bool result;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final lat = double.tryParse(node.children?[0].value ?? '0') ?? 0;
    final lng = double.tryParse(node.children?[1].value ?? '0') ?? 0;
    final validDistance =
        (double.tryParse(node.children?[2].value ?? '0') ?? 0) ~/ 1000;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorScheme.onPrimary.withOpacity(0.09),
                borderRadius: BorderRadius.circular(100),
              ),
              width: Sizing.medium,
              height: Sizing.medium,
              child: Center(
                child: ThemeSvgIcon(
                  color: colorScheme.onPrimary,
                  builder: (filter) =>
                      Assets.icons.icLocationPin.svg(colorFilter: filter),
                ),
              ),
            ),
            SizedBox(width: Spacing.xSmall),
            Flexible(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                    future: MapUtils.getLocationName(lat: lat, lng: lng),
                    builder: (context, snapshot) => Text(
                      t.nft.poapPolicy.locationPolicy.title(
                        distance: validDistance,
                        address: snapshot.data ?? '',
                      ),
                      style: Typo.small.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.w),
                  Text(
                    result
                        ? t.nft.poapPolicy.locationPolicy.qualified
                        : t.nft.poapPolicy.locationPolicy.nonQualified,
                    style: Typo.small.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            result
                ? Assets.icons.icInvitedFilled.svg()
                : const SizedBox.shrink()
          ],
        )
      ],
    );
  }
}
