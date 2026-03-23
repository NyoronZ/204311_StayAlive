/*
 * File: notification_service.dart
 * Description: Singleton service that wraps FlutterLocalNotificationsPlugin
 *              to initialise, request permissions, and show notifications.
 *
 * Dependencies:
 * - flutter_local_notifications
 * - SharedPreferences (to check enabled state before showing)
 *
 * Lifecycle:
 * - Instantiated as a singleton; init() called once in main.dart
 * - Lives for the entire app session
 *
 * Author: Rattanun Deewongsai
 * Course: Mobile Application Development Framework
 */

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Singleton service for managing local notifications.
///
/// Fields:
/// - _instance: the single shared instance
/// - flutterLocalNotificationsPlugin: the underlying plugin instance
///
/// Usage:
/// - Call [init] once at app startup
/// - Use [requestPermissions] to prompt the user for permission
/// - Use [showNotification] to display a local notification
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  /// Returns the singleton instance of [NotificationService].
  factory NotificationService() {
    return _instance;
  }

  /// Private constructor for singleton pattern.
  NotificationService._internal();

  /// The underlying local notifications plugin instance.
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Initialises the notification plugin for Android and iOS.
  ///
  /// Must be called once before any other method on this service.
  /// Throws if the plugin fails to initialise.
  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
    );
  }

  /// Requests the system notification permission from the user.
  ///
  /// Returns `true` if permission is granted, `false` otherwise.
  /// Handles both Android and iOS permission models.
  Future<bool> requestPermissions() async {
    // Android handle
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidImplementation != null) {
      final granted =
          await androidImplementation.requestNotificationsPermission();
      return granted ?? false;
    }

    // iOS handle
    final IOSFlutterLocalNotificationsPlugin? iosImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();

    if (iosImplementation != null) {
      final granted = await iosImplementation.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }

    return false;
  }

  /// Displays a local notification if notifications are enabled.
  ///
  /// Reads [notificationsEnabled] from SharedPreferences before showing.
  /// Does nothing if notifications are disabled by the user.
  ///
  /// Side effects:
  /// - Shows a high-priority Android notification on the emergency channel
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    // Do not show notification
    if (!notificationsEnabled) {
      return;
    }
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'emergency_reminders_id',
      'Emergency Reminders',
      channelDescription: 'Reminders after making an emergency call',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: platformChannelSpecifics,
    );
  }
}
