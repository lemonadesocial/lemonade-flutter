import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/lens/lens_auth_bloc/lens_auth_bloc.dart';
import 'package:app/core/domain/lens/entities/lens_lemonade_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LensLemonadeProfileBuilder extends StatefulWidget {
  final Widget Function(LensLemonadeProfile) builder;
  const LensLemonadeProfileBuilder({
    super.key,
    required this.builder,
  });

  @override
  State<LensLemonadeProfileBuilder> createState() =>
      _LensLemonadeProfileBuilderState();
}

class _LensLemonadeProfileBuilderState
    extends State<LensLemonadeProfileBuilder> {
  @override
  Widget build(BuildContext context) {
    final lensAccount = context.watch<LensAuthBloc>().state.selectedAccount;
    final lemonadeAccount = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (account) => account,
        );
    final profile = LensLemonadeProfile.fromLensAndLemonadeAccount(
      lensAccount: lensAccount,
      lemonadeAccount: lemonadeAccount,
    );
    return widget.builder(profile);
  }
}
