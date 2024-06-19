import 'dart:convert';
import 'package:app/core/application/farcaster/create_farcaster_cast_bloc/create_farcaster_cast_bloc.dart';
import 'package:app/core/domain/farcaster/farcaster_repository.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/utils/debouncer.dart';
import 'package:app/core/utils/list/unique_list_extension.dart';
import 'package:app/graphql/farcaster_airstack/query/get_farcaster_users.graphql.dart';
import 'package:app/graphql/farcaster_airstack/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mentions/flutter_mentions.dart';

class CreateFarcasterEditor extends StatefulWidget {
  final Function(bool visible)? onSuggestionVisibleChanged;

  const CreateFarcasterEditor({
    super.key,
    this.onSuggestionVisibleChanged,
  });

  @override
  State<CreateFarcasterEditor> createState() => CreateFarcasterEditorState();
}

class CreateFarcasterEditorState extends State<CreateFarcasterEditor> {
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> mentionedUsers = [];
  String _displayedText = '';

  final debouncer = Debouncer(milliseconds: 200);

  int getBytePosition(String text, String mentionWord) {
    int charPosition = text.indexOf(mentionWord);
    if (charPosition == -1) {
      return -1;
    }
    String beforeMention = text.substring(0, charPosition);
    int byteSizeBeforeMention = utf8.encode(beforeMention).length;
    return byteSizeBeforeMention;
  }

  (String, List<FarcasterMention>) extractMentionsAndMessageWithoutMentions(
    String text,
    String displayText,
  ) {
    final regex = RegExp(
      r'(?<=\s|^)<start>\[(\d+)\]\[(.+?)\]<end>',
      multiLine: true,
      caseSensitive: false,
    );

    final matches = regex.allMatches(text);

    List<FarcasterMention> mentions = [];
    int offset = 0;
    String messageWithoutMentions = displayText;
    for (var match in matches) {
      final idValue = int.tryParse(match.group(1) ?? '0') ?? 0;
      final display = match.group(2) ?? '';

      // Find the actual position of the display text
      final displayPosition = displayText.indexOf(display, offset);
      if (displayPosition != -1) {
        final bytePosition = getBytePosition(messageWithoutMentions, display);
        mentions.add(FarcasterMention(position: bytePosition, fid: idValue));
        offset = displayPosition + display.length;
        messageWithoutMentions =
            messageWithoutMentions.replaceFirst(display, '');
      }
    }
    return (messageWithoutMentions, mentions);
  }

  Map<String, dynamic> formatRemotedUser(Map<String, dynamic> user) {
    return {
      "id": "${user['fid']}",
      "display": "${user['profileName']}",
      "fullName": "${user['profileDisplayName']}",
      "username": "${user['profileName']}",
      "imageUrl": "${user['profileImage']}",
    };
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return FlutterMentions(
      appendSpaceOnAdd: false,
      suggestionListHeight: 200,
      suggestionListDecoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(LemonRadius.small),
      ),
      onMarkupChanged: (value) {
        final (messageWithoutMentions, mentionsData) =
            extractMentionsAndMessageWithoutMentions(value, _displayedText);
        context.read<CreateFarcasterCastBloc>().add(
              CreateFarcasterCastEvent.updateMessageWithoutMentions(
                messageWithoutMentions: messageWithoutMentions,
              ),
            );
        context.read<CreateFarcasterCastBloc>().add(
              CreateFarcasterCastEvent.updateMentions(
                mentions: mentionsData,
              ),
            );
      },
      onSuggestionVisibleChanged: (visible) {
        widget.onSuggestionVisibleChanged?.call(visible);
      },
      onSearchChanged: (trigger, value) {
        if (value.isEmpty) {
          setState(() {
            users = mentionedUsers;
          });
          return;
        }
        debouncer.run(() {
          getIt<FarcasterRepository>()
              .getUsers(
            input: Variables$Query$GetFarcasterUsers(
              filter: Input$SocialFilter(
                profileName: Input$Regex_String_Comparator_Exp(
                  $_regex: '^$value',
                ),
              ),
            ),
          )
              .then((result) {
            setState(() {
              users = result.fold((l) => [], (mUsers) {
                return mUsers.map((user) {
                  return formatRemotedUser(user);
                }).toList();
              });
            });
          });
        });
      },
      onMentionAdd: (map) {
        setState(() {
          mentionedUsers = [...mentionedUsers, map];
        });
      },
      mentions: [
        Mention(
          suggestionBuilder: (item) {
            return Container(
              color: LemonColor.atomicBlack,
              padding: EdgeInsets.all(Spacing.xSmall),
              child: Row(
                children: [
                  LemonNetworkImage(
                    imageUrl: item['imageUrl'],
                    width: Sizing.medium,
                    height: Sizing.medium,
                    borderRadius: BorderRadius.circular(Sizing.medium),
                    placeholder: ImagePlaceholder.defaultPlaceholder(),
                  ),
                  SizedBox(
                    width: Spacing.xSmall,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['fullName'],
                        style: Typo.medium.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '@${item['username']}',
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          markupBuilder: (trigger, id, display) {
            return '<start>[$id][@$display]<end>';
          },
          trigger: '@',
          matchAll: false,
          data: [...users, ...mentionedUsers].unique((a) => a['id']),
          style: Typo.mediumPlus.copyWith(
            color: LemonColor.paleViolet,
          ),
        ),
      ],
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: t.farcaster.createCastPlaceholder,
      ),
      maxLines: null,
      cursorColor: colorScheme.onSecondary,
      style: Typo.mediumPlus.copyWith(
        color: colorScheme.onPrimary,
      ),
      onChanged: (message) {
        _displayedText = message;
        context.read<CreateFarcasterCastBloc>().add(
              CreateFarcasterCastEvent.updateMessage(
                message: message,
              ),
            );
      },
    );
  }
}
