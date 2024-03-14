import 'package:app/core/application/event/event_application_form_profile_setting_bloc/event_application_form_profile_setting_bloc.dart';
import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

class EventApplicationFormProfileItem extends StatelessWidget {
  final ProfileFieldKey item;
  const EventApplicationFormProfileItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<EventApplicationFormProfileSettingBloc,
        EventApplicationFormProfileSettingBlocState>(
      builder: (context, state) {
        final applicationProfileFields = state.applicationProfileFields;
        bool isChecked = applicationProfileFields.any(
          (element) => element.field == item.fieldKey,
        );
        bool isRequired = applicationProfileFields.any(
          (element) =>
              element.field == item.fieldKey && element.required == true,
        );

        return Container(
          decoration: BoxDecoration(
            color: LemonColor.darkBackground,
            borderRadius: BorderRadius.circular(LemonRadius.small),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.smMedium,
                  vertical: Spacing.small,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.label,
                      style: Typo.medium.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context
                            .read<EventApplicationFormProfileSettingBloc>()
                            .add(
                              EventApplicationFormProfileSettingBlocEvent
                                  .toggleSelect(
                                fieldKey: item.fieldKey,
                              ),
                            );
                      },
                      child: Container(
                        child: isChecked
                            ? Assets.icons.icChecked.svg(
                                width: Sizing.small,
                                height: Sizing.small,
                              )
                            : Icon(
                                Icons.circle_outlined,
                                size: Sizing.small,
                                color: colorScheme.onSecondary,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              isChecked
                  ? Column(
                      children: [
                        Container(
                          height: 1,
                          color: colorScheme.outline,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Spacing.smMedium,
                            vertical: Spacing.small,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                t.event.applicationForm.required,
                                style: Typo.medium
                                    .copyWith(color: colorScheme.onSecondary),
                              ),
                              FlutterSwitch(
                                inactiveColor: colorScheme.outline,
                                inactiveToggleColor:
                                    colorScheme.onSurfaceVariant,
                                activeColor: LemonColor.paleViolet,
                                activeToggleColor: colorScheme.onPrimary,
                                height: 24.h,
                                width: 42.w,
                                value: isRequired,
                                onToggle: (value) {
                                  context
                                      .read<
                                          EventApplicationFormProfileSettingBloc>()
                                      .add(
                                        EventApplicationFormProfileSettingBlocEvent
                                            .toggleRequired(
                                                fieldKey: item.fieldKey,
                                                isRequired: value),
                                      );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink()
            ],
          ),
        );
      },
    );
  }
}
