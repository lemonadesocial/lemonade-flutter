import 'package:app/core/application/wallet/sign_wallet_bloc/sign_wallet_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/presentation/widgets/wallet/connect_wallet_button.dart';
import 'package:app/theme/color.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              WalletBloc()..add(const WalletEvent.initWalletConnect()),
        ),
        BlocProvider(
          create: (context) => SignWalletBloc(),
        ),
      ],
      child: const WalletPageView(),
    );
  }
}

class WalletPageView extends StatelessWidget {
  const WalletPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LemonColor.black,
      body: const Center(
        child: ConnectWalletButton(),
      ),
    );
  }
}
