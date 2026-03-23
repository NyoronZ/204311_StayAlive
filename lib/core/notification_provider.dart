/*
 * File: notification_provider.dart
 * Description: ChangeNotifier that manages the notification enabled
 *              state and persists it via SharedPreferences.
 *
 * Dependencies:
 * - NotificationService
 * - SharedPreferences
 *
 * Lifecycle:
 * - Instantiated once in main.dart via MultiProvider
 * - Lives for the entire app session
 *
 * Author: Rattanun Deewongsai
 * Course: Mobile Application Development Framework
 */

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notification_service.dart';

/// Manages the notification permission and enabled state.
///
/// Fields:
/// - _notificationsEnabled: whether notifications are currently enabled
///
/// Usage:
/// - Provided globally via [MultiProvider] in main.dart
/// - Read by [SettingsScreen] to render the notifications toggle
class NotificationProvider extends ChangeNotifier {
  bool _notificationsEnabled = true;

  /// Whether push notifications are currently enabled.
  bool get notificationsEnabled => _notificationsEnabled;

  /// Creates a [NotificationProvider] and loads persisted preferences.
  NotificationProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    notifyListeners();
  }

  /// Toggles notifications on or off and persists the change.
  ///
  /// When enabling, re-requests the system notification permission
  /// via [NotificationService]. If permission is denied, the state
  /// remains false and listeners are notified.
  ///
  /// Side effects:
  /// - Updates [_notificationsEnabled]
  /// - Writes [notificationsEnabled] to SharedPreferences
  /// - Notifies all listeners
  Future<void> toggleNotifications(bool value) async {
    if (value) {
      // Re-trigger permission request if turning ON
      final granted = await NotificationService().requestPermissions();
      // Permission denied, don't update state to true
      if (!granted) {
        _notificationsEnabled = false;
        notifyListeners();
        return;
      }
    }

    _notificationsEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', value);
    notifyListeners();
  }
}
