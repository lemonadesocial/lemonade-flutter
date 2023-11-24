import 'package:app/core/presentation/widgets/lemon_bottom_sheet_mixin.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectPaymentNetworkBottomSheet extends StatelessWidget
    with LemonBottomSheet {
  final List<String> networks;
  final Function(String network) onSelectNetwork;

  const SelectPaymentNetworkBottomSheet({
    super.key,
    required this.networks,
    required this.onSelectNetwork,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.xSmall,
        vertical: Spacing.xSmall,
      ),
      child: ListView.separated(
        itemCount: networks.length,
        itemBuilder: (context, index) {
          return NetworkItem(
            network: networks[index],
            onPressed: () {
              Navigator.of(context).pop();
              onSelectNetwork(
                networks[index],
              );
            },
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          height: Spacing.xSmall,
        ),
      ),
    );
  }
}

class NetworkItem extends StatelessWidget {
  final Function()? onPressed;
  final bool selected;
  final String network;

  const NetworkItem({
    super.key,
    required this.network,
    this.onPressed,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final chainMetadata = Web3Utils.getNetworkMetadataById(network);

    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(Spacing.smMedium),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LemonRadius.small),
          color: colorScheme.onPrimary.withOpacity(0.06),
        ),
        child: Row(
          children: [
            Text(
              chainMetadata?.displayName ?? '',
              style: Typo.medium.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onPrimary.withOpacity(0.87),
              ),
            ),
            const Spacer(),
            if (selected)
              Assets.icons.icChecked.svg(
                colorFilter: ColorFilter.mode(
                  LemonColor.paleViolet,
                  BlendMode.srcIn,
                ),
              ),
            SizedBox(
              width: 1.w,
            ),
          ],
        ),
      ),
    );
  }
}
