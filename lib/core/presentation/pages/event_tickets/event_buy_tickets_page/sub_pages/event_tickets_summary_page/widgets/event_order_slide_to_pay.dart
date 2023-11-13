import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/presentation/widgets/common/slide_to_act/slide_to_act.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventOrderSlideToPay extends StatelessWidget {
  const EventOrderSlideToPay({
    super.key,
    required this.onSlideToPay,
    required this.slideActionKey,
    this.pricingInfo,
  });

  final Function() onSlideToPay;
  final EventTicketsPricingInfo? pricingInfo;
  final GlobalKey<SlideActionState> slideActionKey;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final amountText = NumberUtils.formatCurrency(
      amount: pricingInfo?.fiatTotal ?? 0,
      // TODO: need to use selected currency
      currency: Currency.USD,
    );

    return SizedBox(
      height: 60.w,
      child: SlideAction(
        key: slideActionKey,
        onSubmit: () async {
          onSlideToPay();
        },
        text: '${t.event.eventPayment.slideToPay} $amountText',
        textStyle: Typo.medium.copyWith(
          color: LemonColor.paleViolet,
          fontWeight: FontWeight.w600,
          fontFamily: FontFamily.nohemiVariable,
        ),
        outerColor: colorScheme.background,
        sliderButtonIcon: ThemeSvgIcon(
          color: colorScheme.primary.withOpacity(0.18),
          builder: (filter) => Assets.icons.icRoundDoubleArrow.svg(
            colorFilter: filter,
            width: Sizing.small,
            height: Sizing.small,
          ),
        ),
      ),
    );
  }
}
