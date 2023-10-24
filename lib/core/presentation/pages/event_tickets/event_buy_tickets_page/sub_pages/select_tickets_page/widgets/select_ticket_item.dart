import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/event_tickets/select_event_tickets_bloc/select_event_tickets_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/input/calculate_tickets_pricing_input/calculate_tickets_pricing_input.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../gen/assets.gen.dart';
import '../../../../../../widgets/theme_svg_icon_widget.dart';

class SelectTicketItem extends StatefulWidget {
  const SelectTicketItem({
    super.key,
    required this.ticketType,
    required this.event,
  });

  final PurchasableTicketType ticketType;
  final Event event;

  @override
  State<SelectTicketItem> createState() => _SelectTicketItemState();
}

class _SelectTicketItemState extends State<SelectTicketItem> {
  double count = 0;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.ticketType.cost == 0) {
        add();
      }
    });
  }

  add() {
    if (count < (widget.ticketType.limit ?? 0)) {
      setState(() {
        count++;
      });
      context.read<SelectEventTicketTypesBloc>().add(
            SelectEventTicketTypesEvent.select(
              ticketType: PurchasableItem(
                id: widget.ticketType.id ?? '',
                count: count,
              ),
            ),
          );
    }
  }

  minus() {
    if (count == 0) return;
    setState(() {
      count--;
    });
    context.read<SelectEventTicketTypesBloc>().add(
          SelectEventTicketTypesEvent.select(
            ticketType: PurchasableItem(
              id: widget.ticketType.id ?? '',
              count: count,
            ),
          ),
        );
  }

  void goToWeb() {
    final event = context.read<EventProviderBloc>().event;
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (innerContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LemonRadius.small),
        ),
        actionsPadding: EdgeInsets.only(
          left: Spacing.smMedium,
          right: Spacing.smMedium,
          bottom: Spacing.smMedium,
          // vertical: Spacing.smMedium,
        ),
        backgroundColor: LemonColor.atomicBlack,
        content:
            const Text("Paid ticket not supported yet\nPlease use our website"),
        actions: [
          LinearGradientButton(
            onTap: () async {
              Navigator.of(innerContext).pop();
              // await Future.delayed(
              //   const Duration(milliseconds: 300),
              // );
              // AutoRouter.of(context).replaceAll([
              //   EventDetailRoute(
              //     eventId: event.id ?? '',
              //     eventName: event.title ?? '',
              //   ),
              // ]);
            },
            mode: GradientButtonMode.lavenderMode,
            label: t.common.actions.ok,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final costText = NumberUtils.formatCurrency(
      amount: (widget.ticketType.cost?.toDouble() ?? 0),
      currency: widget.event.currency,
      freeText: t.event.free,
    );
    return Padding(
      padding: EdgeInsets.all(Spacing.smMedium),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image
          Container(
            width: Sizing.medium,
            height: Sizing.medium,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
              child: CachedNetworkImage(
                // TODO: api does not support yet
                imageUrl: "",
                placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
                errorWidget: (_, __, ___) =>
                    ImagePlaceholder.defaultPlaceholder(),
              ),
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          // ticket type name and description
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${widget.ticketType.title}  •  $costText",
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary.withOpacity(0.87),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (widget.ticketType.description != null &&
                    widget.ticketType.description!.isNotEmpty) ...[
                  SizedBox(height: 2.w),
                  Text(
                    widget.ticketType.description ?? '',
                    style: Typo.medium.copyWith(
                      color: colorScheme.onSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  )
                ]
              ],
            ),
          ),
          // quantity selection
          InkWell(
            child: Container(
              // TODO:
              // width: 70.w,
              width: 120.w,
              height: Sizing.medium,
              decoration: BoxDecoration(
                color: count > 0
                    ? colorScheme.onPrimary.withOpacity(0.05)
                    : Colors.transparent,
                border: Border.all(
                  color: count > 0
                      ? colorScheme.onPrimary.withOpacity(0.005)
                      : colorScheme.onPrimary.withOpacity(0.09),
                  // color:  colorScheme.onPrimary.withOpacity(0.005),
                ),
                borderRadius: BorderRadius.circular(LemonRadius.xSmall),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (widget.ticketType.cost != 0) {
                        // goToWeb();
                        return;
                      }
                      minus();
                    },
                    icon: Icon(
                      Icons.remove,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "${count.toInt()}",
                        style: Typo.medium.copyWith(
                          color: colorScheme.onSecondary,
                          // TODO:switch between no quantity and has quantity
                          // color: colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  // TODO: design ui missing the way to input quantity
                  // SizedBox(width: Spacing.xSmall),
                  // ThemeSvgIcon(
                  //   color: colorScheme.onSurfaceVariant,
                  //   builder: (filter) => Assets.icons.icArrowDown.svg(colorFilter: filter),
                  // )
                  IconButton(
                    onPressed: () {
                      // if (widget.ticketType.cost != 0) {
                      //   goToWeb();
                      //   return;
                      // }
                      add();
                    },
                    icon: Icon(
                      Icons.add,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
