import 'dart:typed_data';

import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/core/utils/chat/matrix_file_extension.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:matrix/matrix.dart';

class MxcImage extends StatefulWidget {
  final Uri? uri;
  final Event? event;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final bool isThumbnail;
  final bool animated;
  final Duration retryDuration;
  final Duration animationDuration = const Duration(milliseconds: 300);
  final Curve animationCurve = Curves.linear;
  final ThumbnailMethod thumbnailMethod;
  final Widget Function(BuildContext context)? placeholder;
  final String? cacheKey;

  const MxcImage({
    this.uri,
    this.event,
    this.width,
    this.height,
    this.fit,
    this.placeholder,
    this.isThumbnail = true,
    this.animated = false,
    this.retryDuration = const Duration(seconds: 2),
    this.thumbnailMethod = ThumbnailMethod.scale,
    this.cacheKey,
    super.key,
  });

  @override
  State<MxcImage> createState() => _MxcImageState();
}

class _MxcImageState extends State<MxcImage> {
  static final Map<String, Uint8List> _imageDataCache = {};
  Uint8List? _imageDataNoCache;
  Uint8List? get _imageData {
    final cacheKey = widget.cacheKey;
    return cacheKey == null ? _imageDataNoCache : _imageDataCache[cacheKey];
  }

  set _imageData(Uint8List? data) {
    if (data == null) return;
    final cacheKey = widget.cacheKey;
    cacheKey == null
        ? _imageDataNoCache = data
        : _imageDataCache[cacheKey] = data;
  }

  bool? _isCached;

  Future<void> _load() async {
    final client = getIt<MatrixService>().client;
    final uri = widget.uri;
    final event = widget.event;

    if (uri != null) {
      final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
      final width = widget.width;
      final realWidth = width == null ? null : width * devicePixelRatio;
      final height = widget.height;
      final realHeight = height == null ? null : height * devicePixelRatio;

      final httpUri = widget.isThumbnail
          ? uri.getThumbnail(
              client,
              width: realWidth,
              height: realHeight,
              animated: widget.animated,
              method: widget.thumbnailMethod,
            )
          : uri.getDownloadLink(client);

      final storeKey = widget.isThumbnail ? httpUri : uri;

      if (_isCached == null) {
        final cachedData = await client.database?.getFile(storeKey);
        if (cachedData != null) {
          if (!mounted) return;
          setState(() {
            _imageData = cachedData;
            _isCached = true;
          });
          return;
        }
        _isCached = false;
      }

      final response = await http.get(httpUri);
      if (response.statusCode != 200) {
        if (response.statusCode == 404) {
          return;
        }
        throw Exception();
      }
      final remoteData = response.bodyBytes;

      if (!mounted) return;
      setState(() {
        _imageData = remoteData;
      });
      await client.database?.storeFile(storeKey, remoteData, 0);
    }

    if (event != null) {
      final data = await event.downloadAndDecryptAttachment(
        getThumbnail: widget.isThumbnail,
      );
      if (data.detectFileType is MatrixImageFile) {
        if (!mounted) return;
        setState(() {
          _imageData = data.bytes;
        });
        return;
      }
    }
  }

  void _tryLoad(_) async {
    if (_imageData != null) return;
    try {
      await _load();
    } catch (_) {
      if (!mounted) return;
      await Future.delayed(widget.retryDuration);
      _tryLoad(_);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_tryLoad);
  }

  Widget placeholder(BuildContext context) =>
      widget.placeholder?.call(context) ??
      const Center(
        child: CircularProgressIndicator.adaptive(),
      );

  @override
  Widget build(BuildContext context) {
    final data = _imageData;

    return AnimatedCrossFade(
      duration: widget.animationDuration,
      crossFadeState:
          data == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: placeholder(context),
      secondChild: data == null || data.isEmpty
          ? const SizedBox.shrink()
          : Image.memory(
              data,
              width: widget.width,
              height: widget.height,
              fit: widget.fit,
              filterQuality: FilterQuality.medium,
              errorBuilder: (context, __, ___) {
                _isCached = false;
                _imageData = null;
                WidgetsBinding.instance.addPostFrameCallback(_tryLoad);
                return placeholder(context);
              },
            ),
    );
  }
}
