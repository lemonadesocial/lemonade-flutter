import 'package:app/core/presentation/pages/chat/chat_message/widgets/chat_input/emoji_picker_widget.dart';
import 'package:app/core/presentation/widgets/chat/matrix_avatar.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/core/utils/bottomsheet_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:collection/collection.dart' show IterableExtension;

class MessageReactions extends StatelessWidget {
  final Event event;
  final Timeline timeline;
  final Function({required Event event, required String emoji})? onReact;

  const MessageReactions({
    Key? key,
    required this.event,
    required this.timeline,
    this.onReact,
  }) : super(key: key);

  Set<Event> getAllReactionEvents() {
    return event.aggregatedEvents(timeline, RelationshipTypes.reaction);
  }

  List<_ReactionEntry> getReactions() {
    Set<Event> allReactionEvents = getAllReactionEvents();
    final reactionMap = <String, _ReactionEntry>{};
    for (final e in allReactionEvents) {
      final key = e.content.tryGetMap<String, dynamic>('m.relates_to')?.tryGet<String>('key');
      if (key != null) {
        if (!reactionMap.containsKey(key)) {
          reactionMap[key] = _ReactionEntry(
            key: key,
            count: 0,
            reacted: false,
            reactors: [],
          );
        }
        reactionMap[key]!.count++;
        reactionMap[key]!.reactors!.add(e.senderFromMemoryOrFallback);
        reactionMap[key]!.reacted |= e.senderId == e.room.client.userID;
      }
    }
    return reactionMap.values.toList();
  }

  _onTapReaction(_ReactionEntry r) async {
    if (r.reacted) {
      final evt = getAllReactionEvents().firstWhereOrNull(
        (e) => e.senderId == e.room.client.userID && e.content.tryGetMap('m.relates_to')?['key'] == r.key,
      );
      if (evt != null) {
        await evt.redactEvent();
      }
    } else {
      onReact?.call(event: event, emoji: r.key!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final reactions = getReactions();
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ...reactions
            .map(
              (r) => _Reaction(
                reactionKey: r.key,
                count: r.count,
                reacted: r.reacted,
                onTap: () => _onTapReaction(r),
                onLongPress: () async => await _AdaptableReactorsDialog(
                  reactionEntry: r,
                ).show(context),
              ),
            )
            .toList(),
        if (reactions.isNotEmpty)
          InkWell(
            onTap: () {
              BottomSheetUtils.showSnapBottomSheet(context, builder: (_) {
                return LemonEmojiPicker(
                  onEmojiSelected: (emoji) {
                    Navigator.of(context).pop();
                    onReact?.call(
                      event: event,
                      emoji: emoji.emoji,
                    );
                  },
                );
              });
            },
            borderRadius: BorderRadius.circular(LemonRadius.small),
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(LemonRadius.small),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.superExtraSmall,
                vertical: Spacing.superExtraSmall / 2,
              ),
              child: Icon(
                Icons.add_circle_outline,
                color: colorScheme.onSurface,
                size: Sizing.xSmall,
              ),
            ),
          ),
      ],
    );
  }
}

class _Reaction extends StatelessWidget {
  final String? reactionKey;
  final int? count;
  final bool? reacted;
  final void Function()? onTap;
  final void Function()? onLongPress;

  const _Reaction({
    this.reactionKey,
    this.count,
    this.reacted,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final color = reacted == true ? LemonColor.lavender : Theme.of(context).colorScheme.surface;

    return InkWell(
      onTap: () => onTap != null ? onTap!() : null,
      onLongPress: () => onLongPress != null ? onLongPress!() : null,
      borderRadius: BorderRadius.circular(LemonRadius.small),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(LemonRadius.small),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.superExtraSmall,
          vertical: Spacing.superExtraSmall / 2,
        ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    var renderKey = Characters(reactionKey!);
    if (renderKey.length > 10) {
      renderKey = renderKey.getRange(0, 9) + Characters('…');
    }
    return Text(
      '$renderKey $count',
    );
  }
}

class _ReactionEntry {
  String? key;
  int count;
  bool reacted;
  List<User>? reactors;

  _ReactionEntry({
    this.key,
    required this.count,
    required this.reacted,
    this.reactors,
  });
}

class _AdaptableReactorsDialog extends StatelessWidget {
  final _ReactionEntry? reactionEntry;

  const _AdaptableReactorsDialog({
    Key? key,
    this.reactionEntry,
  }) : super(key: key);

  Future<bool?> show(BuildContext context) => showDialog(
        context: context,
        builder: (context) => this,
        barrierDismissible: true,
        useRootNavigator: false,
      );

  @override
  Widget build(BuildContext context) {
    final body = SingleChildScrollView(
      child: Wrap(
        spacing: Spacing.extraSmall,
        runSpacing: Spacing.extraSmall / 2,
        alignment: WrapAlignment.center,
        children: <Widget>[
          for (var reactor in reactionEntry!.reactors!)
            Chip(
              avatar: MatrixAvatar(
                mxContent: reactor.avatarUrl,
                name: reactor.displayName,
                client: getIt<MatrixService>().client,
              ),
              label: Text(reactor.displayName!),
            ),
        ],
      ),
    );

    final title = Center(child: Text(reactionEntry!.key!));

    return AlertDialog(
      title: title,
      content: body,
    );
  }
}
