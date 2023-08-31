import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreLessDescription extends StatefulWidget {
  const MoreLessDescription({
    super.key,
    required this.description,
  });

  final String description;

  @override
  State<MoreLessDescription> createState() => _MoreLessDescriptionState();
}

class _MoreLessDescriptionState extends State<MoreLessDescription> {
  bool isExpanded = false;
  final collapsedMaxLength = 130;

  String get displayText {
    final rawText = widget.description;
    if (isExpanded) {
      return rawText;
    }
    if (rawText.length < collapsedMaxLength) {
      return rawText;
    }
    return '${rawText.substring(0, collapsedMaxLength)}...';
  }

  bool get canShowMore {
    return widget.description.length > collapsedMaxLength;
  }

  void showMore() {
    setState(() {
      isExpanded = true;
    });
  }

  void showLess() {
    setState(() {
      isExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: displayText,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 16.sp,
              fontFamily: FontFamily.switzerVariable,
              fontWeight: FontWeight.w400,
            ),
          ),
          const TextSpan(text: ' '),
          if (canShowMore)
            TextSpan(
              text: isExpanded ? t.common.showLess : t.common.showMore,
              style: TextStyle(
                color: LemonColor.paleViolet,
                fontSize: 16.sp,
                fontFamily: FontFamily.switzerVariable,
                fontWeight: FontWeight.w400,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  if (isExpanded) {
                    showLess();
                  } else {
                    showMore();
                  }
                },
            ),
        ],
      ),
    );
  }
}
