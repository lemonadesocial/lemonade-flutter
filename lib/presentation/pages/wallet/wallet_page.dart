import 'package:app/theme/color.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LemonColor.black,
      body: const Center(
        child: Text('Wallet'),
      ),
    );
  }
}
