import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TokenGatingWalletAddressBox extends StatelessWidget {
  const TokenGatingWalletAddressBox({
    super.key,
    required this.address,
    this.onTapEdit,
  });

  final String address;
  final Function()? onTapEdit;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.small),
      decoration: BoxDecoration(
        color: LemonColor.chineseBlack,
        borderRadius: BorderRadius.circular(LemonRadius.medium),
        border: Border.all(
          color: colorScheme.outlineVariant,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ThemeSvgIcon(
            builder: (filter) => Assets.icons.icWallet.svg(
              colorFilter: filter,
            ),
            color: colorScheme.onSecondary,
          ),
          SizedBox(width: Spacing.xSmall),
          Expanded(
            child: Text(
              Web3Utils.formatIdentifier(address),
              style: Typo.medium.copyWith(color: colorScheme.onPrimary),
            ),
          ),
          if (onTapEdit != null)
            InkWell(
              onTap: onTapEdit,
              child: ThemeSvgIcon(
                builder: (filter) => Assets.icons.icEdit.svg(
                  colorFilter: filter,
                  width: 18.w,
                  height: 18.w,
                ),
                color: colorScheme.onSecondary,
              ),
            ),
        ],
      ),
    );
  }
}
