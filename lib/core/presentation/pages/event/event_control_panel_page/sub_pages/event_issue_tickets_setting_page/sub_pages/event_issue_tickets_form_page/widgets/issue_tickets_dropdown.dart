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

class IssueTicketsDropdown extends StatelessWidget {
  const IssueTicketsDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        value: '2',
        onChanged: (value) {
          // TODO: handle by bloc
        },
        customButton: Container(
          padding: EdgeInsets.all(Spacing.smMedium),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(LemonRadius.small),
            color: colorScheme.secondaryContainer,
          ),
          child: _TicketTierItem(
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
        items: const [
          // TODO: mock data only
          DropdownMenuItem(
            value: '1',
            child: _TicketTierItem(
              title: "Ticket 1",
            ),
          ),
          DropdownMenuItem(
            value: '2',
            child: _TicketTierItem(
              title: "Ticket 2",
            ),
          ),
        ],
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
  final String? title;
  const _TicketTierItem({
    this.trailing,
    this.title,
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
            title ?? "Default tickets",
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
