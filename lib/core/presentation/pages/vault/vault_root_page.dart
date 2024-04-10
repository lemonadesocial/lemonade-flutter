import 'package:app/core/application/payment/get_payment_accounts_bloc/get_payment_accounts_bloc.dart';
import 'package:app/core/domain/payment/input/get_payment_accounts_input/get_payment_accounts_input.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class VaultRootPage extends StatelessWidget implements AutoRouteWrapper {
  const VaultRootPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => GetPaymentAccountsBloc()
        ..add(
          GetPaymentAccountsEvent.fetch(
            input: GetPaymentAccountsInput(
              type: PaymentAccountType.ethereum,
              provider: PaymentProvider.safe,
            ),
          ),
        ),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
