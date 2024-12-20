import 'dart:async';
import 'dart:io';

import 'package:app/core/config.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/service/webview/webview_token_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

@RoutePage()
class EventDetailPageWebView extends StatefulWidget {
  const EventDetailPageWebView({
    super.key,
    @PathParam('id') required this.eventId,
    @PathParam('name') required this.eventName,
  });
  final String eventId;
  final String eventName;

  @override
  State<EventDetailPageWebView> createState() => _EventDetailPageWebViewState();
}

class _EventDetailPageWebViewState extends State<EventDetailPageWebView>
    with WidgetsBindingObserver {
  bool isReady = false;
  bool isLoaded = false;

  String token = '';
  int maxSendTokenAttempt = 5;
  int sendTokenAttempt = 0;

  late WebviewTokenService webviewTokenService = WebviewTokenService(
    onTokenChanged: (t) {
      token = t;
      _sendTokenToWebview();
    },
  );

  final GlobalKey webViewKey = GlobalKey();

  URLRequest? initialRequest;

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
      transparentBackground: true,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _initialize();
  }

  @override
  dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    webviewTokenService.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        webviewTokenService.cancel();
      case AppLifecycleState.inactive:
        webviewTokenService.cancel();
        break;
      case AppLifecycleState.resumed:
        webviewTokenService.start();
        break;
      default:
    }
  }

  _initialize() async {
    await _getInitialRequest();
    setState(() {
      isReady = true;
    });
  }

  Future<void> _sendTokenToWebview() async {
    sendTokenAttempt++;
    try {
      webViewController?.evaluateJavascript(
        source: 'document.mobileAuthToken = "$token"',
      );
    } catch (e) {
      if (sendTokenAttempt >= maxSendTokenAttempt) return;
      if (kDebugMode) {
        print('Retry times: $sendTokenAttempt');
      }
      await Future.delayed(const Duration(milliseconds: 5000));
      _sendTokenToWebview();
    }
  }

  _getInitialRequest() async {
    try {
      var headers = await webviewTokenService.generateHeaderWithToken();
      if (headers == null) {
        await _clearWebStorage();
      }
      initialRequest = URLRequest(
        url: WebUri(_getEventWebUrl()),
        headers: headers,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error _getInitialRequest: $e');
      }
    }
  }

  String _getEventWebUrl() {
    return '${AppConfig.webUrl}/event/${widget.eventId}';
  }

  Future<void> _clearWebStorage() async {
    final webStorageManager = WebStorageManager.instance();
    if (Platform.isIOS) {
      // if current platform is iOS, delete all data for "flutter.dev".
      final records = await webStorageManager.ios.fetchDataRecords(
        dataTypes: IOSWKWebsiteDataType.values,
      );
      await webStorageManager.ios.removeDataFor(
        dataTypes: IOSWKWebsiteDataType.values,
        dataRecords: records,
      );
    }
    if (Platform.isAndroid) {
      await webStorageManager.android.deleteAllData();
    }
  }

  _oWebViewLoaded() {
    webviewTokenService.start();
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: LemonAppBar(
        title: widget.eventName,
      ),
      body: Stack(
        children: [
          if (isReady)
            InAppWebView(
              key: webViewKey,
              initialUrlRequest: initialRequest,
              initialOptions: options,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onProgressChanged: (context, progress) {
                if (progress == 100) {
                  _oWebViewLoaded();
                }
              },
            ),
          if (!isReady || !isLoaded)
            Container(
              color: colorScheme.primary,
              child: Center(
                child: CupertinoActivityIndicator(
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
