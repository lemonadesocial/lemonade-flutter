import 'package:app/core/presentation/widgets/chat/mxc_image.dart';
import 'package:app/core/utils/chat/matrix_string_color_extension.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class MatrixAvatar extends StatelessWidget {
  final Uri? mxContent;
  final String? name;
  final double size;
  final void Function()? onTap;
  static const double defaultSize = 44;
  final Client? client;
  final double fontSize;

  const MatrixAvatar({
    this.mxContent,
    this.name,
    this.size = defaultSize,
    this.onTap,
    this.client,
    this.fontSize = 18,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fallbackLetters = '@';
    final name = this.name;
    if (name != null) {
      if (name.runes.length >= 2) {
        fallbackLetters = String.fromCharCodes(name.runes, 0, 2);
      } else if (name.runes.length == 1) {
        fallbackLetters = name;
      }
    }
    final noPic = mxContent == null ||
        mxContent.toString().isEmpty ||
        mxContent.toString() == 'null';
    final textWidget = Center(
      child: Text(
        fallbackLetters,
        style: TextStyle(
          color: noPic ? Colors.white : null,
          fontSize: fontSize,
        ),
      ),
    );
    final borderRadius = BorderRadius.circular(LemonRadius.extraSmall);
    final container = ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        width: size,
        height: size,
        color: noPic
            ? name?.lightColorAvatar
            : Theme.of(context).secondaryHeaderColor,
        child: noPic
            ? textWidget
            : MxcImage(
                key: Key(mxContent.toString()),
                uri: mxContent,
                fit: BoxFit.cover,
                width: size,
                height: size,
                placeholder: (_) => textWidget,
                cacheKey: mxContent.toString(),
              ),
      ),
    );
    if (onTap == null) return container;
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: container,
    );
  }
}
