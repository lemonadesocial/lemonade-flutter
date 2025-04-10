import 'package:app/core/application/event/event_datetime_settings_bloc/event_datetime_settings_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/constants/event/event_constants.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';

class TimezoneSelectBottomSheet extends StatefulWidget {
  const TimezoneSelectBottomSheet({super.key, this.event});
  final Event? event;

  @override
  State<TimezoneSelectBottomSheet> createState() =>
      _TimezoneSelectBottomSheetState();
}

class _TimezoneSelectBottomSheetState extends State<TimezoneSelectBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredTimezones = EventConstants.timezoneOptions;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _filteredTimezones = EventConstants.timezoneOptions
          .where(
            (timezone) =>
                timezone['text']!.toLowerCase().contains(value.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return BlocListener<EventDateTimeSettingsBloc, EventDateTimeSettingsState>(
      listener: (context, state) async {
        if (state.isValid == true &&
            state.status == FormzSubmissionStatus.success) {
          SnackBarUtils.showCustom(
            title: "${t.common.saved}!",
            message: t.event.datetimeSettings.timezoneUpdated,
            icon: Assets.icons.icSave.svg(),
            showIconContainer: true,
            iconContainerColor: LemonColor.acidGreen,
          );
          if (widget.event != null) {
            context.read<GetEventDetailBloc>().add(
                  GetEventDetailEvent.fetch(
                    eventId: widget.event!.id ?? '',
                  ),
                );
          }
          AutoRouter.of(context).pop();
        }
      },
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: colorScheme.secondaryContainer,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const BottomSheetGrabber(),
              LemonAppBar(
                backgroundColor: Colors.transparent,
                title: t.event.timezoneSetting.chooseTimezone,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.smMedium,
                ),
                child: LemonTextField(
                  radius: 16.r,
                  controller: _searchController,
                  onChange: _onSearchChanged,
                  hintText: t.common.search.capitalize(),
                  leadingIcon: Padding(
                    padding: EdgeInsets.only(
                      left: Spacing.small,
                      right: Spacing.xSmall,
                    ),
                    child: ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (filter) => Assets.icons.icSearch.svg(
                        colorFilter: filter,
                        width: 20.w,
                        height: 20.w,
                      ),
                    ),
                  ),
                  placeholderStyle: Typo.medium.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ),
              SizedBox(height: Spacing.smMedium),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredTimezones.length,
                  itemBuilder: (context, index) {
                    return TimezoneItem(
                      event: widget.event,
                      text: _filteredTimezones[index]['text'] ?? '',
                      value: _filteredTimezones[index]['value'] ?? '',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimezoneItem extends StatelessWidget {
  final Event? event;
  final String value;
  final String text;

  const TimezoneItem({
    super.key,
    required this.event,
    required this.value,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        context.read<EventDateTimeSettingsBloc>().add(
              EventDateTimeSettingsEventSaveChangesTimezone(
                event: event,
                timezone: value,
              ),
            );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.smMedium,
          vertical: Spacing.small,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                text,
                overflow: TextOverflow.visible,
                softWrap: true,
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: Spacing.small),
              child: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icArrowRight.svg(
                  colorFilter: filter,
                  width: 15.w,
                  height: 15.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
