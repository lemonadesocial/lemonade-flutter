import 'package:app/core/application/event/event_application_form_profile_setting_bloc/event_application_form_profile_setting_bloc.dart';
import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class EventApplicationFormProfileItem extends StatelessWidget {
  final ProfileFieldKey item;
  final bool? isSpecialRadiusTop;
  final bool? isSpecialRadiusBottom;
  const EventApplicationFormProfileItem({
    super.key,
    required this.item,
    this.isSpecialRadiusTop,
    this.isSpecialRadiusBottom,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final double topRadius =
        isSpecialRadiusTop == true ? LemonRadius.medium : LemonRadius.medium;
    final double bottomRadius =
        isSpecialRadiusBottom == true ? LemonRadius.medium : LemonRadius.medium;

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
            color: LemonColor.chineseBlack,
            border: Border.all(
              color: colorScheme.outlineVariant,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topRadius),
              topRight: Radius.circular(topRadius),
              bottomLeft: Radius.circular(bottomRadius),
              bottomRight: Radius.circular(bottomRadius),
            ),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Vibrate.feedback(FeedbackType.light);
                  context.read<EventApplicationFormProfileSettingBloc>().add(
                        EventApplicationFormProfileSettingBlocEvent
                            .toggleSelect(
                          fieldKey: item.fieldKey,
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
                    children: [
                      Text(
                        item.label,
                        style: Typo.medium.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        child: isChecked
                            ? Assets.icons.icChecked.svg(
                                width: 18.w,
                                height: 18.w,
                              )
                            : Assets.icons.icUncheck.svg(
                                width: 18.w,
                                height: 18.w,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isChecked)
                Column(
                  children: [
                    Container(
                      height: 1,
                      color: colorScheme.outlineVariant,
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
                            style: Typo.medium.copyWith(
                              color: colorScheme.onPrimary,
                            ),
                          ),
                          FlutterSwitch(
                            padding: 2.w,
                            inactiveColor: colorScheme.outline,
                            inactiveToggleColor: colorScheme.onSurfaceVariant,
                            activeColor: LemonColor.paleViolet,
                            activeToggleColor: colorScheme.onPrimary,
                            height: 24.h,
                            width: 42.w,
                            value: isRequired,
                            onToggle: (value) {
                              Vibrate.feedback(FeedbackType.light);
                              context
                                  .read<
                                      EventApplicationFormProfileSettingBloc>()
                                  .add(
                                    EventApplicationFormProfileSettingBlocEvent
                                        .toggleRequired(
                                      fieldKey: item.fieldKey,
                                      isRequired: value,
                                    ),
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
