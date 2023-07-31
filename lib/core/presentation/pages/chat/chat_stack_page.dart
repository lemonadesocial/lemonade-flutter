import 'dart:async';

import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

@RoutePage()
class ChatStackPage extends StatefulWidget {
  const ChatStackPage({super.key});

  @override
  State<ChatStackPage> createState() => ChatStackController();
}

class ChatStackController extends State<ChatStackPage> {
  bool isLogged = getIt<MatrixService>().client.isLogged();

  late final StreamSubscription<LoginState> _matrixLoginStateSub;

  @override
  void initState() {
    _matrixLoginStateSub = getIt<MatrixService>().client.onLoginStateChanged.stream.listen((loginState) {
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
        ? AutoRouter()
        : Scaffold(
            body: Center(
              child: Loading.defaultLoading(context),
            ),
          );
  }
}
