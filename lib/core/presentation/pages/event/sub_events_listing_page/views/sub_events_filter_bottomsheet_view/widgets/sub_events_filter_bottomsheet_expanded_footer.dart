import 'package:app/core/application/event/get_sub_events_by_calendar_bloc/get_sub_events_by_calendar_bloc.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/helpers/sub_events_helper.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubEventsFilterBottomsheetExpandedFooter extends StatelessWidget {
  final DraggableScrollableController dragController;
  const SubEventsFilterBottomsheetExpandedFooter({
    super.key,
    required this.dragController,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return BlocBuilder<GetSubEventsByCalendarBloc, GetSubEventsByCalendarState>(
      builder: (context, state) {
        if (state.selectedHosts.isEmpty && state.selectedTags.isEmpty) {
          return const SizedBox.shrink();
        }
        final filterSelected =
            state.selectedHosts.length + state.selectedTags.length;
        final numberOfResults = state.events
            .where(
              (event) => getSubEventByFilter(
                event,
                selectedHosts: state.selectedHosts,
                selectedTags: state.selectedTags,
              ),
            )
            .length;
        return SafeArea(
          child: Container(
            padding: EdgeInsets.all(Spacing.smMedium),
            decoration: BoxDecoration(
              color: LemonColor.chineseBlack,
              border: Border(
                top: BorderSide(
                  color: colorScheme.outline,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.common.filterSelected(n: filterSelected),
                      style: Typo.medium.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                    Text(
                      t.common.result(n: numberOfResults),
                      style: Typo.medium.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Sizing.large,
                  width: Sizing.medium * 2.5,
                  child: LinearGradientButton.primaryButton(
                    onTap: () {
                      dragController.jumpTo(0.25);
                    },
                    label: t.common.apply,
                    textStyle: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
