import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:flutter/material.dart';

class CommunityUserTile extends StatelessWidget {
  const CommunityUserTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LemonCircleAvatar(url: user.imageAvatar ?? ''),
      ],
    );
  }
}
