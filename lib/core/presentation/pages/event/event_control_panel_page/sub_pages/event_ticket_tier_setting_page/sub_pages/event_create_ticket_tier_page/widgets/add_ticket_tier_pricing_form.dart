import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/bottomsheet/lemon_snap_bottom_sheet_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/utils/bottomsheet_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTicketTierPricingForm extends StatelessWidget {
  const AddTicketTierPricingForm({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return LemonSnapBottomSheet(
      defaultSnapSize: 1,
      backgroundColor: LemonColor.atomicBlack,
      resizeToAvoidBottomInset: false,
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LemonAppBar(
            title: "",
            backgroundColor: LemonColor.atomicBlack,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.event.ticketTierSetting.paymentMethod,
                  style: Typo.extraLarge.copyWith(
                    fontWeight: FontWeight.w800,
                    fontFamily: FontFamily.nohemiVariable,
                  ),
                ),
                SizedBox(height: 2.w),
                Text(
                  t.event.ticketTierSetting.howUserPay,
                  style: Typo.mediumPlus.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: Spacing.large),
                Row(
                  children: [
                    Expanded(
                      child: _PricingMethodItem(
                        selected: true,
                        label: t.event.ticketTierSetting.creditDebit,
                        leadingBuilder: (color) =>
                            Assets.icons.icCreditCard.svg(
                          height: Sizing.xSmall,
                          width: Sizing.xSmall,
                          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    SizedBox(width: Spacing.xSmall),
                    Expanded(
                      child: _PricingMethodItem(
                        selected: false,
                        label: t.event.ticketTierSetting.erc20,
                        leadingBuilder: (color) => Assets.icons.icToken.svg(
                          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ],
                ),
                // TODO: switching between these two
                SizedBox(height: Spacing.large),
                const FiatPricingMethod(),
                // SizedBox(height: Spacing.large),
                // const ERC20PricingMethod(),
              ],
            ),
          ),
        ],
      ),
      footerBuilder: (context) => Container(
        color: LemonColor.atomicBlack,
        padding: EdgeInsets.all(Spacing.smMedium),
        child: SafeArea(
          child: LinearGradientButton(
            onTap: () {},
            height: 42.w,
            radius: BorderRadius.circular(LemonRadius.small * 2),
            mode: GradientButtonMode.lavenderMode,
            label: t.common.confirm,
            textStyle: Typo.medium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class FiatPricingMethod extends StatelessWidget {
  const FiatPricingMethod({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.event.ticketTierSetting.whatTicketPrice),
        SizedBox(height: Spacing.xSmall),
        Row(
          children: [
            Expanded(
              child: _Dropdown(
                onTap: () => BottomSheetUtils.showSnapBottomSheet(
                  context,
                  builder: (context) => _DropdownList<String, String>(
                    data: const ["Solana", "Near", "Ethereum"],
                    getDisplayLabel: (v) => v,
                    getValue: (v) => v,
                  ),
                ),
              ),
            ),
            SizedBox(width: Spacing.xSmall),
            const Expanded(
              child: LemonTextField(
                textInputType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ERC20PricingMethod extends StatelessWidget {
  const ERC20PricingMethod({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.event.ticketTierSetting.whatTicketTokenPrice),
        SizedBox(height: Spacing.xSmall),
        const _Dropdown(),
        SizedBox(height: Spacing.xSmall),
        Row(
          children: [
            const Expanded(
              child: _Dropdown(),
            ),
            SizedBox(width: Spacing.xSmall),
            const Expanded(
              child: LemonTextField(
                textInputType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Dropdown<T> extends StatelessWidget {
  final T? value;
  final String Function(T? value)? getDisplayValue;
  final Widget Function(T? value)? leadingBuilder;
  final String? placeholder;
  final Function()? onTap;

  const _Dropdown({
    super.key,
    this.value,
    this.getDisplayValue,
    this.leadingBuilder,
    this.placeholder,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Spacing.smMedium),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LemonRadius.small),
          color: colorScheme.onPrimary.withOpacity(0.06),
        ),
        height: Sizing.xLarge,
        child: Row(
          children: [
            if (leadingBuilder != null) ...[
              leadingBuilder!.call(value),
              SizedBox(width: Spacing.xSmall),
            ],
            if (value == null)
              Expanded(
                child: Text(placeholder ?? '', style: Typo.mediumPlus),
              ),
            if (value != null)
              Expanded(
                child: Text(
                  getDisplayValue?.call(value) ?? '',
                  style: Typo.mediumPlus,
                ),
              ),
            Assets.icons.icArrowDown.svg(
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

class _PricingMethodItem extends StatelessWidget {
  final String label;
  final bool selected;
  final Widget Function(Color color)? leadingBuilder;

  const _PricingMethodItem({
    required this.label,
    required this.selected,
    this.leadingBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: Sizing.xLarge,
      decoration: BoxDecoration(
        border: Border.all(
          width: selected ? 2.w : 1.w,
          color:
              selected ? LemonColor.paleViolet : colorScheme.onSurfaceVariant,
        ),
        borderRadius: BorderRadius.circular(LemonRadius.small),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leadingBuilder != null) ...[
            leadingBuilder!.call(
              selected ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
            ),
            SizedBox(width: Spacing.xSmall),
          ],
          Text(
            label,
            style: Typo.medium.copyWith(
              fontWeight: FontWeight.w600,
              color: selected
                  ? colorScheme.onPrimary
                  : colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _DropdownList<T, V> extends StatelessWidget {
  final List<T> data;
  final String Function(T item) getDisplayLabel;
  final V Function(T item) getValue;
  final String? title;

  const _DropdownList({
    super.key,
    required this.data,
    required this.getDisplayLabel,
    required this.getValue,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return LemonSnapBottomSheet(
      defaultSnapSize: 1,
      backgroundColor: LemonColor.atomicBlack,
      builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            LemonAppBar(
              title: title ?? '',
              backgroundColor: LemonColor.atomicBlack,
            ),
            SizedBox(
              height: 0.69.sh,
              child: CustomScrollView(
                // controller: controller,
                slivers: [
                  SliverList.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Spacing.smMedium,
                        vertical: Spacing.extraSmall,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              getDisplayLabel(data[index]),
                              style: Typo.mediumPlus,
                            ),
                          ),
                          Assets.icons.icUncheck.svg(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      footerBuilder: (context) => Container(
        color: LemonColor.atomicBlack,
        padding: EdgeInsets.all(Spacing.smMedium),
        child: SafeArea(
          child: LinearGradientButton(
            onTap: () {},
            height: 42.w,
            radius: BorderRadius.circular(LemonRadius.small * 2),
            mode: GradientButtonMode.lavenderMode,
            label: t.common.confirm,
            textStyle: Typo.medium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
