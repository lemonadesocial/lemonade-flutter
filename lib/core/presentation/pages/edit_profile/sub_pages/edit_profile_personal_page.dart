import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/profile/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_field_item.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/dropdown/frosted_glass_drop_down_v2.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/utils/date_utils.dart' as date_utils;
import 'package:intl/intl.dart';

class EditProfilePersonalDialog extends StatefulWidget {
  final User? userProfile;
  const EditProfilePersonalDialog({super.key, required this.userProfile});

  @override
  EditProfilePersonalDialogState createState() =>
      EditProfilePersonalDialogState();
}

class EditProfilePersonalDialogState extends State<EditProfilePersonalDialog> {
  final birthDayCtrl = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.userProfile?.dateOfBirth != null) {
      birthDayCtrl.text =
          DateFormat(date_utils.DateUtils.dateFormatDayMonthYear)
              .format(widget.userProfile!.dateOfBirth!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state.status == EditProfileStatus.success) {
          AutoRouter.of(context).pop();
          context.read<AuthBloc>().add(const AuthEvent.refreshData());
          SnackBarUtils.showSuccess(message: t.profile.editProfileSuccess);
          context.read<EditProfileBloc>().add(EditProfileEvent.clearState());
        }
      },
      child: BlocBuilder<EditProfileBloc, EditProfileState>(
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
                              onChange: (input) {
                                context.read<EditProfileBloc>().add(
                                      EditProfileEvent.jobTitleChange(
                                        input: input,
                                      ),
                                    );
                              },
                              value: widget.userProfile?.jobTitle,
                            ),
                            SizedBox(height: Spacing.smMedium),
                            EditProfileFieldItem(
                              profileFieldKey: ProfileFieldKey.companyName,
                              onChange: (input) {
                                context.read<EditProfileBloc>().add(
                                      EditProfileEvent.organizationChange(
                                        input: input,
                                      ),
                                    );
                              },
                              value: widget.userProfile?.companyName,
                            ),
                            SizedBox(height: Spacing.smMedium),
                            FrostedGlassDropDownV2(
                              label: t.profile.industry,
                              hintText: t.profile.hint.industry,
                              listItem: LemonIndustry.values
                                  .map((e) => e.industry)
                                  .toList(),
                              onValueChange: (value) {
                                context.read<EditProfileBloc>().add(
                                      EditProfileEvent.industrySelect(
                                        industry: value,
                                      ),
                                    );
                              },
                              selectedValue: state.industry ??
                                  widget.userProfile?.industry,
                            ),
                            SizedBox(height: Spacing.smMedium),
                            EditProfileFieldItem(
                              profileFieldKey: ProfileFieldKey.educationTitle,
                              onChange: (value) {
                                context.read<EditProfileBloc>().add(
                                      EditProfileEvent.educationChange(
                                        input: value,
                                      ),
                                    );
                              },
                              value: widget.userProfile?.educationTitle,
                            ),
                            SizedBox(height: Spacing.smMedium),
                            EditProfileFieldItem(
                              profileFieldKey: ProfileFieldKey.newGender,
                              onChange: (value) {
                                context.read<EditProfileBloc>().add(
                                      EditProfileEvent.genderSelect(
                                        gender: value,
                                      ),
                                    );
                              },
                              value:
                                  state.gender ?? widget.userProfile?.newGender,
                            ),
                            SizedBox(height: Spacing.smMedium),
                            Focus(
                              child: EditProfileFieldItem(
                                controller: birthDayCtrl,
                                profileFieldKey: ProfileFieldKey.dateOfBirth,
                                onChange: (value) {
                                  birthDayCtrl.text = value;
                                },
                                onDateSelect: (selectedDate) {
                                  birthDayCtrl.text =
                                      date_utils.DateUtils.toLocalDateString(
                                    selectedDate,
                                  );
                                  context.read<EditProfileBloc>().add(
                                        EditProfileEvent.birthdayChange(
                                          input: selectedDate,
                                        ),
                                      );
                                },
                                value:
                                    widget.userProfile?.dateOfBirth.toString(),
                              ),
                              onFocusChange: (hasFocus) {
                                if (!hasFocus) {
                                  // Handle when on blur input
                                  birthDayCtrl.text =
                                      date_utils.DateUtils.toLocalDateString(
                                    date_utils.DateUtils.parseDateString(
                                      birthDayCtrl.text,
                                    ),
                                  );
                                  context.read<EditProfileBloc>().add(
                                        EditProfileEvent.birthdayChange(
                                          input: date_utils.DateUtils
                                              .parseDateString(
                                            (birthDayCtrl.text),
                                          ),
                                        ),
                                      );
                                }
                              },
                            ),
                            SizedBox(height: Spacing.smMedium),
                            EditProfileFieldItem(
                              profileFieldKey: ProfileFieldKey.ethnicity,
                              onChange: (value) {
                                context.read<EditProfileBloc>().add(
                                      EditProfileEvent.ethnicitySelect(
                                        ethnicity: value,
                                      ),
                                    );
                              },
                              value: state.ethnicity ??
                                  widget.userProfile?.ethnicity,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: Spacing.smMedium),
                      child: LinearGradientButton(
                        onTap: () {
                          context.read<EditProfileBloc>().add(
                                EditProfileEvent.submitEditProfile(),
                              );
                        },
                        label: t.profile.saveChanges,
                        textStyle: Typo.medium.copyWith(
                          fontFamily: FontFamily.nohemiVariable,
                          fontWeight: FontWeight.w600,
                        ),
                        height: Sizing.large,
                        radius: BorderRadius.circular(LemonRadius.large),
                        mode: GradientButtonMode.lavenderMode,
                        loadingWhen: state.status == EditProfileStatus.loading,
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
