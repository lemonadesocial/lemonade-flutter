import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/service/event_pass_service/event_pass_service.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTicketToAppleWalletButton extends StatelessWidget {
  const AddTicketToAppleWalletButton({super.key, required this.ticket});
  final EventTicket? ticket;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return InkWell(
      onTap: () {
        showFutureLoadingDialog(
          context: context,
          future: () async {
            await EventPassService().generateApplePassKit(
              ticketId: ticket?.id ?? '',
            );
          },
        );
      },
      child: Container(
        height: 54.w,
        decoration: BoxDecoration(
          border: Border.all(color: colorScheme.onPrimary, width: 1.w),
          borderRadius: BorderRadius.circular(LemonRadius.small),
          color: colorScheme.background,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Assets.icons.icAppleWallet.svg(
              width: 40.w,
              height: 30.w,
            ),
            SizedBox(width: Spacing.superExtraSmall),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.common.addTo,
                  style: Typo.small.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
                Text(
                  t.common.appleWallet,
                  style: Typo.small.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w700,
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
