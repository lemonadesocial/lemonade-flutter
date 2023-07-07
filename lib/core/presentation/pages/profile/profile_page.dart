import 'package:app/core/presentation/pages/profile/views/profile_page_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  final String userId;
  const ProfilePage({super.key, @PathParam("id") required this.userId});

  @override
  Widget build(BuildContext context) {
    return ProfilePageView(
      userId: '',
    );
  }
}
