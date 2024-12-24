import 'package:app/core/application/event/event_application_form_profile_setting_bloc/event_application_form_profile_setting_bloc.dart';
import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_application_form_setting_page/sub_pages/event_application_form_profile_setting_page/widgets/event_application_form_profile_item.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_application_form_setting_page/widgets/add_question_info_widget.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_bottom_sheet_mixin.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class ProfileFieldKeyModel {
  final String fieldKey;
  final String label;

  ProfileFieldKeyModel({
    required this.fieldKey,
    required this.label,
  });
}

enum ApplicationFormProfileType {
  basicInfo,
  socialMediaInfo,
}

@RoutePage()
class EventApplicationFormProfileSettingPage extends StatelessWidget
    with LemonBottomSheet {
  EventApplicationFormProfileSettingPage({
    super.key,
    required this.event,
    required this.profileType,
  });
  final Event? event;
  final ApplicationFormProfileType profileType;

  List<ProfileFieldKeyModel> generateProfileFieldKeyOptions(
    List<ProfileFieldKey> keys,
  ) {
    return keys.map((key) {
      return ProfileFieldKeyModel(
        fieldKey: key.fieldKey,
        label: key.label,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    List<ProfileFieldKey> basicInfoKeys = [
      ProfileFieldKey.pronoun,
      ProfileFieldKey.tagline,
      ProfileFieldKey.description,
      // Basic info + personal info
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
    return BlocListener<EventApplicationFormProfileSettingBloc,
        EventApplicationFormProfileSettingBlocState>(
      listener: (context, state) {
        if (state.status == EventApplicationFormProfileSettingStatus.success) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: LemonAppBar(
          title: t.event.applicationForm.addQuestion,
          actions: [
            BlocBuilder<EventApplicationFormProfileSettingBloc,
                EventApplicationFormProfileSettingBlocState>(
              builder: (context, state) {
                if (state.status ==
                    EventApplicationFormProfileSettingStatus.loading) {
                  return Loading.defaultLoading(context);
                }
                return LemonOutlineButton(
                  radius: BorderRadius.circular(LemonRadius.button),
                  backgroundColor: LemonColor.white87,
                  textColor: colorScheme.primary,
                  onTap: () {
                    Vibrate.feedback(FeedbackType.light);
                    context.read<EventApplicationFormProfileSettingBloc>().add(
                          EventApplicationFormProfileSettingBlocEvent.submit(),
                        );
                  },
                  label: t.common.actions.save,
                );
              },
            ),
            SizedBox(width: Spacing.small),
          ],
          backgroundColor: LemonColor.atomicBlack,
        ),
        backgroundColor: LemonColor.atomicBlack,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: AddQuestionInfoWidget(
                title: profileType == ApplicationFormProfileType.basicInfo
                    ? t.event.applicationForm.questionType.personalInfo
                    : t.event.applicationForm.questionType.socialProfile,
                description: profileType == ApplicationFormProfileType.basicInfo
                    ? t.event.applicationForm.questionType
                        .personalInfoDescription
                    : t.event.applicationForm.questionType
                        .socialProfileDescription,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: Spacing.smMedium),
            ),
            if (profileType == ApplicationFormProfileType.basicInfo)
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.small,
                ),
                sliver: SliverList.separated(
                  itemCount: basicInfoKeys.length,
                  itemBuilder: (context, index) {
                    final field = basicInfoKeys[index];
                    return EventApplicationFormProfileItem(
                      item: field,
                      isSpecialRadiusTop: index == 0,
                      isSpecialRadiusBottom: index == basicInfoKeys.length - 1,
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: Spacing.xSmall,
                  ),
                ),
              ),
            if (profileType == ApplicationFormProfileType.socialMediaInfo)
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.small,
                ),
                sliver: SliverList.separated(
                  itemCount: socialInfoKeys.length,
                  itemBuilder: (context, index) {
                    final field = socialInfoKeys[index];
                    return EventApplicationFormProfileItem(
                      item: field,
                      isSpecialRadiusTop: index == 0,
                      isSpecialRadiusBottom: index == socialInfoKeys.length - 1,
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: Spacing.xSmall,
                  ),
                ),
              ),
            SliverToBoxAdapter(
              child: SizedBox(height: Spacing.large * 4),
            ),
          ],
        ),
      ),
    );
  }
}
