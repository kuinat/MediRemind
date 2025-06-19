import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medi_remind/services/permission_service.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    await requestExactAlarmPermission();
    tz_data.initializeTimeZones();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    const settings = InitializationSettings(android: android);

    await _notifications.initialize(
      settings,
    );
  }

  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _notifications.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'meds',
          'Médicaments',
          channelDescription: 'Rappels quotidiens pour la prise de médicaments',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }


  Future<void> showTestNotification() async {
    await requestNotificationPermission();
    await FlutterLocalNotificationsPlugin().show(
      1,
      'Test',
      'Icône de notif fonctionnelle',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'test_channel',
          'Test',
          channelDescription: 'Test de notif',
          //icon: 'ic_stat_med', // icône blanche
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );

    // await _notifications.show(
    //   0,
    //   'Test immédiat',
    //   'Notification manuelle',
    //   const NotificationDetails(
    //     android: AndroidNotificationDetails(
    //       'meds', 'Médicaments',
    //       importance: Importance.max,
    //       priority: Priority.high,
    //     ),
    //   ),
    // );
  }
}
