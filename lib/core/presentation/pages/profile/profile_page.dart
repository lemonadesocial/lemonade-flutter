import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/guard/auth_guard.dart';
import 'package:app/core/presentation/pages/auth/login_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthGuard(
      unauthenticatedBuilder: (context) => const LoginPage(),
      authenticatedBuilder: (context) => const ProfilePageView(),
    );
  }
}

class ProfilePageView extends StatelessWidget {
  const ProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Center(
          child: ElevatedButton(
        child: const Text('Logout'),
        onPressed: () async {
          context.read<AuthBloc>().add(AuthEvent.logout());
        },
      )),
    );
  }
}
