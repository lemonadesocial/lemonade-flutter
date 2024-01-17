import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/bottomsheet/lemon_snap_bottom_sheet_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';

class TicketTierFeatureDropdown<T> extends StatelessWidget {
  final T? value;
  final String Function(T? value)? getDisplayValue;
  final Widget Function(T? value)? leadingBuilder;
  final String? placeholder;
  final Function()? onTap;

  const TicketTierFeatureDropdown({
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
                child: Text(
                  placeholder ?? '',
                  style: Typo.mediumPlus.copyWith(
                    color: colorScheme.outlineVariant,
                  ),
                ),
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

class TicketTierFeatureDropdownList<T, V> extends StatefulWidget {
  final List<T> data;
  final String Function(T item) getDisplayLabel;
  final V Function(T item) getValue;
  final String? title;
  final V? value;
  final Function(T? item)? onConfirm;

  const TicketTierFeatureDropdownList({
    super.key,
    this.value,
    required this.data,
    this.onConfirm,
    required this.getDisplayLabel,
    required this.getValue,
    this.title,
  });

  @override
  State<TicketTierFeatureDropdownList<T, V>> createState() =>
      TicketTierFeatureDropdownListState<T, V>();
}

class TicketTierFeatureDropdownListState<T, V>
    extends State<TicketTierFeatureDropdownList<T, V>> {
  V? value;

  @override
  void initState() {
    super.initState();
    setState(() {
      value = widget.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return LemonSnapBottomSheet(
      defaultSnapSize: 1,
      backgroundColor: LemonColor.atomicBlack,
      builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            LemonAppBar(
              title: widget.title ?? '',
              backgroundColor: LemonColor.atomicBlack,
            ),
            SizedBox(
              height: 0.69.sh,
              child: CustomScrollView(
                slivers: [
                  SliverList.builder(
                    itemCount: widget.data.length,
                    itemBuilder: (context, index) {
                      final item = widget.data[index];
                      final itemValue = widget.getValue(item);
                      final selected = itemValue == value;
                      return InkWell(
                        onTap: () {
                          setState(() {
                            value = itemValue;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Spacing.smMedium,
                            vertical: Spacing.extraSmall,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.getDisplayLabel(widget.data[index]),
                                  style: Typo.mediumPlus,
                                ),
                              ),
                              if (!selected) Assets.icons.icUncheck.svg(),
                              if (selected) Assets.icons.icChecked.svg(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
      footerBuilder: () => Container(
        color: LemonColor.atomicBlack,
        padding: EdgeInsets.all(Spacing.smMedium),
        child: SafeArea(
          child: LinearGradientButton(
            onTap: () {
              widget.onConfirm?.call(
                widget.data
                    .firstWhereOrNull((item) => widget.getValue(item) == value),
              );
            },
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
