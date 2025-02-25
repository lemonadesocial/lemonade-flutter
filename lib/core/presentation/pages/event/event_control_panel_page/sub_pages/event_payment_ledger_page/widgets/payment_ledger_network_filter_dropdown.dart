import 'package:app/core/domain/payment/entities/event_payment_statistics/event_payment_statistics.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/web3/chain/chain_query_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/payment/query/list_event_payments.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';

class PaymentLedgerNetworkFilterDropdown extends StatefulWidget {
  final EventPaymentStatistics? statistics;
  final Variables$Query$ListEventPayments filterVariables;
  final Function(Variables$Query$ListEventPayments) onChanged;

  const PaymentLedgerNetworkFilterDropdown({
    super.key,
    this.statistics,
    required this.filterVariables,
    required this.onChanged,
  });

  @override
  State<PaymentLedgerNetworkFilterDropdown> createState() =>
      _PaymentLedgerNetworkFilterDropdownState();
}

class _PaymentLedgerNetworkFilterDropdownState
    extends State<PaymentLedgerNetworkFilterDropdown> {
  void onSelectAllNetworks() {
    widget.onChanged(
      widget.filterVariables.copyWith(
        networks: null,
        provider: null,
      ),
    );
  }

  void onStripeSelected(bool isSelected) {
    widget.onChanged(
      widget.filterVariables.copyWith(
        provider: isSelected ? Enum$NewPaymentProvider.stripe : null,
      ),
    );
  }

  void onNetworkSelected(String chainId, bool isSelected) {
    final currentNetworks = widget.filterVariables.networks ?? [];
    final updatedNetworks = isSelected
        ? [...currentNetworks, chainId]
        : currentNetworks.where((e) => e != chainId).toList();

    widget.onChanged(
      widget.filterVariables.copyWith(
        networks: updatedNetworks.isEmpty ? null : updatedNetworks,
      ),
    );
  }

  String get displayedText {
    final t = Translations.of(context);
    if (widget.filterVariables.networks == null &&
        widget.filterVariables.provider == null) {
      return t.event.eventPaymentLedger.allNetworks;
    }
    var count = 0;
    if (widget.filterVariables.networks != null) {
      count += widget.filterVariables.networks?.length ?? 0;
    }
    if (widget.filterVariables.provider == Enum$NewPaymentProvider.stripe) {
      count += 1;
    }
    return t.event.eventPaymentLedger.countSelected(count: count);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PopupMenuButton<void>(
      constraints: BoxConstraints(
        maxWidth: 244.w,
      ),
      offset: Offset(0, Spacing.superExtraSmall),
      color: LemonColor.atomicBlack,
      padding: EdgeInsets.zero,
      elevation: 0,
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LemonRadius.normal),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      clipBehavior: Clip.none,
      child: LemonOutlineButton(
        label: displayedText,
        textColor: colorScheme.onPrimary,
        backgroundColor: LemonColor.chineseBlack,
        borderColor: LemonColor.chineseBlack,
        radius: BorderRadius.circular(LemonRadius.button),
        trailing: ThemeSvgIcon(
          color: colorScheme.onSecondary,
          builder: (filter) => Assets.icons.icDoubleArrowUpDown.svg(
            colorFilter: filter,
          ),
        ),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                decoration: BoxDecoration(
                  color: LemonColor.atomicBlack,
                  borderRadius: BorderRadius.circular(LemonRadius.normal),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _AllNetworkItem(
                      isSelected: widget.filterVariables.networks == null &&
                          widget.filterVariables.provider == null,
                      count: widget.statistics?.totalPayments ?? 0,
                      onTap: () {
                        onSelectAllNetworks();
                        setState(() {});
                      },
                    ),
                    Divider(
                      color: colorScheme.outlineVariant,
                      height: 1.w,
                    ),
                    _StripeFilterItem(
                      count: widget.statistics?.stripePayments?.count ?? 0,
                      isSelected: widget.filterVariables.provider ==
                          Enum$NewPaymentProvider.stripe,
                      onChange: (isSelected) {
                        onStripeSelected(isSelected);
                        setState(() {});
                      },
                    ),
                    ...(widget.statistics?.cryptoPayments?.networks ?? [])
                        .map((networkStatistic) {
                      return _NetworkFilterItem(
                        count: networkStatistic.count ?? 0,
                        chainId: networkStatistic.chainId ?? '',
                        isSelected: widget.filterVariables.networks
                                ?.contains(networkStatistic.chainId) ??
                            false,
                        onChange: (isSelected) {
                          onNetworkSelected(
                            networkStatistic.chainId ?? '',
                            isSelected,
                          );
                          setState(() {});
                        },
                      );
                    }),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _AllNetworkItem extends StatelessWidget {
  final int count;
  final Function() onTap;
  final bool isSelected;
  const _AllNetworkItem({
    required this.count,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.smMedium,
          vertical: Spacing.xSmall,
        ),
        child: Row(
          children: [
            Assets.icons.icCircleFourBold.svg(
              width: Sizing.small,
              height: Sizing.small,
            ),
            SizedBox(width: Spacing.small),
            Expanded(
              child: Text(
                "${t.event.eventPaymentLedger.allNetworks} ($count)",
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
            if (isSelected)
              ThemeSvgIcon(
                color: colorScheme.onPrimary,
                builder: (filter) => Assets.icons.icDone.svg(
                  colorFilter: filter,
                  width: Sizing.xSmall,
                  height: Sizing.xSmall,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StripeFilterItem extends StatelessWidget {
  final int count;
  final Function(bool) onChange;
  final bool isSelected;
  const _StripeFilterItem({
    required this.count,
    required this.onChange,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        onChange(!isSelected);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.smMedium,
          vertical: Spacing.xSmall,
        ),
        child: Row(
          children: [
            Assets.icons.icStripeCircle.svg(
              width: Sizing.xSmall,
              height: Sizing.xSmall,
            ),
            SizedBox(width: Spacing.small),
            Expanded(
              child: Text(
                "${t.event.eventPaymentLedger.stripe} ($count)",
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
            SizedBox(
              width: 18.w,
              height: 18.w,
              child: Checkbox(
                value: isSelected,
                onChanged: (value) {
                  onChange(value ?? false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NetworkFilterItem extends StatelessWidget {
  final int count;
  final String chainId;
  final Function(bool) onChange;
  final bool isSelected;
  const _NetworkFilterItem({
    required this.count,
    required this.chainId,
    required this.onChange,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        onChange(!isSelected);
      },
      child: ChainQuery(
        chainId: chainId,
        builder: (
          chain, {
          required bool isLoading,
        }) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.smMedium,
              vertical: Spacing.xSmall,
            ),
            child: Row(
              children: [
                LemonNetworkImage(
                  imageUrl: chain?.logoUrl ?? '',
                  width: Sizing.xSmall,
                  height: Sizing.xSmall,
                ),
                SizedBox(width: Spacing.small),
                Expanded(
                  child: Text(
                    "${chain?.name} ($count)",
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
                SizedBox(
                  width: 18.w,
                  height: 18.w,
                  child: Checkbox(
                    value: isSelected,
                    onChanged: (value) {
                      onChange(value ?? false);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
