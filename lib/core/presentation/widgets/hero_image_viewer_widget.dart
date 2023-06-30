import 'dart:ui';

import 'package:app/theme/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HeroImageViewer extends StatelessWidget {
  final Widget child;
  final String tag;
  final String imageUrl;

  const HeroImageViewer({
    super.key,
    required this.child,
    required this.tag,
    required this.imageUrl,
  });

  _showImage(context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => _ImageViewerPage(
          heroTag: tag,
          imageUrl: imageUrl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showImage(context);
      },
      child: Hero(
        tag: tag,
        child: child,
      ),
    );
  }
}

class _ImageViewerPage extends StatelessWidget {
  final String heroTag;
  final String imageUrl;

  const _ImageViewerPage({
    required this.heroTag,
    required this.imageUrl,
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

  _buildHero() {
    return Container(
      width: 350,
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LemonRadius.small),
      ),
      child: Hero(
          flightShuttleBuilder: (_, __, ___, ____, _____) {
            return _buildImage();
          },
          tag: heroTag,
          child: _buildImage()),
    );
  }

  _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(LemonRadius.small),
      child: CachedNetworkImage(
        imageUrl: heroTag,
        fit: BoxFit.cover,
      ),
    );
  }
}
