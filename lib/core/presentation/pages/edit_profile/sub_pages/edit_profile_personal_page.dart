import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/profile/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/domain/post/post_repository.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_field_item.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/dropdown/frosted_glass_drop_down_v2.dart';
import 'package:app/core/presentation/widgets/lemon_bottom_sheet_mixin.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/service/post/post_service.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:app/core/utils/date_utils.dart' as date_utils;

class EditProfilePersonalDialog extends StatefulWidget with LemonBottomSheet {
  final User userProfile;
  const EditProfilePersonalDialog({super.key, required this.userProfile});

  @override
  EditProfilePersonalDialogState createState() =>
      EditProfilePersonalDialogState();
}

class EditProfilePersonalDialogState extends State<EditProfilePersonalDialog> {
  final bloc = EditProfileBloc(
    getIt<UserRepository>(),
    PostService(getIt<PostRepository>()),
  );

  @override
  void initState() {
    super.initState();
    if (widget.userProfile.dateOfBirth != null) {
      bloc.birthDayCtrl.text =
          DateFormat(date_utils.DateUtils.dateFormatDayMonthYear)
              .format(widget.userProfile.dateOfBirth!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return BlocProvider(
      create: (context) => bloc,
      child: BlocConsumer<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state.status == EditProfileStatus.success) {
            context.read<AuthBloc>().add(const AuthEvent.refreshData());
            SnackBarUtils.showSuccessSnackbar(t.profile.editProfileSuccess);
            bloc.clearState();
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: LemonAppBar(
                backgroundColor: colorScheme.onPrimaryContainer,
              ),
              backgroundColor: colorScheme.onPrimaryContainer,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.profile.personalInfo,
                              style: Typo.extraLarge.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: Spacing.superExtraSmall),
                            Text(
                              t.profile.personalInfoLongDesc,
                              style: Typo.mediumPlus.copyWith(
                                color: colorScheme.onPrimary.withOpacity(0.56),
                              ),
                            ),
                            SizedBox(height: Spacing.smMedium),
                            EditProfileFieldItem(
                              profileFieldKey: ProfileFieldKey.jobTitle,
                              onChange: bloc.onJobTitleChange,
                              value: widget.userProfile.jobTitle,
                            ),
                            SizedBox(height: Spacing.smMedium),
                            EditProfileFieldItem(
                              profileFieldKey: ProfileFieldKey.companyName,
                              onChange: bloc.onOrganizationChange,
                              value: widget.userProfile.companyName,
                            ),
                            SizedBox(height: Spacing.smMedium),
                            FrostedGlassDropDownV2(
                              label: t.profile.industry,
                              hintText: t.profile.hint.industry,
                              listItem: LemonIndustry.values
                                  .map((e) => e.industry)
                                  .toList(),
                              onValueChange: bloc.onIndustrySelect,
                              selectedValue: bloc.state.industry ??
                                  widget.userProfile.industry,
                            ),
                            SizedBox(height: Spacing.smMedium),
                            EditProfileFieldItem(
                              profileFieldKey: ProfileFieldKey.educationTitle,
                              onChange: bloc.onOrganizationChange,
                              value: widget.userProfile.education,
                            ),
                            SizedBox(height: Spacing.smMedium),
                            EditProfileFieldItem(
                              profileFieldKey: ProfileFieldKey.newGender,
                              onChange: bloc.onGenderSelect,
                              value: bloc.state.gender ??
                                  widget.userProfile.gender,
                            ),
                            SizedBox(height: Spacing.smMedium),
                            Focus(
                              child: EditProfileFieldItem(
                                controller: bloc.birthDayCtrl,
                                profileFieldKey: ProfileFieldKey.dateOfBirth,
                                onChange: (value) {
                                  bloc.birthDayCtrl.text = value;
                                },
                                onDateSelect: (selectedDate) {
                                  bloc.birthDayCtrl.text =
                                      date_utils.DateUtils.toLocalDateString(
                                    selectedDate,
                                  );
                                  bloc.onBirthdayChange(selectedDate);
                                },
                                value:
                                    widget.userProfile.dateOfBirth.toString(),
                              ),
                              onFocusChange: (hasFocus) {
                                if (!hasFocus) {
                                  // Handle when on blur input
                                  bloc.birthDayCtrl.text =
                                      date_utils.DateUtils.toLocalDateString(
                                    date_utils.DateUtils.parseDateString(
                                      bloc.birthDayCtrl.text,
                                    ),
                                  );
                                  bloc.onBirthdayChange(
                                    date_utils.DateUtils.parseDateString(
                                      (bloc.birthDayCtrl.text),
                                    ),
                                  );
                                }
                              },
                            ),
                            SizedBox(height: Spacing.smMedium),
                            EditProfileFieldItem(
                              profileFieldKey: ProfileFieldKey.ethnicity,
                              onChange: bloc.onEthnicitySelect,
                              value: bloc.state.ethnicity ??
                                  widget.userProfile.ethnicity,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: Spacing.smMedium),
                      child: LinearGradientButton(
                        onTap: bloc.editProfile,
                        label: t.profile.saveChanges,
                        textStyle: Typo.medium.copyWith(
                          fontFamily: FontFamily.nohemiVariable,
                          fontWeight: FontWeight.w600,
                        ),
                        height: Sizing.large,
                        radius: BorderRadius.circular(LemonRadius.large),
                        mode: GradientButtonMode.lavenderMode,
                        loadingWhen:
                            bloc.state.status == EditProfileStatus.loading,
                      ),
                    ),
                    SizedBox(height: Spacing.smMedium),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget statusWidget(BuildContext context) {
    final t = Translations.of(context);
    return Row(
      children: [
        const Icon(
          Icons.info_outline,
          color: LemonColor.errorRedBg,
        ),
        SizedBox(width: Spacing.superExtraSmall),
        Text(
          t.profile.errorDateTimeFormat,
          style: Typo.small.copyWith(color: LemonColor.errorRedBg),
        ),
      ],
    );
  }
}
