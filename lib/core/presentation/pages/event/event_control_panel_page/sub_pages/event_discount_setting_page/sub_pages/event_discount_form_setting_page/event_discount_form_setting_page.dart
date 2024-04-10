import 'package:app/core/domain/event/entities/event_payment_ticket_discount.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_discount_setting_page/sub_pages/event_discount_form_setting_page/widgets/discount_limit_setting_form.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_discount_setting_page/sub_pages/event_discount_form_setting_page/widgets/discount_percentage_picker.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/utils/text_formatter/upper_case_text_formatter.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@RoutePage()
class EventDiscountFormSettingPage extends StatelessWidget {
  final EventPaymentTicketDiscount? discount;
  const EventDiscountFormSettingPage({
    super.key,
    this.discount,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: LemonAppBar(
        title: t.event.eventPromotions.newPromotion,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: LemonTextField(
                    inputFormatters: [
                      // allow alphabet and numeric
                      FilteringTextInputFormatter.deny(RegExp(r'[^a-zA-Z0-9]')),
                      UpperCaseTextFormatter(),
                    ],
                    hintText: t.event.eventPromotions.accessCode,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Spacing.large,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: DiscountPercentagePicker(),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Spacing.large,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: DiscountLimitSettingForm(),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(Spacing.smMedium),
              decoration: BoxDecoration(
                color: colorScheme.background,
                border: Border(
                  top: BorderSide(color: colorScheme.outline),
                ),
              ),
              child: SafeArea(
                child: LinearGradientButton.primaryButton(
                  label: t.common.actions.add,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
