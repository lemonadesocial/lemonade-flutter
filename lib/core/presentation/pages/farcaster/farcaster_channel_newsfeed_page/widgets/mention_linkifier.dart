// ignore_for_file: hash_and_equals

import 'package:flutter_linkify/flutter_linkify.dart';

final _mentionRegex = RegExp(
  r'\B@([a-zA-Z0-9_-]+\b)',
  caseSensitive: false,
  dotAll: true,
);

class FarcasterMentionLinkifier extends Linkifier {
  const FarcasterMentionLinkifier();

  @override
  List<LinkifyElement> parse(
    List<LinkifyElement> elements,
    LinkifyOptions options,
  ) {
    final list = <LinkifyElement>[];

    for (var element in elements) {
      if (element is TextElement) {
        final matches = _mentionRegex.allMatches(element.text);

        int lastMatchEnd = 0;

        for (var match in matches) {
          // Add the text before the mention as a TextElement
          if (match.start != lastMatchEnd) {
            list.add(
              TextElement(
                element.text.substring(lastMatchEnd, match.start),
              ),
            );
          }
          // Add the mention as a MentionElement
          list.add(MentionElement(match.group(1)!, match.group(0)));

          lastMatchEnd = match.end;
        }

        // Add the remaining text after the last mention as a TextElement
        if (lastMatchEnd != element.text.length) {
          list.add(TextElement(element.text.substring(lastMatchEnd)));
        }
      } else {
        list.add(element);
      }
    }
    return list;
  }
}

class MentionElement extends LinkableElement {
  MentionElement(String url, [String? text]) : super(text, url);

  @override
  String toString() {
    return "MentionElement: '$url' ($text)";
  }

  @override
  bool operator ==(other) => equals(other);

  @override
  bool equals(other) => other is MentionElement && super.equals(other);
}
