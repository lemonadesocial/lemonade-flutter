import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/report/report_bloc/report_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/report/input/report_input.dart';
import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_appbar.dart';
import 'package:app/core/presentation/widgets/floating_frosted_glass_dropdown_widget.dart';
import 'package:app/core/presentation/widgets/report/report_bottom_sheet.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/bottomsheet_utils.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestEventMoreActions extends StatelessWidget {
  final reportBloc = ReportBloc();
  final Event event;
  final bool isAppBarCollapsed;

  GuestEventMoreActions({
    super.key,
    required this.event,
    required this.isAppBarCollapsed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final authState = context.read<AuthBloc>().state;
    final userId = AuthUtils.getUserId(context);
    final isOwnEvent = EventUtils.isOwnEvent(event: event, userId: userId);

    return FloatingFrostedGlassDropdown(
      offset: Offset(0, Sizing.xxSmall),
      items: isOwnEvent
          ? []
          : [
              DropdownItemDpo(
                leadingIcon: Assets.icons.icRoundReport.svg(
                  width: Sizing.xSmall,
                  height: Sizing.xSmall,
                ),
                label: t.common.actions.report,
                value: "report",
                customColor: LemonColor.report,
              ),
            ],
      onEmptyPressed: () {
        SnackBarUtils.showComingSoon();
      },
      onItemPressed: (item) {
        if (item?.value == 'report') {
          authState.maybeWhen(
            authenticated: (_) => BottomSheetUtils.showSnapBottomSheet(
              context,
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
            ),
            orElse: () => AutoRouter.of(context).navigate(const LoginRoute()),
          );
        }
      },
      child: BlurCircle(
        child: Center(
          child: ThemeSvgIcon(
            color: isAppBarCollapsed
                ? colorScheme.onSecondary
                : colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icMoreHoriz.svg(
              colorFilter: filter,
            ),
          ),
        ),
      ),
    );
  }
}
