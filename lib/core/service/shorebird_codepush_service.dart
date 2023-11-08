import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

@lazySingleton
class ShorebirdCodePushService with WidgetsBindingObserver {
  final ShorebirdCodePush _shorebirdCodePush = ShorebirdCodePush();
  late BuildContext context;

  ShorebirdCodePushService() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      debugPrint('App resumed from background');
      checkForUpdate(context);
    }
  }

  bool isShorebirdAvailable() {
    return _shorebirdCodePush.isShorebirdAvailable();
  }

  Future<bool> isNewPatchReadyToInstall() async {
    return await _shorebirdCodePush.isNewPatchReadyToInstall();
  }

  Future<int?> getCurrentPatchVersion() async {
    return await _shorebirdCodePush.currentPatchNumber();
  }

  Future<void> downloadUpdateIfAvailable() {
    return _shorebirdCodePush.downloadUpdateIfAvailable();
  }

  Future<void> checkForUpdate(BuildContext context) async {
    debugPrint('Checking for update...');
    this.context = context;
    bool isUpdateAvailable =
        await _shorebirdCodePush.isNewPatchAvailableForDownload();
    if (isUpdateAvailable) {
      debugPrint('Update available');
      AutoRouter.of(context).navigate(
        const ShorebirdUpdateRoute(),
      );
    } else {
      debugPrint('No update available');
    }
  }
}
