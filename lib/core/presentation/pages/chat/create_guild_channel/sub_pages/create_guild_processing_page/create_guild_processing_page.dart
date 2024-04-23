import 'package:app/core/application/chat/create_guild_channel_bloc/create_guild_channel_bloc.dart';
import 'package:app/core/domain/chat/chat_repository.dart';
import 'package:app/core/presentation/pages/chat/create_guild_channel/sub_pages/create_guild_processing_page/view/create_guild_loading_view.dart';
import 'package:app/core/presentation/pages/chat/create_guild_channel/sub_pages/create_guild_processing_page/view/create_guild_success_view.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  Future<void> _runMutation() async {
    final matrixClient = getIt<MatrixService>().client;
    final createdRoom = await matrixClient.createRoom();
    final guildId =
        context.read<CreateGuildChannelBloc>().state.selectedGuild?.id;
    final channelName =
        context.read<CreateGuildChannelBloc>().state.channelName;
    final roles =
        context.read<CreateGuildChannelBloc>().state.selectedGuildRoles ?? [];
    List<int> guildRoleIds = roles.map((role) => role.id!).toList();
    await getIt<ChatRepository>().createGuildRoom(
      guildId: (guildId ?? 0).toDouble(),
      title: channelName ?? '',
      matrixRoomId: createdRoom,
      guildRoleIds: guildRoleIds,
    );
  }

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
