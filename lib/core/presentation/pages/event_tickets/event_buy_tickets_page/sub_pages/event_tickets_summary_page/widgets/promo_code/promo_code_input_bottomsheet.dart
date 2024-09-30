import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/utils/text_formatter/upper_case_text_formatter.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class PromoCodeInputBottomsheet extends StatefulWidget {
  final Function({
    String? promoCode,
  })? onPressApply;

  const PromoCodeInputBottomsheet({
    super.key,
    this.onPressApply,
  });

  @override
  State<PromoCodeInputBottomsheet> createState() =>
      _PromoCodeInputBottomsheetState();
}

class _PromoCodeInputBottomsheetState extends State<PromoCodeInputBottomsheet> {
  final promoTextController = TextEditingController();
  bool isValid = false;
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
          left: Spacing.small,
          right: Spacing.small,
          bottom: MediaQuery.of(context).viewInsets.bottom != 0
              ? MediaQuery.of(context).viewInsets.bottom + Spacing.smMedium
              : 0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const BottomSheetGrabber(),
            SizedBox(height: Spacing.medium),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  t.event.eventBuyTickets.discount,
                  style: Typo.large.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: Spacing.superExtraSmall),
                Text(
                  t.event.eventBuyTickets.discountDescription,
                  style: Typo.medium.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: Spacing.medium),
                SizedBox(
                  height: Sizing.xLarge,
                  child: LemonTextField(
                    filled: true,
                    fillColor: LemonColor.chineseBlack,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    controller: promoTextController,
                    hintText: t.event.eventBuyTickets.enterPromoCode,
                    onChange: (v) {
                      setState(() {
                        isValid = v.isNotEmpty;
                      });
                    },
                  ),
                ),
                SizedBox(height: Spacing.medium),
                Opacity(
                  opacity: isValid ? 1 : 0.5,
                  child: LinearGradientButton.primaryButton(
                    radius: BorderRadius.circular(LemonRadius.small),
                    label: t.common.actions.apply,
                    onTap: () {
                      if (promoTextController.text.isEmpty) {
                        return;
                      }
                      widget.onPressApply
                          ?.call(promoCode: promoTextController.text);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
