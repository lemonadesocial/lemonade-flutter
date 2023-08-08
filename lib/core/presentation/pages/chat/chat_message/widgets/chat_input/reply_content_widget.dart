import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class ReplyContent extends StatelessWidget {
  final Event replyEvent;
  final bool ownMessage;
  final Timeline? timeline;

  const ReplyContent(
    this.replyEvent, {
    this.ownMessage = false,
    Key? key,
    this.timeline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    Widget replyBody;
    final timeline = this.timeline;
    final displayEvent =
        timeline != null ? replyEvent.getDisplayEvent(timeline) : replyEvent;
    final fontSize = Typo.medium.fontSize!;

    replyBody = Text(
      displayEvent.calcLocalizedBodyFallback(
        MatrixDefaultLocalizations(),
        withSenderNamePrefix: false,
        hideReply: true,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 3,
          height: fontSize * 2 + 6,
          color: colorScheme.onSecondary
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder<User?>(
                future: displayEvent.fetchSenderUser(),
                builder: (context, snapshot) {
                  return Text(
                    '${snapshot.data?.calcDisplayname() ?? displayEvent.senderFromMemoryOrFallback.calcDisplayname()}:',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Typo.medium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              replyBody,
            ],
          ),
        ),
      ],
    );
  }
}
