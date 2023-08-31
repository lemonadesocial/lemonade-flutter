import 'dart:async';

import 'package:app/core/application/chat/chat_space_bloc/chat_space_bloc.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix/matrix.dart';

@RoutePage()
class ChatStackPage extends StatefulWidget implements AutoRouteWrapper {
  const ChatStackPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ChatSpaceBloc()..add(const ChatSpaceEvent.fetchChatSpaces()),
      child: this,
    );
  }

  @override
  State<ChatStackPage> createState() => ChatStackController();
}

class ChatStackController extends State<ChatStackPage> {
  bool isLogged = getIt<MatrixService>().client.isLogged();

  late final StreamSubscription<LoginState> _matrixLoginStateSub;

  @override
  void initState() {
    _matrixLoginStateSub = getIt<MatrixService>()
        .client
        .onLoginStateChanged
        .stream
        .listen((loginState) {
      if (loginState == LoginState.loggedIn) {
        setState(() {
          isLogged = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _matrixLoginStateSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLogged
        ? AutoRouter(
            navigatorObservers: () => [HeroController()],
          )
        : Scaffold(
            backgroundColor: Theme.of(context).colorScheme.primary,
            body: Center(
              child: Loading.defaultLoading(context),
            ),
          );
  }
}
