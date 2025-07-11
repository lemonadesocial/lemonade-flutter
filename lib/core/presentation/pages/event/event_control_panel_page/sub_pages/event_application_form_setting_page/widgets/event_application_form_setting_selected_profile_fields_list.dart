import 'package:app/core/application/event/event_application_form_profile_setting_bloc/event_application_form_profile_setting_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/domain/event/entities/event_application_profile_field.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/theme/typo.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:collection/collection.dart';

List<ProfileFieldKey> basicInfoKeys = [
  ProfileFieldKey.displayName,
  ProfileFieldKey.pronoun,
  ProfileFieldKey.tagline,
  ProfileFieldKey.description,
  ProfileFieldKey.companyName,
  ProfileFieldKey.jobTitle,
  ProfileFieldKey.industry,
  ProfileFieldKey.dateOfBirth,
  ProfileFieldKey.educationTitle,
  ProfileFieldKey.newGender,
  ProfileFieldKey.ethnicity,
];

List<ProfileFieldKey> socialInfoKeys = [
  ProfileFieldKey.handleTwitter,
  ProfileFieldKey.handleLinkedin,
  ProfileFieldKey.handleGithub,
  ProfileFieldKey.handleCalendly,
  ProfileFieldKey.handleMirror,
  ProfileFieldKey.handleFarcaster,
  ProfileFieldKey.handleLens,
];

class EventApplicationFormSettingSelectedProfileFieldsList
    extends StatefulWidget {
  final List<EventApplicationProfileField> profileFields;
  const EventApplicationFormSettingSelectedProfileFieldsList({
    super.key,
    required this.profileFields,
  });

  @override
  State<EventApplicationFormSettingSelectedProfileFieldsList> createState() =>
      _EventApplicationFormSettingSelectedProfileFieldsListState();
}

class _EventApplicationFormSettingSelectedProfileFieldsListState
    extends State<EventApplicationFormSettingSelectedProfileFieldsList> {
  List<EventApplicationProfileField> get basicInfoFields => widget.profileFields
      .where(
        (element) =>
            basicInfoKeys.map((e) => e.fieldKey).contains(element.field),
      )
      .toList();

  List<EventApplicationProfileField> get socialInfoFields =>
      widget.profileFields
          .where(
            (element) =>
                socialInfoKeys.map((e) => e.fieldKey).contains(element.field),
          )
          .toList();

  void onChange({
    required EventApplicationProfileField field,
    required int value,
  }) {
    // field is required
    if (value == 1) {
      context.read<EventApplicationFormProfileSettingBloc>().add(
            EventApplicationFormProfileSettingBlocEvent.toggleRequired(
              fieldKey: field.field ?? '',
              isRequired: true,
            ),
          );
    }
    // field is optional
    if (value == 0) {
      context.read<EventApplicationFormProfileSettingBloc>().add(
            EventApplicationFormProfileSettingBlocEvent.toggleRequired(
              fieldKey: field.field ?? '',
              isRequired: false,
            ),
          );
    }
    // remove field
    if (value == -1) {
      context.read<EventApplicationFormProfileSettingBloc>().add(
            EventApplicationFormProfileSettingBlocEvent.toggleSelect(
              fieldKey: field.field ?? '',
            ),
          );
    }
    context.read<EventApplicationFormProfileSettingBloc>().add(
          EventApplicationFormProfileSettingBlocEvent.submit(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final t = Translations.of(context);
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              _DefaultProfileFieldItem(
                label: t.profile.name,
                icon: ThemeSvgIcon(
                  color: appColors.textTertiary,
                  builder: (filter) => Assets.icons.icProfileOutline.svg(
                    colorFilter: filter,
                    width: 16.w,
                    height: 16.w,
                  ),
                ),
                topRadius: LemonRadius.medium,
                bottomRadius: 0,
              ),
              _DefaultProfileFieldItem(
                label: t.profile.email,
                icon: ThemeSvgIcon(
                  color: appColors.textTertiary,
                  builder: (filter) => Assets.icons.icEmailAt.svg(
                    colorFilter: filter,
                    width: 16.w,
                    height: 16.w,
                  ),
                ),
                topRadius: 0,
                bottomRadius: LemonRadius.medium,
              ),
            ],
          ),
        ),
        if (basicInfoFields.isNotEmpty || socialInfoFields.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: SizedBox(
              height: Spacing.small,
            ),
          ),
          if (basicInfoFields.isNotEmpty) ...[
            SliverList.separated(
              itemBuilder: (context, index) {
                final field = basicInfoFields[index];
                final fieldKey = basicInfoKeys.firstWhereOrNull(
                  (element) => element.fieldKey == field.field,
                );
                return _ProfileFieldItem(
                  fieldKey: fieldKey ?? ProfileFieldKey.unknown,
                  profileField: field,
                  isFirst: index == 0,
                  isLast: index == basicInfoFields.length - 1,
                  onChange: (value) => onChange(
                    field: field,
                    value: value,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox.shrink();
              },
              itemCount: basicInfoFields.length,
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: Spacing.small,
              ),
            ),
          ],
          if (socialInfoFields.isNotEmpty) ...[
            SliverList.separated(
              itemBuilder: (context, index) {
                final field = socialInfoFields[index];
                final fieldKey = socialInfoKeys.firstWhereOrNull(
                  (element) => element.fieldKey == field.field,
                );
                return _ProfileFieldItem(
                  fieldKey: fieldKey ?? ProfileFieldKey.unknown,
                  profileField: field,
                  isFirst: index == 0,
                  isLast: index == socialInfoFields.length - 1,
                  onChange: (value) => onChange(
                    field: field,
                    value: value,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox.shrink();
              },
              itemCount: socialInfoFields.length,
            ),
          ],
        ],
      ],
    );
  }
}

