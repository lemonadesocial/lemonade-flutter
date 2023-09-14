import 'package:app/core/application/profile/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/dropdown/frosted_glass_drop_down_v2.dart';
import 'package:app/core/presentation/widgets/lemon_bottom_sheet_mixin.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfilePersonalDialog extends StatelessWidget with LemonBottomSheet {
  const EditProfilePersonalDialog(
    this.bloc, {
    required this.userProfile,
    Key? key,
  }) : super(key: key);

  final User userProfile;
  final EditProfileBloc bloc;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
          return Scaffold(
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
                            initialText: userProfile.jobTitle,
                          ),
                          SizedBox(height: Spacing.smMedium),
                          LemonTextField(
                            label: t.profile.organization,
                            onChange: bloc.onOrganizationChange,
                            hintText: t.profile.hint.organization,
                            initialText: userProfile.companyName,
                          ),
                          SizedBox(height: Spacing.smMedium),
                          FrostedGlassDropDownV2(
                            label: t.profile.industry,
                            hintText: t.profile.hint.industry,
                            listItem: LemonIndustry.values
                                .map((e) => e.industry)
                                .toList(),
                            onValueChange: bloc.onIndustrySelect,
                            selectedValue:
                                bloc.state.industry ?? userProfile.industry,
                          ),
                          SizedBox(height: Spacing.smMedium),
                          LemonTextField(
                            label: t.profile.educationQualification,
                            onChange: bloc.onEducationChange,
                            initialText: userProfile.education,
                          ),
                          SizedBox(height: Spacing.smMedium),
                          FrostedGlassDropDownV2(
                            label: t.profile.gender,
                            hintText: t.profile.hint.gender,
                            listItem: LemonGender.values
                                .map((e) => e.newGender)
                                .toList(),
                            onValueChange: bloc.onGenderSelect,
                            selectedValue:
                                bloc.state.gender ?? userProfile.gender,
                          ),
                          SizedBox(height: Spacing.smMedium),
                          FrostedGlassDropDownV2(
                            label: t.profile.ethnicity,
                            hintText: t.profile.hint.ethnicity,
                            listItem: LemonEthnicity.values
                                .map((e) => e.ethnicity)
                                .toList(),
                            onValueChange: bloc.onEthnicitySelect,
                            selectedValue:
                                bloc.state.ethnicity ?? userProfile.ethnicity,
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
                    ),
                  ),
                  SizedBox(height: Spacing.smMedium),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
