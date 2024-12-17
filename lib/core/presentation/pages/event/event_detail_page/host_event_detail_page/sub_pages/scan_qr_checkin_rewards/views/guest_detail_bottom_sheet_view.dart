import 'package:app/core/application/event_tickets/get_ticket_bloc/get_ticket_bloc.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/scan_qr_checkin_rewards/views/guest_detail_information_view.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/scan_qr_checkin_rewards/views/widgets/scan_qr_ticket_information_item.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/graphql/backend/event/mutation/update_event_checkin.graphql.dart';
import 'package:app/graphql/backend/event/query/get_event_application_answers.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestDetailBottomSheetView extends StatelessWidget {
  const GuestDetailBottomSheetView({
    super.key,
    required this.shortId,
    required this.eventId,
  });

  final String shortId;
  final String eventId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetTicketBloc()
        ..add(GetTicketEventFetch(shortId: shortId, showLoading: true)),
      child: _GuestDetailBottomSheetView(eventId: eventId),
    );
  }
}

class _GuestDetailBottomSheetView extends StatelessWidget {
  const _GuestDetailBottomSheetView({required this.eventId});

  final String eventId;

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
                          Column(
                            children: [
                              _ViewApplicationInfoView(
                                ticket: ticket,
                                eventId: eventId,
                              ),
                              SizedBox(height: Spacing.smMedium),
                              SafeArea(
                                child: _ActionButton(ticket: ticket),
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

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.ticket});

  final EventTicket ticket;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bool allCheckedIn = ticket.checkin?.active == true &&
        (ticket.acquiredTickets?.every((t) => t.checkin?.active == true) ??
            true);
    if (allCheckedIn) {
      return Container(
        height: Sizing.large,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: LemonColor.white06,
            width: 1,
            style: BorderStyle.none,
          ),
        ),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          color: LemonColor.white06,
          child: Center(
            child: Text(
              t.event.scanQR.checkedInAll,
              style: Typo.medium.copyWith(
                color: colorScheme.onSecondary,
                // fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    }

    return LinearGradientButton.primaryButton(
      label: t.event.scanQR.checkInAll,
      onTap: () async {
        final response = await showFutureLoadingDialog(
          context: context,
          future: () {
            final shortIds = [
              ticket.shortId ?? '',
              ...(ticket.acquiredTickets ?? []).map((e) => e.shortId ?? ''),
            ];
            return getIt<AppGQL>().client.mutate$UpdateEventCheckins(
                  Options$Mutation$UpdateEventCheckins(
                    variables: Variables$Mutation$UpdateEventCheckins(
                      input: Input$UpdateEventCheckinInput(
                        active: true,
                        shortids: shortIds,
                      ),
                    ),
                  ),
                );
          },
        );
        if (response.result?.parsedData?.updateEventCheckins != null) {
          SnackBarUtils.showSuccess(
            message: t.event.scanQR.checkedInAllSuccessfully,
          );
          context.read<GetTicketBloc>().add(
                GetTicketEventFetch(
                  shortId: ticket.shortId ?? "",
                  showLoading: false,
                ),
              );
        }
      },
    );
  }
}

class _ViewApplicationInfoView extends StatelessWidget {
  const _ViewApplicationInfoView({required this.ticket, required this.eventId});

  final EventTicket ticket;
  final String eventId;

  @override
  Widget build(BuildContext context) {
    return Query$GetEventApplicationAnswers$Widget(
      options: Options$Query$GetEventApplicationAnswers(
        variables: Variables$Query$GetEventApplicationAnswers(
          event: eventId,
          user: ticket.assignedTo ?? '',
          email: ticket.assignedEmail ?? '',
        ),
      ),
      builder: (
        result, {
        refetch,
        fetchMore,
      }) {
        // print(result.parsedData?.getEventApplicationAnswers?.map((e) => e.toJson()).toList());
        print(result.parsedData?.getEventApplicationAnswers.length);
        return const SizedBox.shrink();
      },
    );
  }
}
