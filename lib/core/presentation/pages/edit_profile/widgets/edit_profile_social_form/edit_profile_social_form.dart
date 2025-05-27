import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_form_fields/edit_profile_text_field.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/cupertino.dart';

class EditProfileSocialForm extends StatelessWidget {
  const EditProfileSocialForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    return CupertinoListSection.insetGrouped(
      header: Text(
        "Social handles",
        style: appText.sm.copyWith(
          color: appColors.textTertiary,
        ),
      ),
      backgroundColor: appColors.pageBg,
      separatorColor: appColors.pageDivider,
      dividerMargin: 0,
      additionalDividerMargin: 0,
      hasLeading: true,
      topMargin: 0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LemonRadius.md),
        color: appColors.buttonTertiaryBg,
        border: Border.all(color: appColors.cardBorder),
      ),
      children: [
        EditProfileTextField(
          icon: Assets.icons.icXLine,
          label: "X(Twitter)",
          onChange: (input) {},
          maxLines: 1,
        ),
        EditProfileTextField(
          icon: Assets.icons.icLinkedin,
          label: "LinkedIn",
          onChange: (input) {},
          maxLines: 1,
        ),
        EditProfileTextField(
          icon: Assets.icons.icInstagram,
          label: "Instagram",
          onChange: (input) {},
          maxLines: 1,
        ),
        EditProfileTextField(
          icon: Assets.icons.icGithubFilled,
          label: "Github",
          onChange: (input) {},
          maxLines: 1,
        ),
        EditProfileTextField(
          icon: Assets.icons.icLensFilled,
          label: "Lens",
          onChange: (input) {},
          maxLines: 1,
        ),
        EditProfileTextField(
          icon: Assets.icons.icGlobe,
          label: "Website",
          onChange: (input) {},
          maxLines: 1,
        ),
      ],
    );
  }
}
