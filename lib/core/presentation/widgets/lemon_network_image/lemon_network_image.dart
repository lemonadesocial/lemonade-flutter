import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LemonNetworkImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String imageUrl;
  final Widget? placeholder;
  final BorderRadius? borderRadius;
  final BoxFit? fit;
  final Border? border;

  const LemonNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.placeholder,
    this.borderRadius,
    this.fit,
    this.border,
  });

  bool get _isSvg => imageUrl.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: border,
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: _isSvg
            ? SvgPicture.network(
                imageUrl,
                fit: fit ?? BoxFit.cover,
                placeholderBuilder: (context) =>
                    placeholder ?? const SizedBox.shrink(),
              )
            : CachedNetworkImage(
                fit: fit ?? BoxFit.cover,
                imageUrl: imageUrl,
                errorWidget: (_, __, ___) =>
                    placeholder ?? const SizedBox.shrink(),
                placeholder: (_, __) => placeholder ?? const SizedBox.shrink(),
              ),
      ),
    );
  }
}
