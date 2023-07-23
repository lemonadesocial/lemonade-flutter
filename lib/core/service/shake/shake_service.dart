import 'package:app/core/config.dart';
import 'package:app/core/service/firebase/firebase_service.dart';
import 'package:flutter/services.dart';
import 'package:shake/shake.dart';
import 'package:flutter/material.dart';

class ShakeService {
  bool _isCopied = false;
  late final FirebaseService firebaseService = FirebaseService();
  ShakeDetector? _detector;

  void startShakeDetection(BuildContext context) {
    if (_detector == null) {
      _detector = ShakeDetector.autoStart(
        onPhoneShake: () async {
          String? fcmToken = await firebaseService.getToken();
          showShakeBottomSheet(context, fcmToken);
        },
        minimumShakeCount: 1,
        shakeSlopTimeMS: 500,
        shakeCountResetTime: 3000,
        shakeThresholdGravity: 2.7,
      );
    }
  }

  void stopShakeDetection() {
    _detector?.stopListening();
  }

  void showShakeBottomSheet(BuildContext context, String? fcmToken) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Debug info',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "Environment: " + AppConfig.env,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "Backend url: " + AppConfig.backedUrl,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "FCM Token: " + (fcmToken ?? 'N/A'),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.copy),
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
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'FCM Token copied to clipboard',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  SizedBox(height: 16.0),
                  Container(
                    // Use Container to set button width to full
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      child: Text('Close'),
                    ),
                  ),
                ],
              ),
            );
          },
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