class _DefaultProfileFieldItem extends StatelessWidget {
  final String label;
  final Widget icon;
  final double topRadius;
  final double bottomRadius;
  const _DefaultProfileFieldItem({
    required this.label,
    required this.icon,
    this.topRadius = 0,
    this.bottomRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final t = Translations.of(context);
    return Container(
      padding: EdgeInsets.all(Spacing.small),
      decoration: BoxDecoration(
        color: appColors.cardBg,
        border: Border.all(
          color: appColors.pageDivider,
          width: 0.5.w,
        ),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(topRadius),
          bottom: Radius.circular(bottomRadius),
        ),
      ),
      child: Row(
        children: [
          icon,
          SizedBox(width: Spacing.small),
          Text(
            label,
            style: Typo.medium.copyWith(
              color: appColors.textPrimary,
            ),
          ),
          const Spacer(),
          Text(
            t.event.applicationForm.required,
            style: Typo.medium.copyWith(
              color: appColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileFieldItem extends StatefulWidget {
  final ProfileFieldKey fieldKey;
  final EventApplicationProfileField profileField;
  final bool isFirst;
  final bool isLast;
  final Function(int value)? onChange;

  const _ProfileFieldItem({
    required this.fieldKey,
    required this.profileField,
    this.isFirst = false,
    this.isLast = false,
    this.onChange,
  });

  @override
  State<_ProfileFieldItem> createState() => _ProfileFieldItemState();
}

class _ProfileFieldItemState extends State<_ProfileFieldItem> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final t = Translations.of(context);
    return BlocListener<GetEventDetailBloc, GetEventDetailState>(
      listener: (context, state) {
        if (state is GetEventDetailStateFetched) {
          setState(() {
            isLoading = false;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.all(Spacing.small),
        decoration: BoxDecoration(
          color: appColors.cardBg,
          border: Border.all(
            color: appColors.pageDivider,
            width: 0.5.w,
          ),
          borderRadius: BorderRadius.vertical(
            top: widget.isFirst
                ? Radius.circular(LemonRadius.medium)
                : Radius.zero,
            bottom: widget.isLast
                ? Radius.circular(LemonRadius.medium)
                : Radius.zero,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.fieldKey.label,
              style: Typo.medium.copyWith(
                color: appColors.textPrimary,
              ),
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton2<int>(
                value: widget.profileField.required == true ? 1 : 0,
                onChanged: (value) {
                  setState(() {
                    isLoading = true;
                  });
                  widget.onChange?.call(value ?? 0);
                },
                customButton: Row(
                  children: [
                    if (isLoading) Loading.defaultLoading(context),
                    if (!isLoading) ...[
                      Text(
                        widget.profileField.required == true
                            ? t.event.applicationForm.required
                            : t.event.applicationForm.optional,
                        style: Typo.medium.copyWith(
                          color: appColors.textTertiary,
                        ),
                      ),
                      SizedBox(width: Spacing.superExtraSmall),
                      ThemeSvgIcon(
                        color: appColors.textTertiary,
                        builder: (filter) =>
                            Assets.icons.icDoubleArrowUpDown.svg(
                          colorFilter: filter,
                        ),
                      ),
                    ],
                  ],
                ),
                items: isLoading
                    ? []
                    : [
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Text(
                            t.event.applicationForm.required,
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 0,
                          child: Text(
                            t.event.applicationForm.optional,
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: -1,
                          child: Text(
                            t.event.applicationForm.off,
                          ),
                        ),
                      ],
                dropdownStyleData: DropdownStyleData(
                  width: 200.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(LemonRadius.small),
                    color: appColors.pageBg,
                  ),
                  offset: Offset(0, -Spacing.superExtraSmall),
                ),
                menuItemStyleData: MenuItemStyleData(
                  overlayColor: MaterialStatePropertyAll(
                    appColors.pageBg,
                  ),
                  selectedMenuItemBuilder: (context, child) => Row(
                    children: [
                      child,
                      const Spacer(),
                      ThemeSvgIcon(
                        color: appColors.textPrimary,
                        builder: (filter) => Assets.icons.icDone.svg(
                          colorFilter: filter,
                          width: 16.w,
                          height: 16.w,
                        ),
                      ),
                      SizedBox(width: Spacing.small),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
