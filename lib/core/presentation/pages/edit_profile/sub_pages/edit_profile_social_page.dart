import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_social_tile.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_bottom_sheet_mixin.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/utils/modal_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileSocialDialog extends StatelessWidget with LemonBottomSheet {
  const EditProfileSocialDialog({Key? key}) : super(key: key);

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
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.profile.socialHandle,
                      style: Typo.extraLarge,
                    ),
                    SizedBox(height: Spacing.superExtraSmall),
                    Text(
                      t.profile.socialHandleLongDesc,
                      style: Typo.mediumPlus.copyWith(
                        color: colorScheme.onPrimary.withOpacity(0.56),
                      ),
                    ),
                    SizedBox(height: Spacing.medium),
                    EditProfileSocialTile(
                      label: 'X',
                      leadingIcon: Assets.icons.icSocialX.svg(),
                      content: 'https://twitter.com/',
                      onTap: () => showComingSoonDialog(context),
                    ),
                    SizedBox(height: Spacing.medium),
                    EditProfileSocialTile(
                      label: 'LinkedIn',
                      leadingIcon: Assets.icons.icSocialLinkedin.svg(),
                      content: 'https://linkedIn.com/',
                      onTap: () => showComingSoonDialog(context),
                    ),
                    SizedBox(height: Spacing.medium),
                    EditProfileSocialTile(
                      label: 'Instagram',
                      leadingIcon: Assets.icons.icSocialInstagram.svg(),
                      content: 'https://instagram.com/',
                      onTap: () => showComingSoonDialog(context),
                    ),
                    SizedBox(height: Spacing.medium),
                    EditProfileSocialTile(
                      label: 'Facebook',
                      leadingIcon: Assets.icons.icSocialFacebook.svg(),
                      content: 'https://facebook.com/',
                      onTap: () => showComingSoonDialog(context),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: Spacing.smMedium),
              width: 1.sw,
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
