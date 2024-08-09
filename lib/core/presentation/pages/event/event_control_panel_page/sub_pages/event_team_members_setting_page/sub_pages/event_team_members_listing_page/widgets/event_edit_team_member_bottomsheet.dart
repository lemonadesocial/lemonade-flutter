import 'package:app/core/application/event/get_event_roles_bloc/get_event_roles_bloc.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_team_members_setting_page/sub_pages/event_team_members_form_page/widgets/choose_role_dropdown.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_team_members_setting_page/sub_pages/event_team_members_form_page/widgets/visible_on_event_card.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slang/builder/utils/string_extensions.dart';

class EventEditTeamMemberBottomSheet extends StatelessWidget {
  const EventEditTeamMemberBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: LemonColor.atomicBlack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BottomSheetGrabber(),
          LemonAppBar(
            title: t.event.teamMembers.editMember,
            backgroundColor: LemonColor.atomicBlack,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: Spacing.superExtraSmall,
              bottom: Spacing.large,
              left: Spacing.smMedium,
              right: Spacing.smMedium,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<GetEventRolesBloc, GetEventRolesState>(
                  builder: (context, state) {
                    return ChooseRoleDropdown(
                      eventRoles: state.eventRoles,
                    );
                  },
                ),
                SizedBox(
                  height: Spacing.xSmall,
                ),
                Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.w, color: LemonColor.white09),
                      borderRadius: BorderRadius.circular(LemonRadius.small),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const VisibleOnEventCard(
                        showBorder: false,
                      ),
                      Container(
                        height: 1.w,
                        color: LemonColor.white09,
                      ),
                      Padding(
                        padding: EdgeInsets.all(Spacing.smMedium),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ThemeSvgIcon(
                              color: LemonColor.coralReef,
                              builder: (filter) {
                                return Assets.icons.icDelete.svg(
                                  colorFilter: filter,
                                  width: Sizing.medium / 2,
                                  height: Sizing.medium / 2,
                                );
                              },
                            ),
                            SizedBox(width: Spacing.xSmall),
                            Expanded(
                              child: Text(
                                t.common.delete.capitalize(),
                                style: Typo.mediumPlus.copyWith(
                                  color: LemonColor.coralReef,
                                  fontSize: 15.sp,
                                  height: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
