// import 'package:app/application/auth/auth_bloc.dart';
import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/widgets/lemon_appbar_widget.dart';
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
    return Scaffold(
        appBar: LemonAppBar(),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            state.maybeWhen(
                authenticated: (_) {
                  AutoRouter.of(context).pop();
                },
                orElse: () {});
          },
          child: Center(
            child: ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEvent.login());
                },
                child: const Text(
                  "Login",
                )),
          ),
        ));
  }
}
