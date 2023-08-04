import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class MessageContent extends StatelessWidget {
  final Event event;
  final Color textColor;
  final void Function(Event)? onInfoTab;

  const MessageContent(
    this.event, {
    this.onInfoTab,
    Key? key,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonTextColor = textColor;
    switch (event.type) {
      case EventTypes.Message:
      case EventTypes.Encrypted:
      case EventTypes.Sticker:
        switch (event.messageType) {
          case MessageTypes.Image:
            return _buildImageMessage();
          case MessageTypes.Sticker:
            if (event.redacted) continue textmessage;
            return _buildStickerMessage();
          case MessageTypes.Audio:
            return _buildAudioMessage();
          case MessageTypes.Video:
            return _buildVideoMessage();
          case MessageTypes.File:
            return _buildFileMessage();
          case MessageTypes.Text:
          case MessageTypes.Notice:
          case MessageTypes.Emote:
            if (!event.redacted && event.isRichMessage) {
              return _buildHtmlMessage();
            }
            // else we fall through to the normal message rendering
            continue textmessage;
          case MessageTypes.BadEncrypted:
          case EventTypes.Encrypted:
            return _buildEncryptedMessage(buttonTextColor);
          case MessageTypes.Location:
            final geoUri = Uri.tryParse(event.content.tryGet<String>('geo_uri')!);
            if (geoUri != null && geoUri.scheme == 'geo') {
              return _buildLocationMessage();
            }
            continue textmessage;
          case MessageTypes.None:
          textmessage:
          default:
            if (event.redacted) {
              return FutureBuilder<User?>(
                future: event.redactedBecause?.fetchSenderUser(),
                builder: (context, snapshot) {
                  return _ButtonContent(
                    label: snapshot.data?.calcDisplayname() ?? event.senderFromMemoryOrFallback.calcDisplayname(),
                    icon: const Icon(Icons.delete_outlined),
                    textColor: buttonTextColor,
                    onPressed: () => onInfoTab!(event),
                  );
                },
              );
            }
            return _buildLinkifyMessage();
        }
      case EventTypes.CallInvite:
        return FutureBuilder<User?>(
          future: event.fetchSenderUser(),
          builder: (context, snapshot) {
            return _ButtonContent(
              label:
                  'call invite ${snapshot.data?.calcDisplayname() ?? event.senderFromMemoryOrFallback.calcDisplayname()},',
              icon: const Icon(Icons.phone_outlined),
              textColor: buttonTextColor,
              onPressed: () => onInfoTab!(event),
            );
          },
        );
      default:
        return FutureBuilder<User?>(
          future: event.fetchSenderUser(),
          builder: (context, snapshot) {
            return _ButtonContent(
              label: snapshot.data?.calcDisplayname() ?? event.senderFromMemoryOrFallback.calcDisplayname(),
              icon: const Icon(Icons.info_outlined),
              textColor: buttonTextColor,
              onPressed: () => onInfoTab!(event),
            );
          },
        );
    }
  }

  FutureBuilder<String> _buildLinkifyMessage() {
    final bigEmotes = event.onlyEmotes && event.numberEmotes > 0 && event.numberEmotes <= 10;
    return FutureBuilder<String>(
      future: event.calcLocalizedBody(
        MatrixDefaultLocalizations(),
        hideReply: true,
      ),
      builder: (context, snapshot) {
        // TODO:
        // return Linkify(
        //   text: snapshot.data ??
        //       event.calcLocalizedBodyFallback(
        //         MatrixLocals(L10n.of(context)!),
        //         hideReply: true,
        //       ),
        //   style: TextStyle(
        //     color: textColor,
        //     fontSize: bigEmotes ? fontSize * 3 : fontSize,
        //     decoration: event.redacted ? TextDecoration.lineThrough : null,
        //   ),
        //   options: const LinkifyOptions(humanize: false),
        //   linkStyle: TextStyle(
        //     color: textColor.withAlpha(150),
        //     fontSize: bigEmotes ? fontSize * 3 : fontSize,
        //     decoration: TextDecoration.underline,
        //     decorationColor: textColor.withAlpha(150),
        //   ),
        //   onOpen: (url) => UrlLauncher(context, url.url).launchUrl(),
        // );
        return Text(
          snapshot.data ??
              event.calcLocalizedBodyFallback(
                MatrixDefaultLocalizations(),
                hideReply: true,
              ),
        );
      },
    );
  }

  _buildLocationMessage() {
    // TODO:
    //   final latlong = geoUri.path.split(';').first.split(',').map((s) => double.tryParse(s)).toList();
    //   if (latlong.length == 2 && latlong.first != null && latlong.last != null) {
    //     return Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         MapBubble(
    //           latitude: latlong.first!,
    //           longitude: latlong.last!,
    //         ),
    //         const SizedBox(height: 6),
    //         OutlinedButton.icon(
    //           icon: Icon(Icons.location_on_outlined, color: textColor),
    //           onPressed: UrlLauncher(context, geoUri.toString()).launchUrl,
    //           label: Text(
    //             L10n.of(context)!.openInMaps,
    //             style: TextStyle(color: textColor),
    //           ),
    //         ),
    //       ],
    //     );
    //   }
    return Text("Location");
  }

  _ButtonContent _buildEncryptedMessage(Color buttonTextColor) {
    return _ButtonContent(
      textColor: buttonTextColor,
      onPressed: () => {},
      // onPressed: () => _verifyOrRequestKey(context),
      icon: const Icon(Icons.lock_outline),
      label: "Encrypted",
    );
  }

  Text _buildHtmlMessage() {
    var html = event.formattedText;
    if (event.messageType == MessageTypes.Emote) {
      html = '* $html';
    }
    // TODO:
    // return HtmlMessage(
    //   html: html,
    //   textColor: textColor,
    //   room: event.room,
    // );
    return Text("Html message, ${html}");
  }

  Text _buildFileMessage() {
    // TODO:
    // // return MessageDownloadContent(event, textColor);
    return Text("File");
  }

  Text _buildVideoMessage() {
    // TODO:
    // if (PlatformInfos.isMobile || PlatformInfos.isWeb) {
    //   return EventVideoPlayer(event);
    // }
    // return MessageDownloadContent(event, textColor);
    return Text("video");
  }

  Text _buildAudioMessage() {
    // TODO:
    // if (PlatformInfos.isMobile || PlatformInfos.isMacOS || PlatformInfos.isWeb
    //     // Disabled until https://github.com/bleonard252/just_audio_mpv/issues/3
    //     // is fixed
    //     //   || PlatformInfos.isLinux
    //     ) {
    //   return AudioPlayerWidget(
    //     event,
    //     color: textColor,
    //   );
    // }
    // return MessageDownloadContent(event, textColor);
    return Text("Audio");
  }

  Text _buildStickerMessage() => Text('Sticker message'); //TODO: return Sticker(event);

  Text _buildImageMessage() => Text('Image message'); //TODO:
}

class _ButtonContent extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  final Icon icon;
  final Color? textColor;

  const _ButtonContent({
    required this.label,
    required this.icon,
    required this.textColor,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(label, overflow: TextOverflow.ellipsis),
      style: TextButton.styleFrom(
        foregroundColor: textColor,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
