import 'package:app/core/application/report/report_bloc/report_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/report/input/report_input.dart';
import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_animated_appbar_widget.dart';
import 'package:app/core/presentation/widgets/floating_frosted_glass_dropdown_widget.dart';
import 'package:app/core/presentation/widgets/lemon_back_button_widget.dart';
import 'package:app/core/presentation/widgets/report/report_bottom_sheet.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/core/utils/share_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

enum _EventAction {
  share,
  edit,
  report,
}

class PostGuestEventAnimatedAppBar extends LemonAnimatedAppBar {
  final Event event;
  final reportBloc = ReportBloc();
  @override
  PostGuestEventAnimatedAppBar({
    required this.event,
    super.actions,
  });

  void _share() {
    ShareUtils.shareEvent(event);
  }

  void _edit(BuildContext context) {
    AutoRouter.of(context).push(const EventControlPanelRoute());
  }

  void _report(BuildContext context) {
    final isLoggedIn = AuthUtils.getUser(context) != null;
    if (isLoggedIn) {
      showCupertinoModalBottomSheet(
        context: context,
        builder: (_) {
          return BlocProvider.value(
            value: reportBloc,
            child: ReportBottomSheet(
              onPressReport: (reason) {
                reportBloc.add(
                  ReportEvent.reportEvent(
                    input: ReportInput(
                      id: event.id ?? '',
                      reason: reason,
                    ),
                  ),
                );
              },
              title: t.common.report.reportEvent,
              description: t.common.report.reportDescription(
                reportName: 'event',
              ),
              placeholder: t.common.report.reportPlaceholder(
                reportName: 'event',
              ),
            ),
          );
        },
      );
    } else {
      AutoRouter.of(context).navigate(const LoginRoute());
    }
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final primary = Theme.of(context).colorScheme.primary;
    final userId = AuthUtils.getUserId(context);
    final isOwnEventOrCohost = EventUtils.isOwnEvent(
          event: event,
          userId: userId,
        ) ||
        EventUtils.isCohost(
          event: event,
          userId: userId,
        );
    return AppBar(
      backgroundColor: backgroundColor ?? primary,
      automaticallyImplyLeading: hideLeading ?? true,
      leading: hideLeading ?? false ? null : leading ?? const LemonBackButton(),
      actions: actions ??
          [
            Padding(
              padding: EdgeInsets.only(right: Spacing.smMedium),
              child: FloatingFrostedGlassDropdown(
                containerWidth: 170.w,
                items: [
                  DropdownItemDpo(
                    value: _EventAction.share,
                    label: t.common.actions.share,
                    leadingIcon: ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (colorFilter) => Assets.icons.icShare.svg(
                        colorFilter: colorFilter,
                      ),
                    ),
                  ),
                  if (isOwnEventOrCohost)
                    DropdownItemDpo(
                      value: _EventAction.edit,
                      label: StringUtils.capitalize(t.common.actions.edit),
                      leadingIcon: ThemeSvgIcon(
                        color: colorScheme.onSecondary,
                        builder: (colorFilter) => Assets.icons.icEdit.svg(
                          width: 18.w,
                          height: 18.w,
                          colorFilter: colorFilter,
                        ),
                      ),
                    ),
                  if (!isOwnEventOrCohost)
                    DropdownItemDpo(
                      value: _EventAction.report,
                      label: t.common.actions.report,
                      leadingIcon: ThemeSvgIcon(
                        color: LemonColor.coralReef,
                        builder: (colorFilter) => Assets.icons.icReport.svg(
                          colorFilter: colorFilter,
                        ),
                      ),
                      textStyle: Typo.medium.copyWith(
                        color: LemonColor.coralReef,
                      ),
                    ),
                ],
                onItemPressed: (item) {
                  Vibrate.feedback(FeedbackType.light);
                  if (item?.value == _EventAction.share) {
                    _share();
                  }

                  if (item?.value == _EventAction.edit) {
                    _edit(context);
                  }

                  if (item?.value == _EventAction.report) {
                    _report(context);
                  }
                },
                child: ThemeSvgIcon(
                  color: colorScheme.onPrimary,
                  builder: (filter) => Assets.icons.icMoreHoriz.svg(
                    colorFilter: filter,
                    width: 25.w,
                    height: 25.w,
                  ),
                ),
              ),
            ),
          ],
      centerTitle: true,
      elevation: 0,
      toolbarHeight: preferredSize.height,
    );
  }
}
