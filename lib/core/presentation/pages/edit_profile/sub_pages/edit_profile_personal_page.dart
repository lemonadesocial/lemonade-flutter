import 'dart:ffi';

import 'package:app/core/presentation/pages/edit_profile/widgets/dropdown_widget.dart';
import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_social_tile.dart';
import 'package:app/core/presentation/pages/edit_profile/widgets/profile_textfield_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_bottom_sheet_mixin.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class EditProfilePersonalDialog extends StatelessWidget with LemonBottomSheet {
  const EditProfilePersonalDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
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
                    ProfileTextFieldWidget(
                      label: t.profile.jobTitle,
                      onChange: (value) {},
                      hintText: 'Senior engineer',
                    ),
                    ProfileTextFieldWidget(
                      label: t.profile.organization,
                      onChange: (value) {},
                    ),
                    DropdownWidget(
                      label: t.profile.industry,
                      hintText: 'Select industry',
                      listItem: ['Artist', 'Programing'],
                      onValueChange: (value) {},
                    ),
                    ProfileTextFieldWidget(
                      label: t.profile.organization,
                      onChange: (value) {},
                    ),
                    DropdownWidget(
                      label: t.profile.gender,
                      hintText: 'Select gender',
                      listItem: ['Artist', 'Programing'],
                      onValueChange: (value) {},
                    ),
                    DropdownWidget(
                      label: t.profile.ethnicity,
                      hintText: 'Select ethnicity',
                      listItem: ['Artist', 'Programing'],
                      onValueChange: (value) {},
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: Spacing.smMedium),
              child: LinearGradientButton(
                onTap: () {},
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
  }
}
