import 'package:app/core/presentation/pages/chat/chat_message/widgets/chat_input/input_bar_suggestion_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:matrix/matrix.dart';
import 'package:slugify/slugify.dart';

class InputBar extends StatelessWidget {

  const InputBar({
    required this.room,
    this.minLines,
    this.maxLines,
    this.keyboardType,
    this.onSubmitted,
    this.onSubmitImage,
    this.focusNode,
    this.controller,
    this.decoration,
    this.onChanged,
    this.autofocus,
    this.textInputAction,
    this.readOnly = false,
    Key? key,
  }) : super(key: key);
  final Room room;
  final int? minLines;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<Uint8List?>? onSubmitImage;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final ValueChanged<String>? onChanged;
  final bool? autofocus;
  final bool readOnly;

  RegExp get commandMatchRegex => RegExp(r'^/(\w*)$');

  RegExp get replaceCommandMatchRegex => RegExp(r'^(/\w*)$');

  RegExp get emojiMatchRegex => RegExp(r'(?:\s|^):(?:([-\w]+)~)?([-\w]+)$');

  RegExp get replaceEmoteMatchRegex => RegExp(r'(\s|^)(:(?:[-\w]+~)?[-\w]+)$');

  RegExp get mentionUserMatchRegex => RegExp(r'(?:\s|^)@([-\w]+)$');

  RegExp get replaceMentionUserMatchRegex => RegExp(r'(\s|^)(@[-\w]+)$');

  RegExp get mentionRoomMatchRegex => RegExp(r'(?:\s|^)#([-\w]+)$');

  RegExp get replaceMentionRoomMatchRegex => RegExp(r'(\s|^)(#[-\w]+)$');

  List<Map<String, String?>> getSuggestions(String text) {
    if (controller!.selection.baseOffset != controller!.selection.extentOffset ||
        controller!.selection.baseOffset < 0) {
      return []; // no entries if there is selected text
    }
    final searchText = controller!.text.substring(0, controller!.selection.baseOffset);
    final ret = <Map<String, String?>>[];
    const maxResults = 30;

    final commandMatch = commandMatchRegex.firstMatch(searchText);
    if (commandMatch != null) {
      final commandSearch = commandMatch[1]!.toLowerCase();
      for (final command in room.client.commands.keys) {
        if (command.contains(commandSearch)) {
          ret.add({
            'type': 'command',
            'name': command,
          });
        }

        if (ret.length > maxResults) return ret;
      }
    }
    final emojiMatch = emojiMatchRegex.firstMatch(searchText);
    if (emojiMatch != null) {
      final packSearch = emojiMatch[1];
      final emoteSearch = emojiMatch[2]!.toLowerCase();
      final emotePacks = room.getImagePacks(ImagePackUsage.emoticon);
      if (packSearch == null || packSearch.isEmpty) {
        for (final pack in emotePacks.entries) {
          for (final emote in pack.value.images.entries) {
            if (emote.key.toLowerCase().contains(emoteSearch)) {
              ret.add({
                'type': 'emote',
                'name': emote.key,
                'pack': pack.key,
                'pack_avatar_url': pack.value.pack.avatarUrl?.toString(),
                'pack_display_name': pack.value.pack.displayName ?? pack.key,
                'mxc': emote.value.url.toString(),
              });
            }
            if (ret.length > maxResults) {
              break;
            }
          }
          if (ret.length > maxResults) {
            break;
          }
        }
      } else if (emotePacks[packSearch] != null) {
        for (final emote in emotePacks[packSearch]!.images.entries) {
          if (emote.key.toLowerCase().contains(emoteSearch)) {
            ret.add({
              'type': 'emote',
              'name': emote.key,
              'pack': packSearch,
              'pack_avatar_url': emotePacks[packSearch]!.pack.avatarUrl?.toString(),
              'pack_display_name': emotePacks[packSearch]!.pack.displayName ?? packSearch,
              'mxc': emote.value.url.toString(),
            });
          }
          if (ret.length > maxResults) {
            break;
          }
        }
      }
      // TODO:
      // aside of emote packs, also propose normal (tm) unicode emojis
      // final matchingUnicodeEmojis = Emoji.all()
      // .where(
      //   (element) => [element.name, ...element.keywords]
      //       .any((element) => element.toLowerCase().contains(emoteSearch)),
      // )
      // .toList();
      final matchingUnicodeEmojis = [];
      // sort by the index of the search term in the name in order to have
      // best matches first
      // (thanks for the hint by github.com/nextcloud/circles devs)
      matchingUnicodeEmojis.sort((a, b) {
        final indexA = a.name.indexOf(emoteSearch);
        final indexB = b.name.indexOf(emoteSearch);
        if (indexA == -1 || indexB == -1) {
          if (indexA == indexB) return 0;
          if (indexA == -1) {
            return 1;
          } else {
            return 0;
          }
        }
        return indexA.compareTo(indexB);
      });
      for (final emoji in matchingUnicodeEmojis) {
        ret.add({
          'type': 'emoji',
          'emoji': emoji.char,
          // don't include sub-group names, splitting at `:` hence
          'label': '${emoji.char} - ${emoji.name.split(':').first}',
          'current_word': ':$emoteSearch',
        });
        if (ret.length > maxResults) {
          break;
        }
      }
    }
    final userMatch = mentionUserMatchRegex.firstMatch(searchText);
    if (userMatch != null) {
      final userSearch = userMatch[1]!.toLowerCase();
      for (final user in room.getParticipants()) {
        if ((user.displayName != null &&
                (user.displayName!.toLowerCase().contains(userSearch) ||
                    slugify(user.displayName!.toLowerCase()).contains(userSearch))) ||
            user.id.split(':')[0].toLowerCase().contains(userSearch)) {
          ret.add({
            'type': 'user',
            'mxid': user.id,
            'mention': user.mention,
            'displayname': user.displayName,
            'avatar_url': user.avatarUrl?.toString(),
          });
        }
        if (ret.length > maxResults) {
          break;
        }
      }
    }
    final roomMatch = mentionRoomMatchRegex.firstMatch(searchText);
    if (roomMatch != null) {
      final roomSearch = roomMatch[1]!.toLowerCase();
      for (final r in room.client.rooms) {
        if (r.getState(EventTypes.RoomTombstone) != null) {
          continue; // we don't care about tombstoned rooms
        }
        final state = r.getState(EventTypes.RoomCanonicalAlias);
        if ((state != null &&
                ((state.content['alias'] is String &&
                        state.content.tryGet<String>('alias')!.split(':')[0].toLowerCase().contains(roomSearch)) ||
                    (state.content['alt_aliases'] is List &&
                        (state.content['alt_aliases'] as List).any(
                          (l) => l is String && l.split(':')[0].toLowerCase().contains(roomSearch),
                        )))) ||
            (r.name.toLowerCase().contains(roomSearch))) {
          ret.add({
            'type': 'room',
            'mxid': (r.canonicalAlias.isNotEmpty) ? r.canonicalAlias : r.id,
            'displayname': r.getLocalizedDisplayname(),
            'avatar_url': r.avatar?.toString(),
          });
        }
        if (ret.length > maxResults) {
          break;
        }
      }
    }
    return ret;
  }

