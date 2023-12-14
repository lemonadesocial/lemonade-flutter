import 'package:app/core/application/vault/create_vault_bloc/create_vault_bloc.dart';
import 'package:app/core/application/vault/create_vault_owner_key_bloc/create_vault_owner_key_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CreateVaultPage extends StatelessWidget with AutoRouteWrapper {
  const CreateVaultPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateVaultBloc(),
        ),
        BlocProvider(
          create: (context) => CreateVaultOwnerKeyBloc(),
        ),
        BlocProvider(
          create: (context) => WalletBloc()
            ..add(
              const WalletEvent.initWalletConnect(),
            ),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
