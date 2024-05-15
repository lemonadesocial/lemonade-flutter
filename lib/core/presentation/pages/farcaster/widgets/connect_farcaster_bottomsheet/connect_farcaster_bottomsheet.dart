import 'dart:async';

import 'package:app/core/domain/farcaster/entities/farcaster_account_key_request.dart';
import 'package:app/core/domain/farcaster/entities/farcaster_signed_key_request.dart';
import 'package:app/core/domain/farcaster/farcaster_repository.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectFarcasterBottomsheet extends StatefulWidget {
  final Function()? onConnected;
  const ConnectFarcasterBottomsheet({
    super.key,
    this.onConnected,
  });

  @override
  State<ConnectFarcasterBottomsheet> createState() =>
      _ConnectFarcasterBottomsheetState();
}

class _ConnectFarcasterBottomsheetState
    extends State<ConnectFarcasterBottomsheet> {
  bool _sessionCreated = false;
  Timer? _timer;
  FarcasterAccountKeyRequest? _accountKeyRequest;

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  Future<void> createFarcasterAccountKey() async {
    final response = await showFutureLoadingDialog(
      context: context,
      future: () async {
        return getIt<FarcasterRepository>().createFarcasterAccountKey();
      },
    );
    response.result?.fold((l) => null, (mAccountKeyRequest) async {
      if (mAccountKeyRequest.deeplinkUrl == null) {
        return;
      }
      setState(() {
        _accountKeyRequest = mAccountKeyRequest;
        _sessionCreated = true;
      });
      await launchUrl(
        Uri.parse(mAccountKeyRequest.deeplinkUrl!),
      );
      startIntervalCheck();
    });
  }

  void startIntervalCheck() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      final result = await getIt<FarcasterRepository>().getConnectRequest(
        _accountKeyRequest?.token ?? '',
      );
      result.fold(
        (l) => null,
        (signedKeyRequest) {
          if (signedKeyRequest.state ==
              FarcasterSignedKeyRequestState.completed) {
            _timer?.cancel();
            widget.onConnected?.call();
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(Spacing.smMedium),
      color: LemonColor.atomicBlack,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              t.farcaster.connectFarcaster,
              style: Typo.extraLarge.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w700,
                fontFamily: FontFamily.nohemiVariable,
              ),
            ),
            SizedBox(height: Spacing.superExtraSmall),
            Text(
              t.farcaster.connectFarcasterDescription,
              style: Typo.mediumPlus.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
            SizedBox(height: Spacing.smMedium),
            LinearGradientButton.primaryButton(
              loadingWhen: _sessionCreated,
              onTap: () {
                if (_sessionCreated) {
                  return;
                }
                createFarcasterAccountKey();
              },
              label: StringUtils.capitalize(t.common.actions.connect),
            ),
          ],
        ),
      ),
    );
  }
}
