import 'package:app/core/presentation/widgets/chat/mxc_image.dart';
import 'package:app/core/utils/chat/matrix_string_color_extension.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix/matrix.dart';

class MatrixAvatar extends StatelessWidget {
  final Uri? mxContent;
  final String? name;
  final double size;
  final void Function()? onTap;
  static const double defaultSize = 44;
  final Client? client;
  final double fontSize;
  final double? radius;
  final bool? isDirectChat;
  final PresenceType? presence;

  const MatrixAvatar({
    this.mxContent,
    this.name,
    this.size = defaultSize,
    this.onTap,
    this.client,
    this.fontSize = 18,
    this.radius,
    this.isDirectChat,
    this.presence,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
          fontWeight: FontWeight.w600,
        ),
      ),
    );
    final borderRadius = BorderRadius.circular(radius ?? LemonRadius.xSmall);
    final container = Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: LemonColor.white09,
            ),
            borderRadius: borderRadius,
          ),
          child: ClipRRect(
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
          ),
        ),
        _buildBottomRightCorner(colorScheme),
      ],
    );
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: container,
    );
  }

  Widget _buildBottomRightCorner(ColorScheme colorScheme) {
    if (isDirectChat == null) return const SizedBox();
    // Render online/offline dot
    if (isDirectChat == true) {
      final isOnline = presence == PresenceType.online;
      return Positioned(
        bottom: -2.h,
        right: -2.w,
        child: Container(
          width: 15.w,
          height: 15.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isOnline ? LemonColor.online : Colors.grey,
            border: Border.all(
              width: 3.w,
            ),
          ),
        ),
      );
    }
    // For chat group case
    return const SizedBox.shrink();
  }
}
