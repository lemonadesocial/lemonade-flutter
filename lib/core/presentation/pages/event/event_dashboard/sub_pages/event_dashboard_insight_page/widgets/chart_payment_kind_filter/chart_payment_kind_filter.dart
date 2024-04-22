import 'package:app/core/domain/cubejs/cubejs_enums.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChartPaymentKindFilter extends StatelessWidget {
  final CubePaymentKind? selectedKind;
  final Function(CubePaymentKind? kind)? onSelect;

  const ChartPaymentKindFilter({
    super.key,
    this.onSelect,
    this.selectedKind,
  });

  String get paymentKindTitle {
    return selectedKind?.name ?? t.event.eventDashboard.insights.paymentKind;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          value: selectedKind,
          onChanged: (value) {
            onSelect?.call(value);
          },
          customButton: LemonOutlineButton(
            key: Key(selectedKind?.name ?? ''),
            backgroundColor: colorScheme.secondaryContainer,
            borderColor: Colors.transparent,
            radius: BorderRadius.circular(LemonRadius.normal),
            textStyle: Typo.small.copyWith(
              color: colorScheme.onSecondary,
            ),
            label: paymentKindTitle,
            trailing: ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icArrowDown.svg(
                width: Sizing.xSmall,
                height: Sizing.xSmall,
                colorFilter: filter,
              ),
            ),
          ),
          items: [
            ...CubePaymentKind.values.map(
              (kind) => DropdownMenuItem(
                value: kind,
                child: _PaymentKindItem(
                  kind: kind,
                ),
              ),
            ),
          ],
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.small),
              color: colorScheme.secondaryContainer,
            ),
            offset: Offset(0, -Spacing.superExtraSmall),
            maxHeight: 200.w,
            width: 242.w,
          ),
          menuItemStyleData: const MenuItemStyleData(
            overlayColor: MaterialStatePropertyAll(LemonColor.darkBackground),
          ),
        ),
      ),
    );
  }
}

class _PaymentKindItem extends StatelessWidget {
  final CubePaymentKind? kind;
  const _PaymentKindItem({
    required this.kind,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isPlaceholder = kind == null;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            isPlaceholder
                ? t.event.ticketTierSetting.categorySetting.selectCategory
                : kind?.name ?? '',
            style: Typo.mediumPlus.copyWith(
              color: isPlaceholder
                  ? colorScheme.onSecondary
                  : colorScheme.onSecondary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
