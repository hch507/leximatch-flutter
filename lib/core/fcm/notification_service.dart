import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static const String channelId = 'leximatch_default';

  static final FlutterLocalNotificationsPlugin _plugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize( settings: settings);

    if (Platform.isAndroid) {
      const channel = AndroidNotificationChannel(
        channelId,
        'LexiMatch 알림',
        description: 'LexiMatch 기본 알림 채널',
        importance: Importance.high,
      );

      await _plugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
  }

  static Future<void> showForegroundNotification(
      RemoteMessage message,
      ) async {
    final notification = message.notification;

    const androidDetails = AndroidNotificationDetails(
      channelId,
      'LexiMatch 알림',
      channelDescription: 'LexiMatch 기본 알림 채널',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.show(
      id: message.hashCode,
      title: notification?.title ?? 'LexiMatch',
      body: notification?.body ?? '새 알림이 도착했습니다.',
      notificationDetails: details,
    );
  }
}