// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class ReadMoreWidget extends StatelessWidget {
  const ReadMoreWidget({
    super.key,
    required this.body,
    this.textStyle,
    this.seeMoreLessTextStyle,
    this.maxLines = 5,
  });

  final String body;
  final TextStyle? textStyle;
  final TextStyle? seeMoreLessTextStyle;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final mTextStyle = textStyle ??
        Typo.mediumPlus.copyWith(
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface,
          fontFamily: FontFamily.switzerVariable,
        );

    return LayoutBuilder(
      builder: (context, constraints) {
        final span = TextSpan(text: body, style: textStyle);
        final tp = TextPainter(text: span, textDirection: TextDirection.ltr);
        tp.layout(maxWidth: constraints.maxWidth);
        final numLines = tp.computeLineMetrics().length;
        final _moreLessTextStyle = seeMoreLessTextStyle ?? moreLessTextStyle;

        return numLines <= maxLines
            ? Linkify(
                text: body,
                overflow: TextOverflow.ellipsis,
                style: mTextStyle,
                linkStyle: linkStyle,
                onOpen: onOpen,
                maxLines: maxLines,
                options: option,
              )
            : ExpandableNotifier(
                child: Expandable(
                  collapsed: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Linkify(
                        text: body,
                        maxLines: maxLines,
                        overflow: TextOverflow.ellipsis,
                        style: mTextStyle,
                        linkStyle: linkStyle,
                        onOpen: onOpen,
                        options: option,
                      ),
                      ExpandableButton(
                        child: Text(
                          t.common.showMore,
                          style: _moreLessTextStyle,
                        ),
                      ),
                    ],
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Linkify(
                        text: body,
                        style: mTextStyle,
                        linkStyle: linkStyle,
                        onOpen: onOpen,
                        options: option,
                      ),
                      ExpandableButton(
                        child: Text(
                          t.common.showLess,
                          style: _moreLessTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}

Future<void> onOpen(LinkableElement link) async {
  if (!await launchUrl(Uri.parse(link.url))) {
    // EasyLoading.showError('Could not launch ${link.url}');
  }
}

const option = LinkifyOptions(
  looseUrl: true,
  humanize: false,
);
final linkStyle = Typo.mediumPlus.copyWith(
  color: LemonColor.paleViolet,
  decoration: TextDecoration.underline,
);

final moreLessTextStyle = TextStyle(
  color: LemonColor.paleViolet,
  fontSize: 16.sp,
  fontFamily: FontFamily.switzerVariable,
  fontWeight: FontWeight.w400,
);
