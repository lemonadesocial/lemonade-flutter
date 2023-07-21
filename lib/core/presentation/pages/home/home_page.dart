import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LemonColor.black,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            AutoRouter.of(context).navigate(PoapListingRoute());
          },
          child: Text("Navigate to poap"),
        ),
      ),
    );
  }
}
