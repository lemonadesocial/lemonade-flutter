import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SpaceDetailPage extends StatelessWidget {
  final String spaceId;
  const SpaceDetailPage({
    super.key,
    required this.spaceId,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Space Detail'),
      ),
    );
  }
}
