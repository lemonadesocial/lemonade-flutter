import 'dart:convert';

import 'package:app/core/config.dart';
import 'package:app/core/data/crypto_ramp/stripe_onramp/dtos/stripe_onramp_session_dto/stripe_onramp_session_dto.dart';
import 'package:app/core/domain/crypto_ramp/stripe_onramp/entities/stripe_onramp_session/stripe_onramp_session.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class StripeOnrampWebview extends StatelessWidget {
  static const _handlerName = 'stripeOnrampResultHandler';

  final StripeOnrampSession stripeOnrampSession;
  final Function(StripeOnrampSession session)? onStripeOnrampSessionUpdated;

  const StripeOnrampWebview({
    super.key,
    required this.stripeOnrampSession,
    this.onStripeOnrampSessionUpdated,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: const LemonAppBar(),
      backgroundColor: colorScheme.background,
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(
            '${AppConfig.stripeOnrampHost}?session_key=${stripeOnrampSession.clientSecret}&publishable_key=${stripeOnrampSession.publishableKey}',
          ),
        ),
        onConsoleMessage: (controller, consoleMessage) {
          debugPrint(consoleMessage.message);
        },
        onWebViewCreated: (controller) {
          controller.addJavaScriptHandler(
            handlerName: _handlerName,
            callback: (data) {
              try {
                if (data.isEmpty) return;
                final sessionJson = jsonDecode(data.first as String);
                final onrampSession = StripeOnrampSession.fromDto(
                  StripeOnrampSessionDto.fromJson(sessionJson),
                );
                onStripeOnrampSessionUpdated?.call(onrampSession);
              } catch (e) {
                debugPrint('Failed to parse session data ${e.toString()}');
              }
            },
          );
        },
      ),
    );
  }
}
