import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

@lazySingleton
class ShorebirdCodePushService with WidgetsBindingObserver {
  final ShorebirdCodePush _shorebirdCodePush = ShorebirdCodePush();

  ShorebirdCodePushService() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (kDebugMode) {
        print('App resumed from background');
      }
      checkForUpdate();
    }
  }

  bool isShorebirdAvailable() {
    return _shorebirdCodePush.isShorebirdAvailable();
  }

  Future<int?> getCurrentPatchVersion() async {
    return await _shorebirdCodePush.currentPatchNumber();
  }

  Future<void> checkForUpdate() async {
    if (kDebugMode) {
      print('Checking for update...');
    }
    bool isUpdateAvailable =
        await _shorebirdCodePush.isNewPatchAvailableForDownload();

    if (isUpdateAvailable) {
      if (kDebugMode) {
        print('Update available');
      }
      downloadUpdate();
    } else {
      if (kDebugMode) {
        print('No update available');
      }
    }
  }

  Future<void> downloadUpdate() async {
    if (kDebugMode) {
      print('Downloading update...');
    }
    await _shorebirdCodePush.downloadUpdateIfAvailable();
  }
}
