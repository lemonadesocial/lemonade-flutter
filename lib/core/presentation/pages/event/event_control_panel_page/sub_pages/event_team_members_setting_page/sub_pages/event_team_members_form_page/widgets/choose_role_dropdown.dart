import 'package:app/core/application/event/event_team_members_form_bloc/event_team_members_form_bloc.dart';
import 'package:app/core/domain/event/entities/event_role.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class ChooseRoleDropdown extends StatelessWidget {
  final List<EventRole> eventRoles;
  const ChooseRoleDropdown({
    super.key,
    required this.eventRoles,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<EventTeamMembersFormBloc, EventTeamMembersFormBlocState>(
      builder: (context, state) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2(
            value: state.selectedRole?.id,
            onChanged: (value) {
              context.read<EventTeamMembersFormBloc>().add(
                    EventTeamMembersFormBlocEvent.selectRole(
                      role: eventRoles
                          .firstWhereOrNull((element) => element.id == value),
                    ),
                  );
            },
            customButton: Container(
              padding: EdgeInsets.all(Spacing.smMedium),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(LemonRadius.small),
                color: colorScheme.secondaryContainer,
              ),
              child: _EventRoleItem(
                key: Key(state.selectedRole?.id ?? ''),
                eventRole: state.selectedRole,
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
            items: eventRoles
                .map(
                  (eventRole) => DropdownMenuItem(
                    value: eventRole.id,
                    child: _EventRoleItem(
                      eventRole: eventRole,
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
      },
    );
  }
}

class _EventRoleItem extends StatelessWidget {
  final Widget? trailing;
  final EventRole? eventRole;
  const _EventRoleItem({
    super.key,
    this.trailing,
    this.eventRole,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            eventRole?.name ?? '',
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
