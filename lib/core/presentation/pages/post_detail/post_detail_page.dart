import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PostDetailPage extends StatelessWidget {
  const PostDetailPage({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
