import 'package:app/core/application/event_tickets/get_ticket_bloc/get_ticket_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/guest_application_page/guest_application_info_page.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/scan_qr_checkin_rewards/views/guest_detail_information_view.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/scan_qr_checkin_rewards/views/widgets/scan_qr_ticket_action_button.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/scan_qr_checkin_rewards/views/widgets/scan_qr_ticket_information_item.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/event/query/get_event_application_answers.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class GuestDetailBottomSheetView extends StatelessWidget {
  const GuestDetailBottomSheetView({
    super.key,
    required this.shortId,
    this.event,
  });

  final String shortId;
  final Event? event;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetTicketBloc()
        ..add(GetTicketEventFetch(shortId: shortId, showLoading: true)),
      child: _GuestDetailBottomSheetView(event: event),
    );
  }
}

class _GuestDetailBottomSheetView extends StatelessWidget {
  const _GuestDetailBottomSheetView({required this.event});

  final Event? event;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: LemonColor.white06,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BottomSheetGrabber(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: Spacing.medium,
                bottom: Spacing.smMedium,
                left: Spacing.smMedium,
                right: Spacing.smMedium,
              ),
              child: BlocBuilder<GetTicketBloc, GetTicketState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => SizedBox(
                      height: 300,
                      child: Loading.defaultLoading(context),
                    ),
                    success: (ticket) {
                      return Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  GuestDetailInformationView(
                                    ticket: ticket,
                                  ),
                                  SizedBox(height: Spacing.smMedium),
                                  ScanQrTicketInformationItem(
                                    originalTicket: ticket,
                                    ticket: ticket,
                                  ),
                                  if (ticket.acquiredTickets?.isNotEmpty ??
                                      false) ...[
                                    SizedBox(height: Spacing.smMedium),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: colorScheme.secondary,
                                        borderRadius: BorderRadius.circular(
                                          LemonRadius.normal,
                                        ),
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: Spacing.smMedium,
                                              vertical: Spacing.small,
                                            ),
                                            child: Text(
                                              '${t.event.scanQR.additionalTickets} (${ticket.acquiredTickets?.length ?? 0})',
                                              style: Typo.small.copyWith(
                                                color: colorScheme.onSecondary,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          ...ticket.acquiredTickets!.map(
                                            (acquiredTicket) => Container(
                                              decoration: BoxDecoration(
                                                color: colorScheme
                                                    .secondaryContainer,
                                              ),
                                              child:
                                                  ScanQrTicketInformationItem(
                                                originalTicket: ticket,
                                                ticket: acquiredTicket,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: Spacing.small),
                          Column(
                            children: [
                              _ViewApplicationInfoView(
                                ticket: ticket,
                                event: event,
                              ),
                              SizedBox(height: Spacing.smMedium),
                              SafeArea(
                                child: ScanQrTicketActionButton(
                                  ticket: ticket,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                    orElse: () => const SizedBox.shrink(),
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

class _ViewApplicationInfoView extends StatelessWidget {
  const _ViewApplicationInfoView({required this.ticket, required this.event});

  final EventTicket ticket;
  final Event? event;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (ticket.assignedTo == null && ticket.assignedEmail == null) {
      return const SizedBox.shrink();
    }
    return Query$GetEventApplicationAnswers$Widget(
      options: Options$Query$GetEventApplicationAnswers(
        variables: Variables$Query$GetEventApplicationAnswers(
          event: event?.id ?? '',
          user: ticket.assignedTo ?? '',
          email: ticket.assignedEmail ?? '',
        ),
      ),
      builder: (result, {refetch, fetchMore}) {
        final hasApplications =
            (result.parsedData?.getEventApplicationAnswers.length ?? 0) > 0;

        if (!hasApplications) return const SizedBox.shrink();

        return InkWell(
          onTap: () {
            showCupertinoModalBottomSheet(
              expand: true,
              useRootNavigator: true,
              backgroundColor: LemonColor.atomicBlack,
              context: context,
              builder: (context) => GuestApplicationInfoPage(
                event: event,
                eventTicket: ticket,
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.small,
              vertical: Spacing.small,
            ),
            decoration: BoxDecoration(
              color: colorScheme.secondary,
              borderRadius: BorderRadius.circular(LemonRadius.small),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.description_outlined,
                  color: colorScheme.onSecondary,
                  size: Sizing.xSmall,
                ),
                SizedBox(width: Spacing.small),
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        t.event.eventApproval.viewApplication,
                        style: Typo.medium.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(width: Spacing.small),
                      Container(
                        width: Sizing.mSmall,
                        height: Sizing.mSmall,
                        decoration: BoxDecoration(
                          color: LemonColor.white06,
                          borderRadius:
                              BorderRadius.circular(LemonRadius.extraSmall),
                        ),
                        child: Center(
                          child: Text(
                            '${result.parsedData?.getEventApplicationAnswers.length ?? 0}',
                            style: Typo.xSmall.copyWith(
                              color: colorScheme.onSecondary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ThemeSvgIcon(
                  color: colorScheme.onSurfaceVariant,
                  builder: (filter) => Assets.icons.icArrowRight.svg(
                    colorFilter: filter,
                    width: Sizing.mSmall,
                    height: Sizing.mSmall,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
