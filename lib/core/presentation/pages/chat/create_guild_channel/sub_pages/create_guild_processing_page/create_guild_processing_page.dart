import 'package:app/core/presentation/pages/chat/create_guild_channel/sub_pages/create_guild_processing_page/view/create_guild_loading_view.dart';
import 'package:app/core/presentation/pages/chat/create_guild_channel/sub_pages/create_guild_processing_page/view/create_guild_success_view.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CreateGuildProcessingPage extends StatefulWidget {
  const CreateGuildProcessingPage({super.key});

  @override
  State<CreateGuildProcessingPage> createState() =>
      _CreateGuildProcessingPageState();
}

class _CreateGuildProcessingPageState extends State<CreateGuildProcessingPage> {
  late Future<void> _mutationFuture;

  @override
  void initState() {
    super.initState();
    _mutationFuture = _runMutation();
  }

  Future<void> _runMutation() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(bottom: Spacing.smMedium),
          child: FutureBuilder(
            future: _mutationFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CreateGuildLoadingView();
              } else {
                return const CreateGuildSuccessView();
              }
            },
          ),
        ),
      ),
    );
  }
}
