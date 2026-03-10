import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class NotificationHelper {
  static final notification = FlutterLocalNotificationsPlugin();

  static initialize() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    notification.initialize(settings: initializationSettings);
  }

  static show({required int? progress}) async {
    NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'download_channel',
        'Download Channel',
        silent: true,
        //importance: Importance.max,
        //priority: Priority.max,
      ),
    );
    await notification.show(
      id: 11,
      title: progress != null ? 'File-1.mp4' : 'WorkManager Notification',
      body: progress != null
          ? 'Downloading...$progress%'
          : 'WorkManager Notification Body',
      notificationDetails: notificationDetails,
    );
  }
}
