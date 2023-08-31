import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/profile/user_profile_bloc/user_profile_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/pages/profile/views/profile_page_view.dart';
import 'package:app/injection/register_module.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  _walletBlocProviderBuilder({required Widget child}) {
    return BlocProvider(create: (context) => WalletBloc()..add(const WalletEventInitWalletConnect()), child: child);
  }

  _profileBlocProviderBuilder({required Widget Function(BuildContext context, String userId) builder}) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        final userId = authState.maybeWhen(
          authenticated: (authSession) => authSession.userId,
          orElse: () => '',
        );
        return BlocProvider(
          create: (context) => UserProfileBloc(getIt<UserRepository>())
            ..add(
              UserProfileEvent.fetch(userId: userId),
            ),
          child: builder(context, userId),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _profileBlocProviderBuilder(builder: (context, userId) {
      return _walletBlocProviderBuilder(
        child: ProfilePageView(userId: userId),
      );
    });
  }
}
