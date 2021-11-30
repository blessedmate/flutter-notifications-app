// SHA1: D3:E6:8E:54:38:E7:EB:D7:F4:51:C2:ED:D1:3D:FB:09:1D:A2:3D:69

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageStream =
      StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage msg) async {
    // print('Background handler ${msg.messageId}');
    print(msg.data);
    _messageStream.add(msg.data['product'] ?? 'No data');
  }

  static Future _onMessageHandler(RemoteMessage msg) async {
    // print('onMessage handler ${msg.messageId}');
    print(msg.data);
    _messageStream.add(msg.data['product'] ?? 'No data');
  }

  static Future _onOpenApp(RemoteMessage msg) async {
    // print('onOpenApp handler ${msg.messageId}');
    print(msg.data);
    _messageStream.add(msg.data['product'] ?? 'No data');
  }

  static Future initializeApp() async {
    // Push Notifications
    await Firebase.initializeApp();
    token = await messaging.getToken();
    print('Token: $token');

    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onOpenApp);

    // Local Notifications
  }

  static closeStreams() {
    _messageStream.close();
  }
}
