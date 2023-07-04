import 'dart:async';
import 'dart:io';

import 'package:app/core/config.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/service/webview/webview_token_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

@RoutePage()
class EventDetailPage extends StatefulWidget {
  final String eventId;
  final String eventName;
  const EventDetailPage({
    super.key,
    @PathParam('id') required this.eventId,
    @PathParam('name') required this.eventName,
  });

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> with WidgetsBindingObserver {
  bool isReady = false;
  bool isLoaded = false;

  String token = '';
  int maxSendTokenAttempt = 5;
  int sendTokenAttempt = 0;

  late WebviewTokenService webviewTokenService = WebviewTokenService(onTokenChanged: (_token) {
      token = _token;
      _sendTokenToWebview();
    });

  final GlobalKey webViewKey = GlobalKey();
  
  URLRequest? initialRequest;

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
        javaScriptEnabled: true,
        transparentBackground: true,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

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

  _sendTokenToWebview() async {
    sendTokenAttempt++;
    try {
      webViewController?.evaluateJavascript(source: 'document.mobileAuthToken = \"${token}\"');
    } catch (e) {
      if (sendTokenAttempt >= maxSendTokenAttempt) return;
      print('Retry times: $sendTokenAttempt');
      await Future.delayed(Duration(milliseconds: 5000));
      _sendTokenToWebview();
    }
  }

  _getInitialRequest() async {
    try {
      var headers = await webviewTokenService.generateHeaderWithToken();
      if(headers == null) {
        await _clearWebStorage();
      }
      initialRequest = URLRequest(url: Uri.parse(_getEventWebUrl()), headers: headers);
    } catch (e) {}
  }

  String _getEventWebUrl() {
    return '${AppConfig.webUrl}/event/${widget.eventId}';
  }

  Future<void> _clearWebStorage() async {
    WebStorageManager webStorageManager = WebStorageManager.instance();
    if (Platform.isIOS) {
      // if current platform is iOS, delete all data for "flutter.dev".
      var records = await webStorageManager.ios.fetchDataRecords(
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
      appBar: AppBar(
        title: Text(widget.eventName),
        leading: LemonBackButton(),
      ),
      body: Stack(
        children: [
          if(isReady) InAppWebView(
            key: webViewKey,
            initialUrlRequest: initialRequest,
            initialOptions: options,
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onProgressChanged: (context, progress) {
              if(progress == 100) {
                _oWebViewLoaded();
              }
            },
          ),
          if (!isReady || !isLoaded)
            Container(
              color: colorScheme.primary,
              child: Center(
                child: CupertinoActivityIndicator(
                  animating: true,
                  color: colorScheme.onPrimary,
                ),
              ),
            )
        ],
      ),
    );
  }
}
