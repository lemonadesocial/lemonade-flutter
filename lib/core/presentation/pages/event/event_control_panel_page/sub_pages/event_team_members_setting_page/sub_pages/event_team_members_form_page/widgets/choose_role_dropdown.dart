import 'package:app/core/application/event_tickets/issue_tickets_bloc/issue_tickets_bloc.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseRoleDropdown extends StatelessWidget {
  final List<EventTicketType> ticketTypes;
  const ChooseRoleDropdown({
    super.key,
    required this.ticketTypes,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        value: null,
        onChanged: (value) {
          context.read<IssueTicketsBloc>().add(
                IssueTicketsBlocEvent.selectTicketType(
                  ticketType:
                      ticketTypes.firstWhere((element) => element.id == value),
                ),
              );
        },
        customButton: Container(
          padding: EdgeInsets.all(Spacing.smMedium),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(LemonRadius.small),
            color: colorScheme.secondaryContainer,
          ),
          child: _TicketTierItem(
            // key: Key(state.selectedTicketType?.id ?? ''),
            ticketType: null,
            trailing: ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icArrowDown.svg(
                width: Sizing.xSmall,
                height: Sizing.xSmall,
                colorFilter: filter,
              ),
            ),
          ),
        ),
        items: ticketTypes
            .map(
              (ticketType) => DropdownMenuItem(
                value: ticketType.id,
                child: _TicketTierItem(
                  ticketType: ticketType,
                ),
              ),
            )
            .toList(),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(LemonRadius.small),
            color: colorScheme.secondaryContainer,
          ),
          offset: Offset(0, -Spacing.superExtraSmall),
        ),
        menuItemStyleData: const MenuItemStyleData(
          overlayColor: MaterialStatePropertyAll(LemonColor.darkBackground),
        ),
      ),
    );
  }
}

class _TicketTierItem extends StatelessWidget {
  final Widget? trailing;
  final EventTicketType? ticketType;
  const _TicketTierItem({
    this.trailing,
    this.ticketType,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
          child: CachedNetworkImage(
            imageUrl: "",
            errorWidget: (_, __, ___) => ImagePlaceholder.ticketThumbnail(),
            placeholder: (_, __) => ImagePlaceholder.ticketThumbnail(),
            width: Sizing.small,
            height: Sizing.small,
          ),
        ),
        SizedBox(width: Spacing.xSmall),
        Expanded(
          flex: 1,
          child: Text(
            ticketType?.title ?? '',
            style: Typo.mediumPlus.copyWith(
              color: colorScheme.onPrimary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}
