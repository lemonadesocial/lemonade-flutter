import 'package:app/theme/color.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/core/service/shake/shake_service.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ShakeService _shakeService = ShakeService();

  @override
  void initState() {
    super.initState();
    _shakeService.startShakeDetection(context);
  }

  @override
  void dispose() {
    _shakeService.stopShakeDetection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LemonColor.black,
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}