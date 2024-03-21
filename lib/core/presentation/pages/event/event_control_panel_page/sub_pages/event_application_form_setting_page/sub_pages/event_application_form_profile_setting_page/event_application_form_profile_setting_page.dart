import 'package:app/core/application/event/event_application_form_profile_setting_bloc/event_application_form_profile_setting_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_application_form_setting_page/sub_pages/event_application_form_profile_setting_page/widgets/event_application_form_profile_item.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_bottom_sheet_mixin.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
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

@RoutePage()
class EventApplicationFormProfileSettingPage extends StatelessWidget
    with LemonBottomSheet {
  EventApplicationFormProfileSettingPage({
    super.key,
    required this.event,
  });
  final Event? event;

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
      ProfileFieldKey.displayName,
      ProfileFieldKey.pronoun,
      ProfileFieldKey.tagline,
      ProfileFieldKey.description,
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
    List<ProfileFieldKey> personalInfoKeys = [
      ProfileFieldKey.companyName,
      ProfileFieldKey.jobTitle,
      ProfileFieldKey.industry,
      ProfileFieldKey.dateOfBirth,
      ProfileFieldKey.educationTitle,
      ProfileFieldKey.newGender,
      ProfileFieldKey.ethnicity,
    ];
    final getEventDetailBloc = context.read<GetEventDetailBloc>();
    return BlocProvider(
      create: (context) => EventApplicationFormProfileSettingBloc(
        initialProfileFields: event?.applicationProfileFields ?? [],
      ),
      child: Scaffold(
        appBar: LemonAppBar(
          title: t.event.applicationForm.profileInfo,
          backgroundColor: LemonColor.atomicBlack,
        ),
        backgroundColor: LemonColor.atomicBlack,
        body: BlocListener<EventApplicationFormProfileSettingBloc,
            EventApplicationFormProfileSettingBlocState>(
          listener: (context, state) {
            if (state.status ==
                EventApplicationFormProfileSettingStatus.success) {
              SnackBarUtils.showSuccessSnackbar(
                t.event.applicationForm.updateApplicationFormSuccessfully,
              );
              getEventDetailBloc.add(
                GetEventDetailEvent.fetch(
                  eventId: event?.id ?? '',
                ),
              );
              AutoRouter.of(context).pop();
            }
          },
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(height: Spacing.smMedium),
                    ),
                    SliverList.separated(
                      itemCount: basicInfoKeys.length,
                      itemBuilder: (context, index) {
                        final field = basicInfoKeys[index];
                        return EventApplicationFormProfileItem(
                          item: field,
                          isSpecialRadiusTop: index == 0,
                          isSpecialRadiusBottom:
                              index == basicInfoKeys.length - 1,
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: Spacing.superExtraSmall,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: Spacing.large),
                    ),
                    SliverList.separated(
                      itemCount: socialInfoKeys.length,
                      itemBuilder: (context, index) {
                        final field = socialInfoKeys[index];
                        return EventApplicationFormProfileItem(
                          item: field,
                          isSpecialRadiusTop: index == 0,
                          isSpecialRadiusBottom:
                              index == socialInfoKeys.length - 1,
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: Spacing.superExtraSmall,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: Spacing.large),
                    ),
                    SliverList.separated(
                      itemCount: personalInfoKeys.length,
                      itemBuilder: (context, index) {
                        final field = personalInfoKeys[index];
                        return EventApplicationFormProfileItem(
                          item: field,
                          isSpecialRadiusTop: index == 0,
                          isSpecialRadiusBottom:
                              index == personalInfoKeys.length - 1,
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: Spacing.superExtraSmall,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: Spacing.large * 4),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: LemonColor.atomicBlack,
                    border: Border(
                      top: BorderSide(
                        color: colorScheme.outline,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.all(Spacing.smMedium),
                  child: SafeArea(
                    child: BlocBuilder<EventApplicationFormProfileSettingBloc,
                        EventApplicationFormProfileSettingBlocState>(
                      builder: (context, state) =>
                          LinearGradientButton.primaryButton(
                        onTap: () {
                          Vibrate.feedback(FeedbackType.light);
                          context
                              .read<EventApplicationFormProfileSettingBloc>()
                              .add(
                                EventApplicationFormProfileSettingBlocEvent
                                    .submit(eventId: event?.id ?? ''),
                              );
                        },
                        label: t.common.confirm,
                        textColor: colorScheme.onPrimary,
                        loadingWhen: state.status ==
                            EventApplicationFormProfileSettingStatus.loading,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
