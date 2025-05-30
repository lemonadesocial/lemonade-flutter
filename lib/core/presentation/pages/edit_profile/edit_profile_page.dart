import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/profile/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:app/core/presentation/pages/edit_profile/edit_profile_view_v2.dart';
import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_avatar.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/permission_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

@RoutePage()
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileBloc(),
      child: const EditProfileViewV2(),
    );
  }
}

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final t = Translations.of(context);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final userProfile = state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
        );
        return BlocListener<EditProfileBloc, EditProfileState>(
          listener: (context, state) {
            if (state.status == EditProfileStatus.success) {
              context.read<AuthBloc>().add(const AuthEvent.refreshData());
              SnackBarUtils.showSuccess(message: t.profile.editProfileSuccess);
              context
                  .read<EditProfileBloc>()
                  .add(EditProfileEvent.clearState());
            }
          },
          child: Scaffold(
            backgroundColor: appColors.pageBg,
            appBar: LemonAppBar(
              title: t.profile.editProfile,
              actions: [
                BlocBuilder<EditProfileBloc, EditProfileState>(
                  builder: (context, state) {
                    if (state.status == EditProfileStatus.loading) {
                      return Padding(
                        padding: EdgeInsets.only(right: Spacing.s5),
                        child: SizedBox(
                          width: Sizing.xSmall,
                          height: Sizing.xSmall,
                          child: CircularProgressIndicator(
                            backgroundColor: LemonColor.black.withOpacity(0.36),
                            color: LemonColor.white.withOpacity(0.72),
                            strokeWidth: 2.5,
                          ),
                        ),
                      );
                    }
                    return TextButton(
                      onPressed: state.status == EditProfileStatus.editing
                          ? () {
                              context.read<EditProfileBloc>().add(
                                    EditProfileEvent.submitEditProfile(),
                                  );
                            }
                          : null,
                      child: Text(
                        t.common.actions.save,
                        style: appText.md.copyWith(
                          color: state.status == EditProfileStatus.editing
                              ? appColors.textAccent
                              : appColors.textQuaternary,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: Spacing.s4),
                children: [
                  // Profile Photo Section
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: Spacing.s6),
                      child: Stack(
                        children: [
                          BlocBuilder<EditProfileBloc, EditProfileState>(
                            builder: (context, state) {
                              return EditProfileAvatar(
                                user: userProfile,
                                imageFile: state.profilePhoto,
                                imageUrl: userProfile?.imageAvatar,
                              );
                            },
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: InkWell(
                              onTap: () async {
                                final profilePhotos =
                                    (userProfile?.newPhotosExpanded ?? [])
                                        .map((item) => item.id)
                                        .whereType<String>()
                                        .toList();

                                final hasPermission =
                                    await PermissionUtils.checkPhotosPermission(
                                  context,
                                );
                                if (!hasPermission) return;
                                context.read<EditProfileBloc>().add(
                                      EditProfileEvent.selectProfileImage(
                                        profilePhotos: profilePhotos,
                                      ),
                                    );
                              },
                              child: Container(
                                padding: EdgeInsets.all(Spacing.s2),
                                decoration: BoxDecoration(
                                  color: appColors.pageOverlaySecondary,
                                  shape: BoxShape.circle,
                                ),
                                child: Assets.icons.icShare.svg(
                                  width: Sizing.s5,
                                  height: Sizing.s5,
                                  color: appColors.textSecondary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Display Name Section
                  CupertinoListSection.insetGrouped(
                    backgroundColor: appColors.pageBg,
                    separatorColor: appColors.pageDivider,
                    margin: EdgeInsets.zero,
                    hasLeading: false,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(LemonRadius.md),
                      color: appColors.cardBg,
                      border: Border.all(color: appColors.cardBorder),
                    ),
                    children: [
                      _buildEditableListTile(
                        context: context,
                        title: t.profile.displayName,
                        value: userProfile?.displayName ?? '',
                        onChanged: (value) => context
                            .read<EditProfileBloc>()
                            .add(
                              EditProfileEvent.displayNameChange(input: value),
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: Spacing.s6),
                  // Bio Section
                  Padding(
                    padding: EdgeInsets.only(left: Spacing.s1),
                    child: Text(
                      t.profile.bio,
                      style: appText.md.copyWith(
                        color: appColors.textSecondary,
                      ),
                    ),
                  ),
                  SizedBox(height: Spacing.s2),
                  Container(
                    decoration: BoxDecoration(
                      color: appColors.cardBg,
                      borderRadius: BorderRadius.circular(LemonRadius.md),
                      border: Border.all(color: appColors.cardBorder),
                    ),
                    child: TextField(
                      controller: TextEditingController(
                        text: userProfile?.description ?? '',
                      ),
                      onChanged: (value) => context.read<EditProfileBloc>().add(
                            EditProfileEvent.shortBioChange(input: value),
                          ),
                      maxLines: 3,
                      cursorColor: appColors.textPrimary,
                      style: appText.md.copyWith(
                        color: appColors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: t.profile.bioHint,
                        hintStyle: appText.md.copyWith(
                          color: appColors.textQuaternary,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: Spacing.s3_5,
                          vertical: Spacing.s2_5,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),

                  SizedBox(height: Spacing.s4),

                  // Social Handles Section
                  CupertinoListSection.insetGrouped(
                    backgroundColor: appColors.pageBg,
                    separatorColor: appColors.pageDivider,
                    margin: EdgeInsets.zero,
                    hasLeading: false,
                    header: Text(
                      t.profile.socialHandles,
                      style: appText.sm.copyWith(
                        color: appColors.textTertiary,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(LemonRadius.md),
                      color: appColors.cardBg,
                      border: Border.all(color: appColors.cardBorder),
                    ),
                    children: [
                      _buildSocialListTile(
                        context: context,
                        icon: ThemeSvgIcon(
                          color: appColors.textTertiary,
                          builder: (colorFilter) => Assets.icons.icTwitter.svg(
                            colorFilter: colorFilter,
                            width: Sizing.s6,
                            height: Sizing.s6,
                          ),
                        ),
                        title: t.profile.socials.twitter,
                        value: userProfile?.handleTwitter ?? '',
                        onChanged: (value) =>
                            context.read<EditProfileBloc>().add(
                                  EditProfileEvent.twitterChange(input: value),
                                ),
                      ),
                      _buildSocialListTile(
                        context: context,
                        icon: ThemeSvgIcon(
                          color: appColors.textTertiary,
                          builder: (colorFilter) => Assets.icons.icLinkedin.svg(
                            colorFilter: colorFilter,
                            width: Sizing.s6,
                            height: Sizing.s6,
                          ),
                        ),
                        title: t.profile.socials.linkedIn,
                        value: userProfile?.handleLinkedin ?? '',
                        placeholder: '/us/handle',
                        onChanged: (value) =>
                            context.read<EditProfileBloc>().add(
                                  EditProfileEvent.linkedinChange(input: value),
                                ),
                      ),
                      _buildSocialListTile(
                        context: context,
                        icon: ThemeSvgIcon(
                          color: appColors.textTertiary,
                          builder: (colorFilter) =>
                              Assets.icons.icInstagram.svg(
                            colorFilter: colorFilter,
                            width: Sizing.s6,
                            height: Sizing.s6,
                          ),
                        ),
                        title: t.profile.socials.instagram,
                        value: userProfile?.handleInstagram ?? '',
                        onChanged: (value) => context
                            .read<EditProfileBloc>()
                            .add(
                              EditProfileEvent.instagramChange(input: value),
                            ),
                      ),
                      _buildSocialListTile(
                        context: context,
                        icon: ThemeSvgIcon(
                          color: appColors.textTertiary,
                          builder: (colorFilter) => Assets.icons.icWarpcast.svg(
                            colorFilter: colorFilter,
                            width: Sizing.s6,
                            height: Sizing.s6,
                          ),
                        ),
                        title: t.profile.socials.warpcast,
                        value: userProfile?.handleFarcaster ?? '',
                        onChanged: (value) => context
                            .read<EditProfileBloc>()
                            .add(
                              EditProfileEvent.farcasterChange(input: value),
                            ),
                      ),
                      _buildSocialListTile(
                        context: context,
                        icon: ThemeSvgIcon(
                          color: appColors.textTertiary,
                          builder: (colorFilter) =>
                              Assets.icons.icGithubFilled.svg(
                            colorFilter: colorFilter,
                            width: Sizing.s6,
                            height: Sizing.s6,
                          ),
                        ),
                        title: t.profile.socials.github,
                        value: userProfile?.handleGithub ?? '',
                        onChanged: (value) =>
                            context.read<EditProfileBloc>().add(
                                  EditProfileEvent.githubChange(input: value),
                                ),
                      ),
                      _buildSocialListTile(
                        context: context,
                        icon: ThemeSvgIcon(
                          color: appColors.textTertiary,
                          builder: (colorFilter) =>
                              Assets.icons.icLensFilled.svg(
                            colorFilter: colorFilter,
                            width: Sizing.s6,
                            height: Sizing.s6,
                          ),
                        ),
                        title: t.profile.socials.lens,
                        value: userProfile?.handleLens ?? '',
                        onChanged: (value) =>
                            context.read<EditProfileBloc>().add(
                                  EditProfileEvent.lensChange(input: value),
                                ),
                      ),
                      _buildSocialListTile(
                        context: context,
                        icon: ThemeSvgIcon(
                          color: appColors.textTertiary,
                          builder: (colorFilter) => Assets.icons.icMirror.svg(
                            colorFilter: colorFilter,
                            width: Sizing.s6,
                            height: Sizing.s6,
                          ),
                        ),
                        title: t.profile.socials.mirror,
                        value: userProfile?.handleMirror ?? '',
                        onChanged: (value) =>
                            context.read<EditProfileBloc>().add(
                                  EditProfileEvent.mirrorChange(input: value),
                                ),
                      ),
                    ],
                  ),
                  SizedBox(height: Spacing.s16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEditableListTile({
    required BuildContext context,
    required String title,
    required String value,
    required ValueChanged<String> onChanged,
    int maxLines = 1,
    String? placeholder,
  }) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    return CupertinoListTile(
      title: Text(
        title,
        style: appText.md.copyWith(
          color: appColors.textTertiary,
        ),
      ),
      trailing: SizedBox(
        width: 200.w,
        child: TextField(
          controller: TextEditingController(text: value),
          onChanged: onChanged,
          maxLines: maxLines,
          cursorColor: appColors.textPrimary,
          style: appText.md.copyWith(
            color: appColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: appText.md.copyWith(
              color: appColors.textQuaternary,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: Spacing.s3,
              vertical: Spacing.s2,
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialListTile({
    required BuildContext context,
    required Widget icon,
    required String title,
    required String value,
    required ValueChanged<String> onChanged,
    String? placeholder,
  }) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    return CupertinoListTile(
      leading: icon,
      title: Text(
        title,
        style: appText.md.copyWith(
          color: appColors.textTertiary,
        ),
      ),
      trailing: SizedBox(
        width: 180.w,
        child: TextField(
          controller: TextEditingController(text: value),
          onChanged: onChanged,
          cursorColor: appColors.textPrimary,
          style: appText.md.copyWith(
            color: appColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: placeholder ?? 'username',
            hintStyle: appText.md.copyWith(
              color: appColors.textQuaternary,
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
