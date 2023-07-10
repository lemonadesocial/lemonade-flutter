import 'package:app/theme/color.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LemonColor.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Wallet'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                throw Exception('Test crash!');
              },
              child: Text('Test crash'),
            ),
          ],
        ),
      ),
    );
  }
}