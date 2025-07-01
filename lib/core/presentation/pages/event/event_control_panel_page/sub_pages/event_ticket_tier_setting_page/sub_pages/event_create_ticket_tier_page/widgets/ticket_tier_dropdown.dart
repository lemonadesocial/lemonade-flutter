import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

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
    final appColors = context.theme.appColors;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LemonRadius.small),
          color: appColors.cardBg,
        ),
        height: 56.w,
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
                  style: Typo.medium.copyWith(
                    color: appColors.textTertiary,
                  ),
                ),
              ),
            if (value != null)
              Expanded(
                child: Text(
                  getDisplayValue?.call(value) ?? '',
                  style: Typo.mediumPlus.copyWith(
                    color: appColors.textPrimary,
                  ),
                ),
              ),
            Assets.icons.icDoubleArrowUpDown.svg(
              color: appColors.textTertiary,
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
  final AutoScrollController _scrollController = AutoScrollController();

  V? value;

  @override
  void initState() {
    super.initState();
    setState(() {
      value = widget.value;
    });
    _scrollToDefaultItem();
  }

  @override
  dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToDefaultItem() {
    final targetIndex = widget.data
        .indexWhere((element) => widget.getValue(element) == widget.value);
    if (targetIndex < 0) {
      return;
    }
    _scrollController.scrollToIndex(
      targetIndex,
      preferPosition: AutoScrollPosition.middle,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;
    return Container(
      color: appColors.pageBg,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          LemonAppBar(
            title: widget.title ?? '',
            backgroundColor: appColors.pageBg,
          ),
          if (widget.data.isEmpty)
            const Expanded(
              child: EmptyList(),
            ),
          if (widget.data.isNotEmpty)
            Flexible(
              flex: 1,
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverList.builder(
                    itemCount: widget.data.length,
                    itemBuilder: (context, index) {
                      final item = widget.data[index];
                      final itemValue = widget.getValue(item);
                      final selected = itemValue == value;
                      return AutoScrollTag(
                        key: ValueKey(itemValue),
                        controller: _scrollController,
                        index: index,
                        child: InkWell(
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
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          Container(
            color: appColors.pageBg,
            padding: EdgeInsets.all(Spacing.smMedium),
            child: SafeArea(
              child: LinearGradientButton.primaryButton(
                label: t.common.confirm,
                onTap: () {
                  widget.onConfirm?.call(
                    widget.data.firstWhereOrNull(
                      (item) => widget.getValue(item) == value,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
