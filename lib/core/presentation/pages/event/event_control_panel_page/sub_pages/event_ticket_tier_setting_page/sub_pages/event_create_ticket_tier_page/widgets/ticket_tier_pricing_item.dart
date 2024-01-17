import 'package:app/core/domain/event/entities/event_currency.dart';
import 'package:app/core/domain/event/input/ticket_type_input/ticket_type_input.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/domain/web3/web3_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TicketTierPricingItem extends StatelessWidget {
  final TicketPriceInput ticketPrice;
  final EventCurrency? currencyInfo;

  const TicketTierPricingItem({
    super.key,
    required this.ticketPrice,
    this.currencyInfo,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final decimals = currencyInfo?.decimals?.toInt() ?? 0;
    final formatter = NumberFormat.currency(
      symbol: ticketPrice.currency,
      decimalDigits: decimals,
    );
    double? doubleAmount;
    String? erc20DisplayedAmount;
    final isERC20 = ticketPrice.network?.isNotEmpty == true;
    if (isERC20) {
      erc20DisplayedAmount = Web3Utils.formatCryptoCurrency(
        BigInt.parse(ticketPrice.cost),
        currency: ticketPrice.currency,
        decimals: decimals,
        decimalDigits: decimals,
      );
    } else {
      final parsedAmount = int.parse(ticketPrice.cost).toString();
      doubleAmount = NumberUtils.getAmountByDecimals(
        BigInt.parse(parsedAmount),
        decimals: decimals,
      );
    }

    return FutureBuilder<Either<Failure, Chain?>>(
      future: ticketPrice.network != null
          ? getIt<Web3Repository>()
              .getChainById(chainId: ticketPrice.network ?? '')
          : Future.value(
              const Right(null),
            ),
      builder: (context, snapshot) {
        final chain = snapshot.data?.getOrElse(() => null);

        return Row(
          children: [
            Container(
              width: Sizing.medium,
              height: Sizing.medium,
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: chain != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(Sizing.medium),
                        child: CachedNetworkImage(
                          width: Sizing.medium / 2,
                          height: Sizing.medium / 2,
                          imageUrl: chain.logoUrl ?? '',
                          errorWidget: (_, __, ___) =>
                              ImagePlaceholder.ticketThumbnail(),
                          placeholder: (
                            _,
                            __,
                          ) =>
                              ImagePlaceholder.ticketThumbnail(),
                        ),
                      )
                    : ThemeSvgIcon(
                        color: colorScheme.onSecondary,
                        builder: (filter) =>
                            Assets.icons.icCash.svg(colorFilter: filter),
                      ),
              ),
            ),
            SizedBox(width: Spacing.small),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isERC20
                        ? erc20DisplayedAmount ?? ''
                        : formatter.format(doubleAmount),
                    style: Typo.small.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.w),
                  Text(
                    chain != null
                        ? chain.name ?? ''
                        : t.event.ticketTierSetting.creditDebit,
                    style: Typo.small.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ],
              ),
            ),
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) =>
                  Assets.icons.icMoreHoriz.svg(colorFilter: filter),
            ),
          ],
        );
      },
    );
  }
}
