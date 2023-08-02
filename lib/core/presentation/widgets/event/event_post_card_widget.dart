import 'dart:ui';

import 'package:app/core/config.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/event/event_buy_ticket_button_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EventPostCard extends StatelessWidget {
  final Event event;
  const EventPostCard({
    super.key,
    required this.event,
  });

  DbFile? get eventPhoto => event.newNewPhotosExpanded?.isNotEmpty == true
      ? event.newNewPhotosExpanded!.first
      : null;

  String get eventTitle => event.title ?? '';

  String get hostName =>
      event.hostExpanded?.displayName ?? event.hostExpanded?.username ?? '';

  int? get cohostsCount => event.cohostsExpanded?.length;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).navigate(
          EventDetailRoute(
              eventId: event.id ?? '', eventName: event.title ?? ''),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(LemonRadius.normal),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: colorScheme.outline, 
                  width: 1.0, 
                ),
                borderRadius:
                    BorderRadius.circular(20), 
              ),
              child: Column(
                children: [
                  _buildEventPhoto(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Spacing.small,
                      horizontal: Spacing.small,
                    ),
                    child: Column(
                      children: [
                        _buildEventTitleAndTime(colorScheme),
                        SizedBox(height: Spacing.xSmall),
                        _buildEventHost(colorScheme),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: Spacing.extraSmall,
                right: Spacing.extraSmall,
                child: _buildEventBadge(colorScheme))
          ],
        ),
      ),
    );
  }

  Row _buildEventHost(ColorScheme colorScheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildHostsAvatars(colorScheme),
        SizedBox(width: Spacing.extraSmall),
        ThemeSvgIcon(
          color: colorScheme.onSurface,
          builder: (filter) => Assets.icons.icHostFilled.svg(
            colorFilter: filter,
            width: Sizing.xSmall,
            height: Sizing.xSmall,
          ),
        ),
        SizedBox(width: Spacing.superExtraSmall),
        Text.rich(
          style: Typo.small.copyWith(color: colorScheme.onSurface, height: 1.5),
          TextSpan(
            text: hostName,
            children: [
              if (cohostsCount != null && cohostsCount != 0)
                TextSpan(text: ' +${cohostsCount}'),
            ],
          ),
        ),
        SizedBox(width: Spacing.superExtraSmall),
      ],
    );
  }

  Widget _buildHostsAvatars(ColorScheme colorScheme) {
    final hosts = [...(event.cohostsExpanded ?? []), event.hostExpanded];
    return Container(
      width: (1 + 1 / 2 * (hosts.length - 1)) * Sizing.small,
      height: Sizing.small,
      child: Stack(
        children: hosts.asMap().entries.map((entry) {
          final file = (entry.value?.newPhotosExpanded != null)
              ? entry.value?.newPhotosExpanded!.first
              : null;
          return Positioned(
            right: entry.key * 12,
            child: Container(
              width: Sizing.small,
              height: Sizing.small,
              decoration: BoxDecoration(
                  color: colorScheme.primary,
                  border: Border.all(color: colorScheme.outline),
                  borderRadius: BorderRadius.circular(Sizing.small)),
              child: LemonCircleAvatar(
                  url: ImageUtils.generateUrl(file: file), size: Sizing.small),
            ),
          );
        }).toList(),
      ),
    );
  }

  Row _buildEventTitleAndTime(ColorScheme colorScheme) {
    return Row(
      children: [
        Text.rich(
          TextSpan(
            text: "${event.title}\n",
            style: Typo.medium.copyWith(fontFamily: FontFamily.circularStd),
            children: [
              TextSpan(
                style: Typo.small
                    .copyWith(color: colorScheme.onSurface, height: 1.5, fontFamily: FontFamily.circularStd),
                text: DateFormatUtils.fullDateWithTime(event.start),
              )
            ],
          ),
        ),
        Spacer(),
        EventBuyTicketButton(event: event),
      ],
    );
  }

  Container _buildEventPhoto() {
    final imageUrl = eventPhoto != null
        ? ImageUtils.generateUrl(
            file: eventPhoto,
            imageConfig: ImageConfig.eventPhoto,
          )
        : '${AppConfig.assetPrefix}/assets/images/no_photo_event.png';
    return Container(
      height: 170,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(LemonRadius.normal),
          topLeft: Radius.circular(LemonRadius.normal),
        ),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          errorWidget: (_, __, ___) => ImagePlaceholder.defaultPlaceholder(),
          placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildEventBadge(ColorScheme colorScheme) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: Container(
          width: Sizing.regular,
          height: Sizing.regular,
          decoration: ShapeDecoration(
            shape: CircleBorder(side: BorderSide(color: colorScheme.outline)),
            color: Colors.transparent,
          ),
          child: Center(
            child: Assets.icons.icHouseParty.svg(
              width: Sizing.xSmall,
              height: Sizing.xSmall,
            ),
          ),
        ),
      ),
    );
  }
}
