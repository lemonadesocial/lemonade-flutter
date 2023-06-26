import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGuard extends StatelessWidget {
  final Widget Function(BuildContext context) authenticatedBuilder;
  final Widget Function(BuildContext context) unauthenticatedBuilder;
  const AuthGuard({
    super.key,
    required this.authenticatedBuilder,
    required this.unauthenticatedBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return state.when(
        unknown: () => const AuthLoadingView(),
        authenticated: () => authenticatedBuilder(context),
        unauthenticated: (isValidating) => unauthenticatedBuilder(context),
      );
    });
  }
}

class AuthLoadingView extends StatelessWidget {
  const AuthLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
