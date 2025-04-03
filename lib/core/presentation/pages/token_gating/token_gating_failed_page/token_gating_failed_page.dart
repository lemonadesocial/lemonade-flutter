import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/token-gating/entities/space_token_gate.dart';
import 'package:app/core/presentation/pages/token_gating/widget/token_gating_wallet_address_box.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/wallet/wallet_session_address_extension.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TokenGatingFailedPage extends StatelessWidget {
  final List<SpaceTokenGate> tokenGates;
  final Function()? onChangeWalletAddress;

  const TokenGatingFailedPage({
    super.key,
    required this.tokenGates,
    this.onChangeWalletAddress,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(LemonRadius.small),
          topRight: Radius.circular(LemonRadius.small),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: BottomSheetGrabber(),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.small),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Spacing.medium),
                  ThemeSvgIcon(
                    color: LemonColor.coralReef,
                    builder: (filter) => Assets.icons.icError.svg(
                      colorFilter: filter,
                      width: Sizing.medium,
                      height: Sizing.medium,
                    ),
                  ),
                  SizedBox(height: Spacing.medium),
                  Text(
                    t.tokenGating.noTokensFounds,
                    style: Typo.extraLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  SizedBox(height: Spacing.superExtraSmall),
                  Text(
                    t.tokenGating.noTokensFoundsDescription,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height: Spacing.medium),
                  BlocBuilder<WalletBloc, WalletState>(
                    builder: (context, state) {
                      return TokenGatingWalletAddressBox(
                        address: state.activeSession?.address ?? '',
                        onTapEdit: onChangeWalletAddress,
                      );
                    },
                  ),
                  SizedBox(height: Spacing.xSmall),
                  Container(
                    decoration: BoxDecoration(
                      color: LemonColor.chineseBlack,
                      borderRadius: BorderRadius.circular(LemonRadius.small),
                      border: Border.all(
                        color: colorScheme.outlineVariant,
                      ),
                    ),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          _TokenGateItem(tokenGate: tokenGates[index]),
                      separatorBuilder: (context, index) => Divider(
                        thickness: 1,
                        color: colorScheme.outline,
                      ),
                      itemCount: tokenGates.length,
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

class _TokenGateItem extends StatelessWidget {
  final SpaceTokenGate tokenGate;

  const _TokenGateItem({required this.tokenGate});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.small),
      child: Row(
        children: [
          Text(
            tokenGate.name ?? '',
            style: Typo.medium.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
          if (tokenGate.isNft != true)
            Text(
              ' (>${Web3Utils.formatCryptoCurrency(
                BigInt.parse(tokenGate.minValue ?? '0'),
                currency: '',
                decimals: tokenGate.decimals?.toInt() ?? 0,
              )})',
              style: Typo.medium.copyWith(
                color: colorScheme.onPrimary,
              ),
            )
          else
            Text(
              '(${[
                tokenGate.minValue,
                tokenGate.maxValue,
              ].where((element) => element?.isNotEmpty == true).join('-')})',
              style: Typo.medium.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
        ],
      ),
    );
  }
}
