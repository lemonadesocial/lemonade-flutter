import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final Function()? onTap;

  const EventCard({
    super.key,
    required this.event,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: colorScheme.outline),
        ),
        child: Column(
          children: [
            _buildCardHeader(),
            _buildCardBody(),
            _buildCardFooter(context, colorScheme),
          ],
        ),
      ),
    );
  }

  _buildCardHeader() => Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall, vertical: Spacing.xSmall),
        child: LemonCircleAvatar(
          url: ImageUtils.generateUrl(
              file: event.hostExpanded?.newPhotosExpanded?.first, imageConfig: ImageConfig.profile),
          label: event.hostExpanded?.name ?? '',
        ),
      );

  _buildCardBody() => event.newNewPhotosExpanded?.isNotEmpty == true
      ? Container(
          constraints: BoxConstraints(maxHeight: 300),
          width: double.infinity,
          height: 200,
          child: CachedNetworkImage(
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (_, __) => ImagePlaceholder.eventCard(),
            errorWidget: (_, __, ___) => ImagePlaceholder.eventCard(),
            imageUrl:
                ImageUtils.generateUrl(file: event.newNewPhotosExpanded?.first, imageConfig: ImageConfig.eventPhoto),
          ),
        )
      : ImagePlaceholder.eventCard();

  _buildCardFooter(BuildContext context, ColorScheme colorScheme) => Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.small, vertical: Spacing.small),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.title ?? ''),
                SizedBox(height: Spacing.superExtraSmall),
                Text(DateFormatUtils.fullDateWithTime(event.start),
                    style: Typo.small.copyWith(color: colorScheme.onSecondary)),
              ],
            ),
            const Spacer(),
            _buildBuyTicketButton(context, colorScheme)
          ],
        ),
      );

  _buildBuyTicketButton(BuildContext ctx, ColorScheme colorScheme) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall, vertical: Spacing.extraSmall),
        decoration: BoxDecoration(
          border: Border.all(color: colorScheme.outline),
          borderRadius: BorderRadius.circular(LemonRadius.normal),
          color: LemonColor.lavender18,
        ),
        child: Row(
          children: [
            Assets.icons.icTicket.svg(
              width: Sizing.xSmall,
              height: Sizing.xSmall,
              colorFilter: ColorFilter.mode(LemonColor.paleViolet, BlendMode.srcIn),
            ),
            SizedBox(width: Spacing.superExtraSmall),
            Text(
              event.cost != null
                  ? '${NumberUtils.formatCurrency(amount: event.cost!, currency: event.currency, freeText: t.event.free, prefix: '${t.event.buy} • ')}'
                  : '${t.event.free}',
              style: Typo.small.copyWith(color: LemonColor.paleViolet),
            )
          ],
        ),
      ),
    );
  }
}
