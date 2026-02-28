import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_1/main.dart';
import 'package:flutter_basics_1/routes/page_address.dart';
import 'package:path/path.dart';
//import 'package:firebase_messaging_platform_interface/firebase_messaging_platform_interface.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Token for Vivo
//Token : dN4G88RnR7qu5Drc9zyPgn:APA91bF-QN8L2zY3KGsHLvgX_kZhj4sNpQRk39J-_Loo5epas_PjJy5z4M1CsT-wusAzlaOHEL3Fk9A1AKT9CkDUGIOlzXFAW8mjZXC85JnyChxKtTh1ksU
// cs2covM0TuC7hSYUj7jwfO:APA91bFGd0jgbxwNV8ATpDFmKG-u294qo_mQA5GJFRBFAdAddCSsid3fiXtZ_VajrLuraApNY8TxCAPM9oVSyswydurlw9hiR8JwqWDmuK5fKfOgm79d40w
// dlzhyzoPSB-t-BFtUKxrB7:APA91bGMzn8U9V5zIusZ2tzxkOjQReQI4r0Zee_clfGSlB9nUDrFItQAEIk6rX5RbjlkeSF1vTehlxl6RGMG2laNtZT4ueDQvfxO6bUyfHagHBR-JT3W-LY

class FirebasePushApi {
  // create an instance of Firebase Messaging

  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    // request permission from user (will prompt user)
    await _firebaseMessaging.requestPermission();

    // fetch the FOM token for the device
    final token = await _firebaseMessaging.getToken();

    // print token to see
    if (token != null) {
      print('Token : $token');
    } else {
      print('Token is null');
    }

    //------
    final String id = await FirebaseInstallations.instance.getId();
    print('Initialization : $id');

    // FirebaseMessaging.onMessage.listen((RemoteMessage? msg) {
    //   _handleForegroundMessage(msg);
    //
    //   /*
    //   print(
    //     'Message received in foreground\nMessage title: ${msg?.notification?.title},\nbody: ${msg?.notification?.body},\ndata: ${msg?.data}',
    //   );
    //
    //   final notification = msg?.notification;
    //   final context = navigatorKey.currentContext;
    //
    //   if (notification == null || context == null || !context.mounted) return;
    //   showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //       title: Text(notification.title ?? 'Notification'),
    //       content: Text(notification.body ?? ''),
    //       actions: [
    //         TextButton(
    //           onPressed: () => Navigator.pop(context),
    //           child: Text('OK'),
    //         ),
    //       ],
    //     ),
    //   );
    //   */
    // });
    /*
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleMessages(message);
      print(
        'Message title: ${message.notification?.title},\nbody: ${message.notification?.body},\ndata: ${message.data}',
      );
    });

    // notification that is received when app is background
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      print(
        'Message title: ${message.notification?.title},\nbody: ${message.notification?.body},\ndata: ${message.data}',
      );
    });
    */
    //------

    // initialize settings for push notification
    initBackgroundHandler();

    /*
    FirebaseMessaging.onMessage.listen((RemoteMessage? msg) {
      final notification = msg?.notification?.title ?? 'N/A';
      final context = navigatorKey.currentContext;
      if (notification == null || context == null || !context.mounted) return;
      showDialog(context: context, builder: (context) => AlertDialog());
    });
    */

    // ---
    // final androidImplementation = _firebaseMessaging
    //     .resolvePlatformSpecificImplementation<
    //       AndroidFlutterFirebaseMessagingPlugin
    //     >();
    // await androidImplementation?.createNotificationChannel(
    //   const AndroidNotificationChannel(
    //     'high_importance_channel',
    //     'High Importance Notifications',
    //     description: 'This channel is used for important notifications.',
    //     importance: Importance.high,
    //   ),
    // );
    // -------

    // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    //     FlutterLocalNotificationsPlugin();
    //
    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //       AndroidFlutterLocalNotificationsPlugin
    //     >()
    //     ?.createNotificationChannel(
    //       const AndroidNotificationChannel(
    //         'high_importance_channel',
    //         'High Importance Notifications',
    //         description: 'This channel is used for important notifications.',
    //         importance: Importance.high,
    //       ),
    //     );
  }

  void _handleForegroundMessage(RemoteMessage? msg) {
    print('Message received in foreground: ${msg?.notification?.title}');
    final notification = msg?.notification;
    if (notification == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = navigatorKey.currentContext;

      if (context == null || !context.mounted) {
        print('Context is null or not mounted');
        return;
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(notification.title ?? 'Notification'),
          content: Text(notification.body ?? ''),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  // function that handles recieved messages
  void handleMessages(RemoteMessage? msg) {
    if (msg == null) return;
    navigatorKey.currentState?.pushNamed(
      PageAddress.NOTIFICATION,
      arguments: msg,
    );
  }

  // function to initialize background settings
  Future<void> initBackgroundHandler() async {
    // handle notification if the app was terminated and now open
    FirebaseMessaging.instance.getInitialMessage().then(handleMessages);

    // attach event listeners for when a notification opens the app
  }
}
