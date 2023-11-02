import 'package:app/core/application/event_tickets/assign_tickets_bloc/assign_tickets_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/event/input/assign_tickets_input/assign_tickets_input.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/dialog/lemon_alert_dialog.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/email_validator.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TicketAssignPopup extends StatelessWidget {
  final Event event;
  final EventTicket eventTicket;
  final PurchasableTicketType? ticketType;
  final Function()? onClose;
  final Function()? onAssignSuccess;

  const TicketAssignPopup({
    super.key,
    required this.event,
    required this.eventTicket,
    this.ticketType,
    this.onClose,
    this.onAssignSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssignTicketsBloc(event: event),
      child: TicketAssignPopupView(
        event: event,
        eventTicket: eventTicket,
        ticketType: ticketType,
        onClose: onClose,
        onAssignSuccess: onAssignSuccess,
      ),
    );
  }
}

class TicketAssignPopupView extends StatefulWidget {
  final Event event;
  final EventTicket eventTicket;
  final PurchasableTicketType? ticketType;
  final Function()? onClose;
  final Function()? onAssignSuccess;

  const TicketAssignPopupView({
    super.key,
    required this.event,
    required this.eventTicket,
    this.ticketType,
    this.onClose,
    this.onAssignSuccess,
  });

  @override
  State<TicketAssignPopupView> createState() => _TicketAssignPopupViewState();
}

class _TicketAssignPopupViewState extends State<TicketAssignPopupView> {
  String? email;

  bool get isValid => EmailValidator.validate(email ?? '');

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final assignTicketsBloc = context.watch<AssignTicketsBloc>();
    final isLoading = assignTicketsBloc.state is AssignTicketsStateLoading;

    return BlocListener<AssignTicketsBloc, AssignTicketsState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          failure: (message) {
            if (message == null) return;
            // TODO: snackbar
            showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) => LemonAlertDialog(
                child: Text(message),
              ),
            );
          },
          success: (success) {
            if (success) {
              widget.onAssignSuccess?.call();
              Navigator.of(context).pop();
            }
          },
        );
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LemonRadius.normal),
        ),
        backgroundColor: LemonColor.chineseBlack,
        insetPadding: EdgeInsets.only(
          left: Spacing.smMedium,
          right: Spacing.smMedium,
        ),
        child: SizedBox(
          child: Padding(
            padding: EdgeInsets.all(Spacing.medium),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${t.event.eventTicketManagement.assignTicket} ${t.event.tickets(n: 1)}',
                      style: Typo.extraMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: ThemeSvgIcon(
                        color: colorScheme.onPrimary.withOpacity(0.18),
                        builder: (filter) => Assets.icons.icClose.svg(
                          colorFilter: filter,
                          width: Sizing.small,
                          height: Sizing.small,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Spacing.smMedium),
                Container(
                  clipBehavior: Clip.hardEdge,
                  padding: EdgeInsets.all(Spacing.smMedium),
                  decoration: BoxDecoration(
                    color: colorScheme.onPrimary.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(LemonRadius.small),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(LemonRadius.small / 2),
                        child: CachedNetworkImage(
                          width: Sizing.medium,
                          height: Sizing.medium,
                          imageUrl: "",
                          placeholder: (context, url) =>
                              ImagePlaceholder.defaultPlaceholder(),
                          errorWidget: (context, url, err) =>
                              ImagePlaceholder.defaultPlaceholder(),
                        ),
                      ),
                      SizedBox(width: Spacing.xSmall),
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.ticketType?.title}   •   ${NumberUtils.formatCurrency(
                                amount:
                                    widget.ticketType?.price?.toDouble() ?? 0,
                                currency: Currency.currencyFromString(
                                  widget.ticketType?.priceCurrency,
                                ),
                                freeText: t.event.free,
                              )}",
                              style: Typo.medium.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 2.w,
                            ),
                            Text(
                              widget.event.title ?? '',
                              style: Typo.small.copyWith(
                                color: colorScheme.onSecondary,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: Spacing.xSmall),
                SizedBox(
                  height: Sizing.xLarge,
                  child: LemonTextField(
                    hintText: t.event.eventTicketManagement.ticketHolderEmail,
                    onChange: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: Spacing.medium),
                Opacity(
                  opacity: isLoading || !isValid ? 0.5 : 1,
                  child: SizedBox(
                    height: 42.w,
                    child: LinearGradientButton(
                      onTap: () {
                        if (!isValid) return;
                        assignTicketsBloc.add(
                          AssignTicketsEvent.assign(
                            assignees: [
                              TicketAssignee(
                                ticket: widget.eventTicket.id ?? '',
                                email: email,
                              )
                            ],
                          ),
                        );
                      },
                      mode: GradientButtonMode.lavenderMode,
                      radius: BorderRadius.circular(LemonRadius.xSmall),
                      label: isLoading
                          ? '${t.common.processing}...'
                          : t.event.eventTicketManagement.assignTicket,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
