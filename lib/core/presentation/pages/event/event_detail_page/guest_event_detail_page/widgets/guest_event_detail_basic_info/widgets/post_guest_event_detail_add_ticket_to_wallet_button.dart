import 'dart:io';

import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/input/get_tickets_input/get_tickets_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/service/event_pass_service/event_pass_service.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';
import 'package:app/app_theme/app_theme.dart';

class PostGuestEventDetailAddTicketToWalletButton extends StatelessWidget {
  final Event event;
  const PostGuestEventDetailAddTicketToWalletButton({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;

    return InkWell(
      onTap: () {
        final userId = AuthUtils.getUserId(context);
        showFutureLoadingDialog(
          context: context,
          future: () async {
            final response = await getIt<EventTicketRepository>().getTickets(
              input: GetTicketsInput(
                event: event.id,
                user: userId,
              ),
            );
            await response.fold((l) => null, (tickets) async {
              final myTicket = tickets.firstWhereOrNull(
                (ticket) => EventTicketUtils.isTicketAssignedToMe(
                  ticket,
                  userId: userId,
                ),
              );
              final eventPassService = EventPassService();
              if (Platform.isAndroid) {
                await eventPassService.generateGooglePassKit(
                  ticketId: myTicket?.id ?? '',
                );
              } else {
                await eventPassService.generateApplePassKit(
                  ticketId: myTicket?.id ?? '',
                );
              }
            });
          },
        );
      },
      child: Container(
        width: Sizing.medium,
        height: Sizing.medium,
        decoration: BoxDecoration(
          color: appColors.cardBg,
          borderRadius: BorderRadius.circular(Sizing.medium),
          border: Border.all(
            color: appColors.cardBorder,
            width: 1.w,
          ),
        ),
        child: Center(
          child: Assets.icons.icAppleWallet.svg(
            width: 12.w,
            height: 12.w,
          ),
        ),
      ),
    );
  }
}
