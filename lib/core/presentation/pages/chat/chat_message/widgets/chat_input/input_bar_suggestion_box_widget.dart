import 'package:app/core/presentation/widgets/chat/matrix_avatar.dart';
import 'package:app/core/presentation/widgets/chat/mxc_image.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class InputBarSuggestionBox extends StatelessWidget {
  final client = getIt<MatrixService>().client;
  final Map<String, String?> suggestion;
  
  InputBarSuggestionBox({
    super.key,
    required this.suggestion,
  });

  @override
  Widget build(BuildContext context) {
    const size = 30.0;
    const padding = EdgeInsets.all(4.0);
    if (suggestion['type'] == 'command') {
      final command = suggestion['name']!;
      final hint = commandHint(command);
      return Tooltip(
        message: hint,
        waitDuration: const Duration(days: 1), // don't show on hover
        child: Container(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '/$command',
                style: const TextStyle(fontFamily: 'monospace'),
              ),
              Text(
                hint,
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
          crossAxisAlignment: CrossAxisAlignment.center,
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
          crossAxisAlignment: CrossAxisAlignment.center,
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

String commandHint(String command) {
  switch (command) {
    case "ban":
      return "Ban";
    case "clearcache":
      return "clear cache";
    case "create":
      return "commandHint_create";
    case "discardsession":
      return "commandHint_discardsession";
    case "dm":
      return "commandHint_dm";
    case "html":
      return "commandHint_html";
    case "invite":
      return "commandHint_invite";
    case "join":
      return "commandHint_join";
    case "kick":
      return "commandHint_kick";
    case "leave":
      return "commandHint_leave";
    case "me":
      return "commandHint_me";
    case "myroomavatar":
      return "commandHint_myroomavatar";
    case "myroomnick":
      return "commandHint_myroomnick";
    case "op":
      return "commandHint_op";
    case "plain":
      return "commandHint_plain";
    case "react":
      return "commandHint_react";
    case "send":
      return "commandHint_send";
    case "unban":
      return "commandHint_unban";
    case 'markasdm':
      return "commandHint_markasdm";
    case 'markasgroup':
      return "commandHint_markasgroup";
    case 'googly':
      return "commandHint_googly";
    case 'hug':
      return "commandHint_hug";
    case 'cuddle':
      return "commandHint_cuddle";
    default:
      return "";
  }
}
