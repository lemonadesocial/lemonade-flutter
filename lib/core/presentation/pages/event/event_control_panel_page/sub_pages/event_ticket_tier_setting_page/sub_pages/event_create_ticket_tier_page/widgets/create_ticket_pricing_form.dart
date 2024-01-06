import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_pricing_item.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CreateTicketPricingForm extends StatelessWidget {
  const CreateTicketPricingForm({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.event.ticketTierSetting.pricingAndPaymentMethods,
                style: Typo.medium.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: Spacing.xSmall),
              Row(
                children: [
                  Expanded(
                    child: PricingOptionItem(
                      label: t.event.ticketTierSetting.free,
                      selected: false,
                    ),
                  ),
                  SizedBox(width: Spacing.xSmall),
                  Expanded(
                    child: PricingOptionItem(
                      label: t.event.ticketTierSetting.paid,
                      selected: true,
                      leadingBuilder: (color) => ThemeSvgIcon(
                        color: color,
                        builder: (filter) => Assets.icons.icCash.svg(
                          colorFilter: filter,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Spacing.smMedium),
              const _AddPaymentMethodButton(),
            ],
          ),
        ),
        SizedBox(height: Spacing.smMedium),
        SliverList.separated(
          itemCount: 3,
          itemBuilder: (context, index) => const TicketTierPricingItem(),
          separatorBuilder: (context, index) =>
              SizedBox(height: Spacing.smMedium),
        ),
      ],
    );
  }
}

class _AddPaymentMethodButton extends StatelessWidget {
  const _AddPaymentMethodButton();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return DottedBorder(
      dashPattern: [5.w],
      color: colorScheme.outline,
      borderType: BorderType.RRect,
      padding: EdgeInsets.all(Spacing.small),
      radius: Radius.circular(LemonRadius.xSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icAdd.svg(
              colorFilter: filter,
            ),
          ),
          SizedBox(width: Spacing.extraSmall),
          Text(
            t.event.ticketTierSetting.addPaymentMethod,
            style: Typo.medium.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class PricingOptionItem extends StatelessWidget {
  final String label;
  final bool selected;
  final Widget Function(Color color)? leadingBuilder;

  const PricingOptionItem({
    super.key,
    required this.label,
    required this.selected,
    this.leadingBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: Sizing.large,
      decoration: BoxDecoration(
        color: selected ? LemonColor.paleViolet18 : LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(LemonRadius.small),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leadingBuilder != null) ...[
            leadingBuilder!.call(
              selected ? LemonColor.paleViolet : colorScheme.onSurfaceVariant,
            ),
            SizedBox(width: Spacing.xSmall),
          ],
          Text(
            label,
            style: Typo.mediumPlus.copyWith(
              color: selected
                  ? LemonColor.paleViolet
                  : colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
