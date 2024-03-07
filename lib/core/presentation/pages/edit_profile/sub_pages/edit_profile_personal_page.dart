import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/profile/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:app/core/data/user/dtos/user_query.dart';
import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/domain/post/post_repository.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/dropdown/frosted_glass_drop_down_v2.dart';
import 'package:app/core/presentation/widgets/lemon_bottom_sheet_mixin.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/service/post/post_service.dart';
import 'package:app/core/utils/calendar_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/text_formatter/date_text_formatter.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

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
          DateFormat('dd/MM/yyyy').format(widget.userProfile.dateOfBirth!);
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
                            LemonTextField(
                              label: t.profile.jobTitle,
                              onChange: bloc.onJobTitleChange,
                              hintText: t.profile.hint.jobTitle,
                              initialText: widget.userProfile.jobTitle,
                            ),
                            SizedBox(height: Spacing.smMedium),
                            LemonTextField(
                              label: t.profile.organization,
                              onChange: bloc.onOrganizationChange,
                              hintText: t.profile.hint.organization,
                              initialText: widget.userProfile.companyName,
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
                            LemonTextField(
                              label: t.profile.educationQualification,
                              onChange: bloc.onEducationChange,
                              initialText: widget.userProfile.education,
                            ),
                            SizedBox(height: Spacing.smMedium),
                            FrostedGlassDropDownV2(
                              label: t.profile.gender,
                              hintText: t.profile.hint.gender,
                              listItem: LemonGender.values
                                  .map((e) => e.newGender)
                                  .toList(),
                              onValueChange: bloc.onGenderSelect,
                              selectedValue: bloc.state.gender ??
                                  widget.userProfile.gender,
                            ),
                            SizedBox(height: Spacing.smMedium),
                            LemonTextField(
                              label: t.profile.dob,
                              onChange: bloc.onBirthdayChange,
                              controller: bloc.birthDayCtrl,
                              hintText: t.profile.hint.dob,
                              inputFormatters: [
                                CustomDateTextFormatter(),
                                LengthLimitingTextInputFormatter(10),
                              ],
                              suffixIcon: InkWell(
                                onTap: () => showCalendar(
                                  context,
                                  onDateSelect: (selectedDate) =>
                                      bloc.onBirthdayChange(
                                    DateFormat(dateFormat).format(
                                      selectedDate,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  width: 36.w,
                                  height: 36.w,
                                  margin:
                                      EdgeInsets.only(right: Spacing.xSmall),
                                  padding: EdgeInsets.all(9.w),
                                  decoration: BoxDecoration(
                                    color:
                                        colorScheme.onPrimary.withOpacity(0.09),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: LemonColor.shadow5b,
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Assets.icons.icCalendar.svg(),
                                ),
                              ),
                            ),
                            SizedBox(height: Spacing.smMedium),
                            FrostedGlassDropDownV2(
                              label: t.profile.ethnicity,
                              hintText: t.profile.hint.ethnicity,
                              listItem: LemonEthnicity.values
                                  .map((e) => e.ethnicity)
                                  .toList(),
                              onValueChange: bloc.onEthnicitySelect,
                              selectedValue: bloc.state.ethnicity ??
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

  final dateFormat = 'dd/MM/yyyy';
}
