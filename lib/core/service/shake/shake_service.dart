import 'package:app/core/config.dart';
import 'package:app/core/oauth/oauth.dart';
import 'package:app/core/service/firebase/firebase_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shake/shake.dart';

@lazySingleton
class ShakeService {
  bool _isCopied = false;
  bool _isDialogShowing = false;
  late final FirebaseService firebaseService = FirebaseService();
  ShakeDetector? _detector;

  void startShakeDetection(BuildContext context) {
    // Not allow in production build
    if (AppConfig.isProduction) {
      return;
    }
    _detector ??= ShakeDetector.autoStart(
      onPhoneShake: () {
        if (!_isDialogShowing) {
          showDebugInfoDialog(context);
        }
      },
    );
  }

  void stopShakeDetection() {
    _detector?.stopListening();
  }

  Future<void> showDebugInfoDialog(BuildContext context) async {
    _isDialogShowing = true;
    final fcmToken = await firebaseService.getToken();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          child: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Debug info',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Environment: ${AppConfig.env}',
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Backend url: ${AppConfig.backedUrl}',
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "FCM Token: ${fcmToken ?? 'N/A'}",
                            textAlign: TextAlign.left,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            _copyToClipboard(fcmToken);
                            setState(() {
                              _isCopied = true;
                            });
                          },
                        ),
                      ],
                    ),
                    if (_isCopied)
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          'FCM Token copied to clipboard',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    const SizedBox(height: 16),
                    FutureBuilder<PackageInfo>(
                      future: PackageInfo.fromPlatform(),
                      builder: (context, snapshot) {
                        return Text(
                          'App version: ${snapshot.data?.version}\nBuild number: ${snapshot.data?.buildNumber}',
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _isDialogShowing = false;
                          getIt<AppOauth>().forceLogout();
                          Navigator.pop(context);
                        },
                        child: const Text('Force logout'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      // Use Container to set button width to full
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _isDialogShowing = false;
                          Navigator.pop(context); // Close the bottom sheet
                        },
                        child: const Text('Close'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _copyToClipboard(String? text) {
    if (text != null && text.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: text));
    }
  }
}
