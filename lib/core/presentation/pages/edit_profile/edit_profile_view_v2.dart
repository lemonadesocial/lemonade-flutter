import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_personal_info_form/edit_profile_personal_info_form.dart';
import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_social_form/edit_profile_social_form.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_form_fields/edit_profile_text_field.dart';

class EditProfileViewV2 extends StatefulWidget {
  const EditProfileViewV2({super.key});

  @override
  State<EditProfileViewV2> createState() => _EditProfileViewV2State();
}

class _EditProfileViewV2State extends State<EditProfileViewV2> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    return Scaffold(
      appBar: LemonAppBar(title: t.profile.editProfile),
      body: ListView(
        children: [
          CupertinoListSection.insetGrouped(
            backgroundColor: appColors.pageBg,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.md),
              color: appColors.buttonTertiaryBg,
              border: Border.all(color: appColors.cardBorder),
            ),
            children: [
              EditProfileTextField(
                label: "Display Name",
                onChange: (input) {},
              ),
            ],
          ),
          CupertinoListSection.insetGrouped(
            backgroundColor: appColors.pageBg,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.md),
              color: appColors.buttonTertiaryBg,
              border: Border.all(color: appColors.cardBorder),
            ),
            header: Text(
              "Bio",
              style: appText.sm.copyWith(
                color: appColors.textTertiary,
              ),
            ),
            children: [
              EditProfileTextField(
                label: "",
                placeholder:
                    "Share a little about your background and interests.",
                onChange: (input) {},
              ),
            ],
          ),
          const EditProfileSocialForm(),
          const EditProfilePersonalInfoForm(),
        ],
      ),
    );
  }
}
