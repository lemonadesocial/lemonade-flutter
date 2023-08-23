
import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _ProfileAuthGuardItem extends StatelessWidget {
  const _ProfileAuthGuardItem({
    required this.authenticatedChild,
    required this.unauthenticatedChild,
    required this.processingChild,
  });

  final Widget authenticatedChild;
  final Widget unauthenticatedChild;
  final Widget processingChild;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return authState.when(
          authenticated: (_) {
            return authenticatedChild;
          },
          unauthenticated: (_) => unauthenticatedChild,
          unknown: () => unauthenticatedChild,
          processing: () => processingChild,
        );
      },
    );
  }
}
