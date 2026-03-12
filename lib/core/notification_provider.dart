import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  bool _notificationsEnabled = true;

  bool get notificationsEnabled => _notificationsEnabled;

  NotificationProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    notifyListeners();
  }

  Future<void> toggleNotifications(bool value) async {
    if (value) {
      // Re-trigger permission request if turning ON
      final granted = await NotificationService().requestPermissions();
      if (!granted) {
        // Permission denied, don't update state to true
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
