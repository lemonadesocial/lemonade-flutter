import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/lens/lens_auth_bloc/lens_auth_bloc.dart';
import 'package:app/core/application/lens/update_lens_account_bloc/update_lens_account_bloc.dart';
import 'package:app/core/application/profile/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:app/core/domain/lens/entities/lens_lemonade_profile.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_personal_info_form/edit_profile_personal_info_form.dart';
import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_social_form/edit_profile_social_form.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/service/lens/lens_grove_service/lens_grove_service.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_form_fields/edit_profile_text_field.dart';
import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_avatar.dart';
import 'package:app/core/utils/permission_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';

class EditProfilePageV2 extends StatelessWidget {
  const EditProfilePageV2({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EditProfileBloc(),
        ),
        BlocProvider(
          create: (context) => UpdateLensAccountBloc(
            getIt<LensGroveService>(),
          ),
        ),
      ],
      child: const EditProfileViewV2(),
    );
  }
}

class EditProfileViewV2 extends StatefulWidget {
  const EditProfileViewV2({super.key});

  @override
  State<EditProfileViewV2> createState() => _EditProfileViewV2State();
}

class _EditProfileViewV2State extends State<EditProfileViewV2> {
  late final TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _bioController = TextEditingController();
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final lensAuthState = context.watch<LensAuthBloc>().state;
    final lensAccount = context.watch<LensAuthBloc>().state.selectedAccount;
    final lemonadeAccount = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
        );
    final userProfile = LensLemonadeProfile.fromLensAndLemonadeAccount(
      lensAccount: lensAccount,
      lemonadeAccount: lemonadeAccount,
    );
    final isLoading = context.watch<EditProfileBloc>().state.status ==
            EditProfileStatus.loading ||
        context.watch<UpdateLensAccountBloc>().state
            is UpdateLensAccountLoading;

    return MultiBlocListener(
      listeners: [
        BlocListener<EditProfileBloc, EditProfileState>(
          listener: (context, state) async {
            if (state.status == EditProfileStatus.success) {
              context.read<AuthBloc>().add(const AuthEvent.refreshData());
              if (!lensAuthState.loggedIn) {
                SnackBarUtils.showSuccess(
                  message: t.profile.editProfileSuccess,
                );
                return;
              }
              final user = (await getIt<UserRepository>().getMe())
                  .fold((l) => null, (r) => r);
              final newLensLemonadeProfile = LensLemonadeProfile(
                name: user?.displayName,
                imageAvatar: user?.imageAvatar,
                description: user?.description,
                website: user?.website,
                jobTitle: user?.jobTitle,
                companyName: user?.companyName,
                pronoun: user?.pronoun,
                handleTwitter: user?.handleTwitter,
                handleFarcaster: user?.handleFarcaster,
                handleInstagram: user?.handleInstagram,
                handleGithub: user?.handleGithub,
                handleLinkedin: user?.handleLinkedin,
                handleMirror: user?.handleMirror,
                calendlyUrl: user?.calendlyUrl,
              );
              context.read<UpdateLensAccountBloc>().add(
                    UpdateLensAccountEvent.requestUpdateLensAccount(
                      lensLemonadeProfile: newLensLemonadeProfile,
                    ),
                  );
            }
          },
        ),
        BlocListener<UpdateLensAccountBloc, UpdateLensAccountState>(
          listener: (context, state) {
            if (state is UpdateLensAccountSuccess) {
              SnackBarUtils.showSuccess(message: t.profile.editProfileSuccess);
              context
                  .read<LensAuthBloc>()
                  .add(const LensAuthEvent.requestAvailableAccount());
            } else if (state is UpdateLensAccountFailed) {
              SnackBarUtils.showError(message: state.failure.message);
            }
          },
        ),
      ],
      child: BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, editState) {
          String getValue(String? stateValue, String? profileValue) =>
              (stateValue != null && stateValue.isNotEmpty)
                  ? stateValue
                  : (profileValue ?? '');

          final bioValue =
              getValue(editState.shortBio, userProfile.description);
          if (_bioController.text != bioValue) {
            _bioController.text = bioValue;
            _bioController.selection = TextSelection.fromPosition(
              TextPosition(offset: _bioController.text.length),
            );
          }

          return Scaffold(
            appBar: LemonAppBar(
              title: t.profile.editProfile,
              actions: [
                BlocBuilder<EditProfileBloc, EditProfileState>(
                  builder: (context, state) {
                    if (isLoading) {
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
                              FocusScope.of(context).unfocus();
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
              behavior: HitTestBehavior.translucent,
              onTap: () => FocusScope.of(context).unfocus(),
              child: ListView(
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
                                user: lemonadeAccount,
                                imageFile: state.profilePhoto,
                                imageUrl: userProfile.imageAvatar,
                              );
                            },
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: InkWell(
                              onTap: () async {
                                // TODO: Cannot yet sync avatar between lens and lemonade
                                final profilePhotos =
                                    (lemonadeAccount?.newPhotosExpanded ?? [])
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
                  CupertinoListSection.insetGrouped(
                    backgroundColor: appColors.pageBg,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(LemonRadius.md),
                      color: appColors.buttonTertiaryBg,
                      border: Border.all(color: appColors.cardBorder),
                    ),
                    children: [
                      EditProfileTextField(
                        label: t.profile.displayName,
                        initialValue: getValue(
                          editState.displayName,
                          userProfile.name,
                        ),
                        onChange: (input) =>
                            context.read<EditProfileBloc>().add(
                                  EditProfileEvent.displayNameChange(
                                    input: input,
                                  ),
                                ),
                      ),
                    ],
                  ),
                  SizedBox(height: Spacing.s4_5),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.s4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.profile.bio,
                          style: appText.sm.copyWith(
                            color: appColors.textTertiary,
                          ),
                        ),
                        SizedBox(height: Spacing.s2),
                        Container(
                          decoration: BoxDecoration(
                            color: appColors.buttonTertiaryBg,
                            borderRadius: BorderRadius.circular(LemonRadius.md),
                            border: Border.all(color: appColors.cardBorder),
                          ),
                          child: TextField(
                            controller: _bioController,
                            onChanged: (value) =>
                                context.read<EditProfileBloc>().add(
                                      EditProfileEvent.shortBioChange(
                                        input: value,
                                      ),
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
                      ],
                    ),
                  ),
                  SizedBox(height: Spacing.s4),
                  EditProfileSocialForm(
                    userProfile: userProfile,
                    editState: editState,
                  ),
                  EditProfilePersonalInfoForm(
                    userProfile: userProfile,
                    editState: editState,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
