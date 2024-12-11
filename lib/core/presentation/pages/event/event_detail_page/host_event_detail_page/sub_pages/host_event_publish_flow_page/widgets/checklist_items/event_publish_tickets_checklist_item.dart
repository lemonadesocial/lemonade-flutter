import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/checklist_item_base_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/core/utils/list_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';
import 'package:matrix/matrix.dart' as matrix;

class EventPublishTicketsChecklistItem extends StatelessWidget {
  final bool fulfilled;
  final Event event;

  const EventPublishTicketsChecklistItem({
    super.key,
    required this.fulfilled,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final ticketTypes = (event.eventTicketTypes ?? []).asMap().entries;
    return CheckListItemBaseWidget(
      onTap: () => SnackBarUtils.showComingSoon(),
      // TODO: Ticket setup
      // onTap: () => AutoRouter.of(context).push(
      //   const EventTicketTierSettingRoute(),
      // ),
      title: t.event.eventPublish.addTickets,
      icon: Assets.icons.icTicket,
      fulfilled: fulfilled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...ticketTypes.map((entry) {
            return _TicketItem(
              ticketType: entry.value,
              event: event,
              isLast: entry.key == ticketTypes.length - 1,
            );
          }),
        ],
      ),
    );
  }
}

class _TicketItem extends StatelessWidget {
  final EventTicketType ticketType;
  final Event event;
  final bool isLast;
  const _TicketItem({
    required this.ticketType,
    required this.event,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final prices = ticketType.prices ?? [];
    final defaultPrice = ListUtils.findWithConditionOrFirst<EventTicketPrice>(
      items: prices,
      condition: (price) => price.isDefault == true,
    );
    final otherPrices = prices.length > 1 ? prices.length - 1 : 0;
    final targetPaymentAccount =
        (event.paymentAccountsExpanded ?? []).firstWhereOrNull(
      (element) =>
          element.accountInfo?.currencies?.contains(defaultPrice?.currency) ==
          true,
    );

    final decimals = targetPaymentAccount?.accountInfo?.currencyMap
            ?.tryGet<CurrencyInfo>(defaultPrice?.currency ?? '')
            ?.decimals ??
        0;

    final displayPrice = EventTicketUtils.getDisplayedTicketPrice(
      decimals: decimals,
      price: defaultPrice,
    );

    return Padding(
      padding: EdgeInsets.only(
        bottom: isLast ? 0 : Spacing.small,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(3.w),
            child: Container(
              width: Sizing.xSmall,
              height: Sizing.xSmall,
              color: LemonColor.atomicBlack,
              child: CachedNetworkImage(
                width: Sizing.xSmall,
                height: Sizing.xSmall,
                imageUrl: ticketType.photosExpanded?.isNotEmpty == true
                    ? ImageUtils.generateUrl(
                        file: ticketType.photosExpanded?.first,
                      )
                    : '',
                placeholder: (_, __) => ImagePlaceholder.ticketThumbnail(
                  iconSize: 8.w,
                ),
                errorWidget: (_, __, ___) => ImagePlaceholder.ticketThumbnail(
                  iconSize: 8.w,
                ),
              ),
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Expanded(
            flex: 1,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: ticketType.title ?? '',
                    style: Typo.medium.copyWith(color: colorScheme.onSecondary),
                  ),
                  if (ticketType.isDefault == true)
                    TextSpan(
                      text: ' (${t.common.defaultText})',
                      style: TextStyle(
                        color: colorScheme.onPrimary.withOpacity(0.24),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Text(
            displayPrice,
            style: Typo.medium.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
          if (otherPrices >= 1) ...[
            SizedBox(width: Spacing.extraSmall),
            Container(
              width: Sizing.small,
              height: Sizing.xSmall,
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(LemonRadius.small),
              ),
              child: Center(
                child: Text(
                  '+${otherPrices.toString()}',
                  style: Typo.xSmall.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
