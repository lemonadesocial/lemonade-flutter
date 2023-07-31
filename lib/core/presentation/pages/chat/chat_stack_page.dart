import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ChatStackPage extends StatefulWidget {
  const ChatStackPage({super.key});

  @override
  State<ChatStackPage> createState() => ChatStackController();
}

class ChatStackController extends State<ChatStackPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return getIt<MatrixService>().client.isLogged()
        ? AutoRouter()
        : Scaffold(
            body: Center(child: Loading.defaultLoading(context)),
          );
  }
}
