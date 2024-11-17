import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/scan_qr_checkin_rewards/views/guest_detail_information_view.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/event/mutation/update_event_checkin.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class GuestDetailBottomSheetView extends StatelessWidget {
  const GuestDetailBottomSheetView({
    super.key,
    required this.ticket,
  });

  final EventTicket ticket;

  @override
  Widget build(BuildContext context) {
    final assignedToExpanded = ticket.assignedToExpanded;
    return Container(
      color: LemonColor.white06,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BottomSheetGrabber(),
          Padding(
            padding: EdgeInsets.only(
              top: Spacing.medium,
              bottom: Spacing.smMedium,
              left: Spacing.smMedium,
              right: Spacing.smMedium,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GuestDetailInformationView(user: assignedToExpanded),
                SizedBox(height: Spacing.medium),
                _TicketInformationView(ticket: ticket),
                SizedBox(height: Spacing.smMedium * 2),
                LinearGradientButton.primaryButton(
                  label: t.event.scanQR.checkInAll,
                  onTap: () async {
                    final response = await showFutureLoadingDialog(
                      context: context,
                      future: () => getIt<AppGQL>()
                          .client
                          .mutate$UpdateEventCheckin(
                            Options$Mutation$UpdateEventCheckin(
                              variables: Variables$Mutation$UpdateEventCheckin(
                                input: Input$UpdateEventCheckinInput(
                                  active: true,
                                  shortid: ticket.shortId,
                                ),
                              ),
                            ),
                          ),
                    );
                    if (response.result?.parsedData?.updateEventCheckin !=
                        null) {
                      SnackBarUtils.showSuccess(
                        message: t.event.scanQR.checkedinSuccessfully,
                      );
                      await AutoRouter.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TicketInformationView extends StatelessWidget {
  const _TicketInformationView({required this.ticket});

  final EventTicket ticket;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final ticketType = ticket.typeExpanded;
    final t = Translations.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.smMedium,
        vertical: Spacing.small,
      ),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(LemonRadius.small),
      ),
      child: Row(
        children: [
          ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icTicket.svg(
              width: Sizing.mSmall,
              height: Sizing.mSmall,
              colorFilter: filter,
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Expanded(
            child: Text(
              ticketType?.title ?? "",
              style: Typo.medium.copyWith(
                fontWeight: FontWeight.w500,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          InkWell(
            onTap: () async {
              final response = await showFutureLoadingDialog(
                context: context,
                future: () => getIt<AppGQL>().client.mutate$UpdateEventCheckin(
                      Options$Mutation$UpdateEventCheckin(
                        variables: Variables$Mutation$UpdateEventCheckin(
                          input: Input$UpdateEventCheckinInput(
                            active: true,
                            shortid: ticket.shortId,
                          ),
                        ),
                      ),
                    ),
              );
              if (response.result?.parsedData?.updateEventCheckin != null) {
                SnackBarUtils.showSuccess(
                  message: t.event.scanQR.checkedinSuccessfully,
                );
                await AutoRouter.of(context).pop();
              }
            },
            child: Container(
              padding: EdgeInsets.all(Spacing.xSmall),
              decoration: BoxDecoration(
                color: LemonColor.white06,
                borderRadius: BorderRadius.circular(LemonRadius.xSmall),
              ),
              child: Text(
                t.event.scanQR.checkin,
                style: Typo.small.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
