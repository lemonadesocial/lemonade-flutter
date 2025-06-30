import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/lens/lens_auth_bloc/lens_auth_bloc.dart';
import 'package:app/core/application/lens/update_lens_account_bloc/update_lens_account_bloc.dart';
import 'package:app/core/domain/lens/entities/lens_account.dart';
import 'package:app/core/domain/lens/entities/lens_lemonade_profile.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/service/lens/lens_grove_service/lens_grove_service.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AutoSyncLensLemonadeProfileWidget extends StatelessWidget {
  const AutoSyncLensLemonadeProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateLensAccountBloc(
        getIt<LensGroveService>(),
      ),
      child: const AutoSyncLensLemonadeProfileWidgetView(),
    );
  }
}

class AutoSyncLensLemonadeProfileWidgetView extends StatelessWidget {
  const AutoSyncLensLemonadeProfileWidgetView({
    super.key,
  });

  Future<void> _handleSync(
    BuildContext context, {
    required LensAccount lensAccount,
    required User lemonadeAccount,
  }) async {
    // handle update lemonade profile
    final lensLemonadeProfile = LensLemonadeProfile.fromLensAndLemonadeAccount(
      lensAccount: lensAccount,
      lemonadeAccount: lemonadeAccount,
    );

    final newUser = (await getIt<UserRepository>().updateUser(
      input: Input$UserInput(
        name: lensLemonadeProfile.name,
        description: lensLemonadeProfile.description,
        website: lensLemonadeProfile.website,
        job_title: lensLemonadeProfile.jobTitle,
        company_name: lensLemonadeProfile.companyName,
        pronoun: lensLemonadeProfile.pronoun,
        handle_twitter: lensLemonadeProfile.handleTwitter,
        handle_farcaster: lensLemonadeProfile.handleFarcaster,
        handle_instagram: lensLemonadeProfile.handleInstagram,
        handle_github: lensLemonadeProfile.handleGithub,
        handle_linkedin: lensLemonadeProfile.handleLinkedin,
        calendly_url: lensLemonadeProfile.calendlyUrl,
      ),
    ))
        .fold(
      (failure) => null,
      (user) => user,
    );
    if (newUser == null) {
      return;
    }
    context.read<AuthBloc>().add(const AuthEvent.refreshData());
    final newLensLemonadeProfile = LensLemonadeProfile(
      name: lensLemonadeProfile.name,
      imageAvatar: lensLemonadeProfile.imageAvatar,
      description: lensLemonadeProfile.description,
      website: lensLemonadeProfile.website,
      jobTitle: lensLemonadeProfile.jobTitle,
      companyName: lensLemonadeProfile.companyName,
      pronoun: lensLemonadeProfile.pronoun,
      handleTwitter: lensLemonadeProfile.handleTwitter,
      handleFarcaster: lensLemonadeProfile.handleFarcaster,
      handleInstagram: lensLemonadeProfile.handleInstagram,
      handleGithub: lensLemonadeProfile.handleGithub,
      handleLinkedin: lensLemonadeProfile.handleLinkedin,
      calendlyUrl: lensLemonadeProfile.calendlyUrl,
    );
    context.read<UpdateLensAccountBloc>().add(
          UpdateLensAccountEvent.requestUpdateLensAccount(
            lensLemonadeProfile: newLensLemonadeProfile,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final lemonadeProfile = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (account) => account,
        );
    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateLensAccountBloc, UpdateLensAccountState>(
          listener: (context, state) {
            if (state is UpdateLensAccountSuccess) {
              context
                  .read<LensAuthBloc>()
                  .add(const LensAuthEvent.requestAvailableAccount());
            }
          },
        ),
        BlocListener<LensAuthBloc, LensAuthState>(
          listenWhen: (previous, current) =>
              previous.selectedAccount?.address !=
              current.selectedAccount?.address,
          listener: (context, state) async {
            if (state.selectedAccount == null) {
              return;
            }
            if (lemonadeProfile == null) {
              return;
            }
            _handleSync(
              context,
              lensAccount: state.selectedAccount!,
              lemonadeAccount: lemonadeProfile,
            );
          },
        ),
      ],
      child: const SizedBox.shrink(),
    );
  }
}
