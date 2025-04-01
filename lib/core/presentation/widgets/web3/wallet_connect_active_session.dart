import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reown_appkit/reown_appkit.dart';

class WalletConnectActiveSessionWidget extends StatelessWidget {
  final String? title;
  final ReownAppKitModalSession? activeSession;
  final Function()? onPressDisconnect;

  const WalletConnectActiveSessionWidget({
    super.key,
    this.title,
    this.activeSession,
    this.onPressDisconnect,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // final w3mService = getIt<WalletConnectService>().w3mService;
    // String displayAddress =
    //     Web3Utils.formatIdentifier(w3mService.session?.address ?? '');
    // TODO: FIX WALLET MIGRATION
    const displayAddress = '';
    final fallbackIcon = ThemeSvgIcon(
      color: colorScheme.onSurfaceVariant,
      builder: (colorFilter) => Assets.icons.icWalletFilled.svg(
        width: Sizing.small,
        height: Sizing.small,
        colorFilter: colorFilter,
      ),
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: LemonColor.chineseBlack,
            borderRadius: BorderRadius.circular(
              LemonRadius.extraSmall,
            ),
          ),
          width: Sizing.medium,
          height: Sizing.medium,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                LemonRadius.extraSmall,
              ),
              child: Center(
                child: CachedNetworkImage(
                  // TODO: FIX WALLET MIGRATION
                  imageUrl: '',
                  // explorerService.instance.getWalletImageUrl(
                  //   w3mService.selectedWallet?.listing.imageId ?? '',
                  // ),
                  placeholder: (_, __) => fallbackIcon,
                  errorWidget: (_, __, ___) => fallbackIcon,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: Spacing.xSmall),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? '',
              style: Typo.small.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
            // TODO: FIX WALLET MIGRATION
            // ignore: unnecessary_null_comparison
            Text(displayAddress),
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            context.read<WalletBloc>().add(const WalletEvent.disconnect());
          },
          child: Container(
            width: Sizing.medium,
            height: Sizing.medium,
            decoration: BoxDecoration(
              color: colorScheme.onPrimary.withOpacity(0.09),
              borderRadius: BorderRadius.circular(LemonRadius.normal),
            ),
            child: Center(
              child: ThemeSvgIcon(
                color: colorScheme.onSurfaceVariant,
                builder: (filter) => Assets.icons.icClose.svg(
                  colorFilter: filter,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
