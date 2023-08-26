import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final themeColor = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: themeColor.primary,
      appBar: const LemonAppBar(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image(image: Assets.images.bgCircle.provider()),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: Assets.images.bgGetStarted.provider()),
              const SizedBox(height: 20),
              const Text(
                "Let's start",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Sign up or Login',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEvent.login());
                },
                child: const Text(
                  'Get started',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
