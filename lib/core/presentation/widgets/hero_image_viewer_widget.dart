import 'dart:ui';

import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/theme/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HeroImageViewer extends StatelessWidget {
  final Widget child;
  final String tag;
  final String? imageUrl;
  final Widget Function()? imageBuilder;
  final Function(Widget Function()? imageBuilder)? onTap;

  const HeroImageViewer({
    super.key,
    required this.child,
    required this.tag,
    this.imageUrl,
    this.imageBuilder,
    this.onTap,
  }) : assert(imageUrl != null || imageBuilder != null);

  void _showImage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => ImageViewerPage(
          heroTag: tag,
          imageUrl: imageUrl,
          imageBuilder: imageBuilder,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap?.call(imageBuilder);
            return;
          }
          _showImage(context);
        },
        child: child,
      ),
    );
  }
}

class ImageViewerPage extends StatelessWidget {
  final String heroTag;
  final String? imageUrl;
  final Widget Function()? imageBuilder;

  const ImageViewerPage({
    required this.heroTag,
    this.imageUrl,
    this.imageBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child: Align(
                  alignment: Alignment.center,
                  child: _buildHero(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return imageBuilder != null
        ? Hero(
            tag: heroTag,
            child: imageBuilder!(),
            flightShuttleBuilder: (_, __, ___, ____, _____) {
              return imageBuilder!();
            },
          )
        : Hero(
            tag: heroTag,
            flightShuttleBuilder: (_, __, ___, ____, _____) {
              return _buildImage();
            },
            child: _buildImage(),
          );
  }

  _buildImage() {
    return Container(
      width: 350,
      height: 350,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(LemonRadius.small),
        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          fit: BoxFit.cover,
          errorWidget: (_, __, ___) => ImagePlaceholder.defaultPlaceholder(),
          placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
        ),
      ),
    );
  }
}
