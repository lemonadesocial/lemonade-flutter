import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/common/bottomsheet/lemon_snap_bottom_sheet_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class AddCardBottomSheet extends StatelessWidget {
  AddCardBottomSheet({super.key});
  final DraggableScrollableController controller =
      DraggableScrollableController();
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return LemonSnapBottomSheet(
      controller: controller,
      resizeToAvoidBottomInset: false,
      backgroundColor: LemonColor.atomicBlack,
      snapSizes: const [0.5, 0.635, 1],
      defaultSnapSize: 0.635,
      minSnapSize: 0.5,
      builder: (scrollController) {
        return Focus(
          onFocusChange: (focused) {
            if (focused) {
              controller.animateTo(
                1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
              );
            } else {
              controller.animateTo(
                0.635,
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
              );
            }
          },
          child: SingleChildScrollView(
            controller: scrollController,
            child: Container(
              padding: EdgeInsets.only(
                left: Spacing.smMedium,
                right: Spacing.smMedium,
                top: Spacing.smMedium,
                bottom: Spacing.smMedium,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      LemonBackButton(
                        color: colorScheme.onSecondary,
                      ),
                    ],
                  ),
                  SizedBox(height: Spacing.medium),
                  Text(
                    t.event.eventPayment.addNewCard,
                    style: Typo.extraLarge.copyWith(
                      fontWeight: FontWeight.w800,
                      fontFamily: FontFamily.nohemiVariable,
                    ),
                  ),
                  SizedBox(height: Spacing.superExtraSmall),
                  Text(
                    t.event.eventPayment.addNewCardDescription,
                    style: Typo.mediumPlus.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height: Spacing.medium),
                  LemonTextField(
                    autofocus: true,
                    onChange: (v) {},
                    hintText: t.event.eventPayment.cardHolderName,
                  ),
                  SizedBox(height: Spacing.xSmall),
                  LemonTextField(
                    onChange: (v) {},
                    hintText: t.event.eventPayment.cardNumber,
                  ),
                  SizedBox(height: Spacing.xSmall),
                  Row(
                    children: [
                      Expanded(
                        child: LemonTextField(
                          onChange: (v) {},
                          hintText: t.event.eventPayment.validThrough,
                        ),
                      ),
                      SizedBox(width: Spacing.xSmall),
                      Expanded(
                        child: LemonTextField(
                          onChange: (v) {},
                          hintText: t.event.eventPayment.cvc,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: Spacing.smMedium * 2),
                  SizedBox(
                    height: Sizing.large,
                    child: LinearGradientButton(
                      radius: BorderRadius.circular(LemonRadius.small * 2),
                      mode: GradientButtonMode.lavenderMode,
                      label: t.event.eventPayment.addCard,
                    ),
                  ),
                  SizedBox(height: Spacing.smMedium),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
