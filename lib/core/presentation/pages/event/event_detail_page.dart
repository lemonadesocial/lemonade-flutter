import 'dart:async';

import 'package:app/core/config.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/service/webview/webview_token_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  late final WebViewController ctrl;
  late WebviewTokenService webviewTokenService;
  final webviewLoadedStreamCtrl = StreamController<bool>.broadcast();
  StreamSubscription? webviewLoadedSubs;

  String token = '';
  int maxSendTokenAttempt = 5;
  int sendTokenAttempt = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    webviewLoadedSubs = webviewLoadedStreamCtrl.stream.listen(
      (loaded) {
        if (loaded) webviewTokenService.start();
      },
    );
    _setupWebViewController();
    _setupWebViewTokenService();
    _loadWebview();
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    webviewTokenService.cancel();
    webviewLoadedSubs?.cancel();
    webviewLoadedStreamCtrl.close();
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

  _setupWebViewController() {
    ctrl = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(onProgress: (progress) {
        if (progress >= 100) {
          webviewLoadedStreamCtrl.add(true);
        }
      }));
  }

  _setupWebViewTokenService() {
    webviewTokenService = WebviewTokenService(onTokenChanged: (_token) {
      token = _token;
      _sendTokenToWebview();
    });
  }

  _loadWebview() async {
    try {
      var headers = await webviewTokenService.generateHeaderWithToken();
      // await ctrl.loadFlutterAsset('assets/index.html');
      await ctrl.loadRequest(Uri.parse(_getEventWebUrl()), headers: headers);
    } catch (e) {}
  }

  String _getEventWebUrl() {
    return '${AppConfig.webUrl}/event/${widget.eventId}/${widget.eventName}';
  }

  _sendTokenToWebview() {
    sendTokenAttempt++;
    ctrl.runJavaScript('sendMessageToJS(\'${token}\')').onError((error, stackTrace) async {
      if (sendTokenAttempt >= maxSendTokenAttempt) return;
      print('Retry times: $sendTokenAttempt');
      await Future.delayed(Duration(milliseconds: 2000));
      _sendTokenToWebview();
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
        body: Container(
          child: StreamBuilder(
            initialData: false,
            stream: webviewLoadedStreamCtrl.stream,
            builder: (context, snapshot) => Stack(children: [
              if (snapshot.hasData && snapshot.data!) WebViewWidget(controller: ctrl),
              if (snapshot.hasData && !snapshot.data!)
                Container(
                  color: Colors.black,
                  child: Center(
                    child: CupertinoActivityIndicator(
                      animating: true,
                      color: Colors.white,
                    ),
                  ),
                )
            ]),
          ),
        ));
  }
}
