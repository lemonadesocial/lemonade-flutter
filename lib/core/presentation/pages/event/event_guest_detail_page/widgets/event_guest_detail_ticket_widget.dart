import 'package:app/core/domain/event/entities/event_guest_detail/event_guest_detail.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventGuestDetailTicketWidget extends StatefulWidget {
  final EventGuestDetail? eventGuestDetail;
  const EventGuestDetailTicketWidget({
    super.key,
    this.eventGuestDetail,
  });

  @override
  State<EventGuestDetailTicketWidget> createState() =>
      _EventGuestDetailTicketWidgetState();
}

class _EventGuestDetailTicketWidgetState
    extends State<EventGuestDetailTicketWidget> {
  bool isExpanded = false;

  String get _buyerAvatar => widget.eventGuestDetail?.user.imageAvatar ?? '';
  String get _buyerName => widget.eventGuestDetail?.user.name ?? '';
  String get _buyerEmail => widget.eventGuestDetail?.user.email ?? '';
  String get _ticketName =>
      widget.eventGuestDetail?.ticket?.typeExpanded?.title ?? '';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    if (widget.eventGuestDetail?.ticket == null) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          t.event.eventGuestDetail.tickets,
          style: Typo.mediumPlus.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: Spacing.small),
        Container(
          decoration: BoxDecoration(
            color: LemonColor.chineseBlack,
            borderRadius: BorderRadius.circular(LemonRadius.small),
            border: Border.all(color: colorScheme.outline),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () => setState(() => isExpanded = !isExpanded),
                child: Padding(
                  padding: EdgeInsets.all(Spacing.small),
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
                      SizedBox(width: Spacing.small),
                      Expanded(
                        child: Text(
                          _ticketName,
                          style: Typo.medium.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (isExpanded)
                        ThemeSvgIcon(
                          color: colorScheme.onSecondary,
                          builder: (filter) => Assets.icons.icArrowUp.svg(
                            width: Sizing.mSmall,
                            height: Sizing.mSmall,
                            colorFilter: filter,
                          ),
                        ),
                      if (!isExpanded)
                        ThemeSvgIcon(
                          color: colorScheme.onSecondary,
                          builder: (filter) => Assets.icons.icArrowDown.svg(
                            width: Sizing.mSmall,
                            height: Sizing.mSmall,
                            colorFilter: filter,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (isExpanded)
                Divider(
                  height: 1,
                  color: colorScheme.outline,
                ),
              if (isExpanded)
                Padding(
                  padding: EdgeInsets.all(Spacing.small),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          LemonNetworkImage(
                            imageUrl: _buyerAvatar,
                            width: Sizing.medium,
                            height: Sizing.medium,
                            borderRadius: BorderRadius.circular(Sizing.medium),
                            placeholder: ImagePlaceholder.avatarPlaceholder(),
                          ),
                          SizedBox(width: Spacing.small),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (_buyerName.isNotEmpty)
                                  Text(
                                    _buyerName,
                                    style: Typo.medium.copyWith(
                                      color: colorScheme.onPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                SizedBox(height: 2.w),
                                if (_buyerEmail.isNotEmpty)
                                  Text(
                                    _buyerEmail,
                                    style: Typo.small.copyWith(
                                      color: colorScheme.onSecondary,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
