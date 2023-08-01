import 'package:app/core/service/shake/shake_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getIt<ShakeService>().startShakeDetection(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LemonColor.black,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            onPressed: () {
              AutoRouter.of(context).navigate(PoapListingRoute());
            },
            child: Text("Navigate to poap"),
          ),
          GestureDetector(
            onTap: () {
              AutoRouter.of(context).navigate(ChatListRoute());
            },
            child: SizedBox(
              child: Text("Navigate to Chat"),
            ),
          )
        ]),
      ),
    );
  }
}
