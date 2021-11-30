import 'package:flutter/material.dart';
import 'package:flutter_push_notifications/screens/home_screen.dart';
import 'package:flutter_push_notifications/screens/message_screen.dart';
import 'package:flutter_push_notifications/services/push_notifications_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationsService.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    // Context
    PushNotificationsService.messagesStream.listen((product) {
      // Go to new screen
      navigatorKey.currentState?.popAndPushNamed('message', arguments: product);

      // Show snackbar
      final snackBar = SnackBar(content: Text(product));
      messengerKey.currentState?.showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      navigatorKey: navigatorKey, // Navigation
      scaffoldMessengerKey: messengerKey, // Snackbars
      routes: {
        'home': (_) => const HomeScreen(),
        'message': (_) => const MessageScreen(),
      },
    );
  }
}
