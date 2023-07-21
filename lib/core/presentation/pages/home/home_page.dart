import 'package:app/core/service/firebase/firebase_service.dart';
import 'package:app/core/utils/navigation_utils.dart';
import 'package:app/theme/color.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePage> {
  
  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      try {
          String type = initialMessage.data['type']; 
          String objectId = initialMessage.data['object_id']; 
          String objectType = initialMessage.data['object_type'];
          NavigationUtils.handleNotificationNavigate(context, type, objectType, objectId);
        } catch (e) {
          print("Error parsing JSON: $e");
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LemonColor.black,
      body: const Center(
        child: Text('Home'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      FirebaseService.setContext(context);
    });
    setupInteractedMessage();
  }
}
