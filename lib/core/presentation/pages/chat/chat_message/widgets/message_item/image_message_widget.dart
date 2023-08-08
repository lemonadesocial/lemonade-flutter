import 'package:app/core/presentation/widgets/chat/mxc_image.dart';
import 'package:app/core/presentation/widgets/hero_image_viewer_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:matrix/matrix.dart';

class ImageMessage extends StatelessWidget {
  final Event event;
  final BoxFit fit;
  final bool maxSize;
  final Color? backgroundColor;
  final bool thumbnailOnly;
  final bool animated;
  final double width;
  final double height;
  final void Function()? onTap;

  const ImageMessage(
    this.event, {
    this.maxSize = true,
    this.backgroundColor,
    this.fit = BoxFit.cover,
    this.thumbnailOnly = true,
    this.width = 400,
    this.height = 300,
    this.animated = false,
    this.onTap,
    Key? key,
  }) : super(key: key);

  Widget _buildPlaceholder(BuildContext context) {
    if (event.messageType == MessageTypes.Sticker) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    final String blurHashString = event.infoMap['xyz.amorgan.blurhash'] is String
        ? event.infoMap['xyz.amorgan.blurhash']
        : 'LEHV6nWB2yk8pyo0adR*.7kCMdnj';
    final ratio =
        event.infoMap['w'] is int && event.infoMap['h'] is int ? event.infoMap['w'] / event.infoMap['h'] : 1.0;
    var width = 32;
    var height = 32;
    if (ratio > 1.0) {
      height = (width / ratio).round();
    } else {
      width = (height * ratio).round();
    }
    return SizedBox(
      width: this.width,
      height: this.height,
      child: BlurHash(
        hash: blurHashString,
        decodingWidth: width,
        decodingHeight: height,
        imageFit: fit,
      ),
    );
  }

  void _onTap(BuildContext context, {Widget Function()? imageBuilder}) {
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (_) => ImageViewerPage(
        heroTag: event.eventId,
        imageBuilder: imageBuilder,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: Container(
        constraints: maxSize
            ? BoxConstraints(
                maxWidth: width,
                maxHeight: height,
              )
            : null,
        child: HeroImageViewer(
          tag: event.eventId,
          imageBuilder: () => MxcImage(
            event: event,
            fit: BoxFit.contain,
            animated: true,
            isThumbnail: false,
            placeholder: (ctx) => Loading.defaultLoading(ctx),
          ),
          onTap: (_imageBuilder) {
            _onTap(context, imageBuilder: _imageBuilder);
          },
          child: MxcImage(
            event: event,
            width: width,
            height: height,
            fit: fit,
            animated: animated,
            isThumbnail: thumbnailOnly,
            placeholder: _buildPlaceholder,
          ),
        ),
      ),
    );
  }
}
