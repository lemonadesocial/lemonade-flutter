import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

@RoutePage()
class WebviewPage extends StatefulWidget {
  final Uri uri;
  const WebviewPage({
    super.key,
    required this.uri,
  });

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  late final _MyBrowser inAppBrowser = _MyBrowser(
    onClose: () {
      close();
    },
  );

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      openBrowser();
    });
  }

  close() {
    AutoRouter.of(context).pop();
  }

  openBrowser() async {
    try {
      await inAppBrowser.openUrlRequest(
        options: InAppBrowserClassOptions(
          crossPlatform:
              InAppBrowserOptions(toolbarTopBackgroundColor: Colors.white),
        ),
        urlRequest: URLRequest(url: WebUri(widget.uri.toString())),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error openBrowser: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }
}

class _MyBrowser extends InAppBrowser {
  final Function() onClose;
  _MyBrowser({required this.onClose});

  @override
  void onExit() {
    super.onExit();
    onClose();
  }
}