  void insertSuggestion(_, Map<String, String?> suggestion) {
    final replaceText = controller!.text.substring(0, controller!.selection.baseOffset);
    var startText = '';
    final afterText =
        replaceText == controller!.text ? '' : controller!.text.substring(controller!.selection.baseOffset + 1);
    var insertText = '';
    if (suggestion['type'] == 'command') {
      insertText = '${suggestion['name']!} ';
      startText = replaceText.replaceAllMapped(
        replaceCommandMatchRegex,
        (m) => '/$insertText',
      );
    }
    if (suggestion['type'] == 'emoji') {
      insertText = '${suggestion['emoji']!} ';
      startText = replaceText.replaceAllMapped(
        suggestion['current_word']!,
        (m) => insertText,
      );
    }
    if (suggestion['type'] == 'emote') {
      var isUnique = true;
      final insertEmote = suggestion['name'];
      final insertPack = suggestion['pack'];
      final emotePacks = room.getImagePacks(ImagePackUsage.emoticon);
      for (final pack in emotePacks.entries) {
        if (pack.key == insertPack) {
          continue;
        }
        for (final emote in pack.value.images.entries) {
          if (emote.key == insertEmote) {
            isUnique = false;
            break;
          }
        }
        if (!isUnique) {
          break;
        }
      }
      insertText = ':${isUnique ? '' : '${insertPack!}~'}$insertEmote: ';
      startText = replaceText.replaceAllMapped(
        replaceEmoteMatchRegex,
        (m) => '${m[1]}$insertText',
      );
    }
    if (suggestion['type'] == 'user') {
      insertText = '${suggestion['mention']!} ';
      startText = replaceText.replaceAllMapped(
        replaceMentionUserMatchRegex,
        (m) => '${m[1]}$insertText',
      );
    }
    if (suggestion['type'] == 'room') {
      insertText = '${suggestion['mxid']!} ';
      startText = replaceText.replaceAllMapped(
        replaceMentionRoomMatchRegex,
        (m) => '${m[1]}$insertText',
      );
    }
    if (insertText.isNotEmpty && startText.isNotEmpty) {
      controller!.text = startText + afterText;
      controller!.selection = TextSelection(
        baseOffset: startText.length,
        extentOffset: startText.length,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Map<String, String?>>(
      direction: AxisDirection.up,
      hideOnEmpty: true,
      hideOnLoading: true,
      keepSuggestionsOnSuggestionSelected: true,
      debounceDuration: const Duration(milliseconds: 50),
      // show suggestions after 50ms idle time (default is 300)
      textFieldConfiguration: TextFieldConfiguration(
        minLines: minLines,
        maxLines: maxLines,
        keyboardType: keyboardType!,
        textInputAction: textInputAction,
        autofocus: autofocus!,
        onSubmitted: (text) {
          // fix for library for now
          // it sets the types for the callback incorrectly
          onSubmitted!(text);
        },
        controller: controller,
        decoration: decoration!,
        focusNode: focusNode,
        onChanged: (text) {
          // fix for the library for now
          // it sets the types for the callback incorrectly
          onChanged!(text);
        },
        textCapitalization: TextCapitalization.sentences,
      ),
      suggestionsBoxDecoration: const SuggestionsBoxDecoration(
        color: Colors.black,
        constraints: BoxConstraints(maxHeight: 300),
      ),
      suggestionsCallback: getSuggestions,
      itemBuilder: (c, s) => InputBarSuggestionBox(suggestion: s),
      onSuggestionSelected: (suggestion) => insertSuggestion(context, suggestion),
      errorBuilder: (context, error) => const SizedBox.shrink(),
      loadingBuilder: (context) => const SizedBox.shrink(),
      // fix loading briefly flickering a dark box
      noItemsFoundBuilder: (context) =>
          const SizedBox.shrink(), // fix loading briefly showing no suggestions
    );
  }
}
