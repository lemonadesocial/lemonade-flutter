import 'package:app/core/presentation/widgets/chat/matrix_avatar.dart';
import 'package:app/core/presentation/widgets/chat/mxc_image.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class InputBarSuggestionBox extends StatelessWidget {

  InputBarSuggestionBox({
    super.key,
    required this.suggestion,
  });
  final client = getIt<MatrixService>().client;
  final Map<String, String?> suggestion;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    const size = 30.0;
    const padding = EdgeInsets.all(4);
    if (suggestion['type'] == 'command') {
      final command = ChatCommand.fromString(suggestion['name']!);
      final commandHint = command == null ? '' : t['chat.command.${command.name}'];
      return Tooltip(
        message: commandHint,
        waitDuration: const Duration(days: 1), // don't show on hover
        child: Container(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '/${command?.name}',
                style: const TextStyle(fontFamily: 'monospace'),
              ),
              Text(
                commandHint,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      );
    }
    if (suggestion['type'] == 'emoji') {
      final label = suggestion['label']!;
      return Tooltip(
        message: label,
        waitDuration: const Duration(days: 1), // don't show on hover
        child: Container(
          padding: padding,
          child: Text(label, style: const TextStyle(fontFamily: 'monospace')),
        ),
      );
    }
    if (suggestion['type'] == 'emote') {
      return Container(
        padding: padding,
        child: Row(
          children: <Widget>[
            MxcImage(
              // ensure proper ordering ...
              key: ValueKey(suggestion['name']),
              uri: suggestion['mxc'] is String ? Uri.parse(suggestion['mxc'] ?? '') : null,
              width: size,
              height: size,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                suggestion['name']!,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Opacity(
                  opacity: suggestion['pack_avatar_url'] != null ? 0.8 : 0.5,
                  child: suggestion['pack_avatar_url'] != null
                      ? MatrixAvatar(
                          mxContent: Uri.tryParse(
                            suggestion.tryGet<String>('pack_avatar_url') ?? '',
                          ),
                          name: suggestion.tryGet<String>('pack_display_name'),
                          size: size * 0.9,
                          client: client,
                        )
                      : Text(suggestion['pack_display_name']!),
                ),
              ),
            ),
          ],
        ),
      );
    }
    if (suggestion['type'] == 'user' || suggestion['type'] == 'room') {
      final url = Uri.parse(suggestion['avatar_url'] ?? '');
      return Container(
        padding: padding,
        child: Row(
          children: <Widget>[
            MatrixAvatar(
              mxContent: url,
              name: suggestion.tryGet<String>('displayname') ?? suggestion.tryGet<String>('mxid'),
              size: size,
              client: client,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                suggestion['displayname'] ?? suggestion['mxid']!,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }
}

enum ChatCommand {
  ban,
  clearcache,
  create,
  discardsession,
  dm,
  html,
  invite,
  join,
  kick,
  leave,
  me,
  myroomavatar,
  myroomnick,
  op,
  plain,
  react,
  send,
  unban,
  markasdm,
  markasgroup,
  googly,
  hug,
  cuddle;

  static ChatCommand? fromString(String commandString) {
    return ChatCommand.values.firstWhere((command) => command.name == commandString);
  }
}
