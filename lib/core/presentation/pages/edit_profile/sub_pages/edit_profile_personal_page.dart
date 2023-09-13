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
                    SizedBox(height: Spacing.smMedium),
                    LemonTextField(
                      label: t.profile.jobTitle,
                      onChange: (value) {},
                      hintText: 'Senior engineer',
                    ),
                    SizedBox(height: Spacing.smMedium),
                    LemonTextField(
                      label: t.profile.organization,
                      onChange: (value) {},
                    ),
                    SizedBox(height: Spacing.smMedium),
                    FrostedGlassDropDownV2(
                      label: t.profile.industry,
                      hintText: 'Select industry',
                      listItem: const [
                        'Artist',
                        'Programing',
                        'Artist',
                        'Programing',
                        'Artist',
                        'Programing',
                        'Artist',
                        'Programing',
                        'Artist',
                        'Programing',
                        'Artist',
                        'Programing',
                        'Artist',
                        'Programing'
                      ],
                      onValueChange: (value) {},
                    ),
                    SizedBox(height: Spacing.smMedium),
                    LemonTextField(
                      label: t.profile.organization,
                      onChange: (value) {},
                    ),
                    SizedBox(height: Spacing.smMedium),
                    FrostedGlassDropDownV2(
                      label: t.profile.gender,
                      hintText: 'Select gender',
                      listItem: const ['Artist', 'Programing'],
                      onValueChange: (value) {},
                    ),
                    SizedBox(height: Spacing.smMedium),
                    FrostedGlassDropDownV2(
                      label: t.profile.ethnicity,
                      hintText: 'Select ethnicity',
                      listItem: const ['Artist', 'Programing'],
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
