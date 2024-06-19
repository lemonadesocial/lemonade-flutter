import 'package:app/core/domain/farcaster/entities/airstack_farcaster_cast.dart';
import 'package:html/parser.dart';

/// Frame mock data
// <meta name="og:image" content="https://lemonade.social/api/og/event/details?id=65f21e95e0530c54c60b7e82" />
// <meta name="fc:frame" content="vNext" />
// <meta name="fc:frame:image" content="https://lemonade.social/api/og/event/details?id=65f21e95e0530c54c60b7e82" />
// <meta name="fc:frame:post_url" content="" />
// <meta name="fc:frame:image:aspect_ratio" content="1.91:1" />
// <meta name="fc:frame:button:1" content="Back" />
// <meta name="fc:frame:button:1:action" content="post" />
// <meta name="fc:frame:button:1:target"
//     content="https://lemonade.social/api/frames/event/?id=65f21e95e0530c54c60b7e82&__bi=1-p" />
// <meta name="fc:frame:button:2" content="View Event" />
// <meta name="fc:frame:button:2:action" content="link" />
// <meta name="fc:frame:button:2:target" content="https://lemonade.social/event/65f21e95e0530c54c60b7e82" />

AirstackFrame parseFarcasterFrameMetadata(String html) {
  final document = parse(html);
  final metadataTags = document
      .getElementsByTagName("meta")
      .where(
        (element) => element.attributes["name"]?.contains("fc:frame") == true,
      )
      .toList();
  Map<String, dynamic> metadata = {};
  for (final tag in metadataTags) {
    metadata[tag.attributes["name"] ?? ''] = tag.attributes["content"];
  }

  final buttonReg = RegExp(r'^fc:frame:(button):(\d+)$');

  return AirstackFrame(
    imageUrl: metadata['fc:frame:image'],
    postUrl: metadata['fc:frame:post_url'],
    buttons: metadata.keys.where((key) => buttonReg.hasMatch(key)).map((key) {
      final buttonIndex = key.split(':')[3];
      return AirstackFrameButton(
        label: metadata[key],
        action: AirstackFrameButtonAction.fromString(
          metadata['fc:frame:button:$buttonIndex:action'],
        ),
        target: metadata['fc:frame:button:$buttonIndex:target'],
      );
    }).toList(),
  );
}
