import 'package:app/core/application/event/event_team_members_form_bloc/event_team_members_form_bloc.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

class VisibleOnEventCard extends StatelessWidget {
  const VisibleOnEventCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<EventTeamMembersFormBloc, EventTeamMembersFormBlocState>(
      builder: (context, state) {
        final visibleOnEvent = state.visibleOnEvent;
        final isCohostSelected =
            state.selectedRole?.code == Enum$RoleCode.Cohost;
        // Not show this one if not select co-host
        if (isCohostSelected == false) {
          return const SizedBox();
        }
        return Container(
          padding: EdgeInsets.all(Spacing.smMedium),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.w,
                color: LemonColor.white09,
              ),
              borderRadius: BorderRadius.circular(LemonRadius.small),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 18,
                height: 18,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: ThemeSvgIcon(
                  color: colorScheme.onPrimary,
                  builder: (filter) => Assets.icons.icChecked.svg(
                    colorFilter: filter,
                    width: Sizing.medium / 2,
                    height: Sizing.medium / 2,
                  ),
                ),
              ),
              SizedBox(width: Spacing.xSmall),
              Expanded(
                child: SizedBox(
                  height: 18,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        t.event.teamMembers.visibleOnEvent,
                        style: Typo.medium
                            .copyWith(height: 0, color: colorScheme.onPrimary),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: Spacing.xSmall),
              FlutterSwitch(
                inactiveColor: colorScheme.outline,
                inactiveToggleColor: colorScheme.onSurfaceVariant,
                activeColor: LemonColor.switchActive,
                activeToggleColor: colorScheme.onPrimary,
                height: 24.h,
                width: 42.w,
                value: visibleOnEvent ?? false,
                onToggle: (value) {
                  context.read<EventTeamMembersFormBloc>().add(
                        EventTeamMembersFormBlocEventChangeVisibleOnEvent(
                          visibleOnEvent: value,
                        ),
                      );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
