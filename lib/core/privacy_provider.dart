import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

class PrivacyProvider extends ChangeNotifier {
  bool _hasAcceptedTerms = false;
  bool _locationEnabled = false;

  bool get hasAcceptedTerms => _hasAcceptedTerms;
  bool get locationEnabled => _locationEnabled;

  PrivacyProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _hasAcceptedTerms = prefs.getBool('hasAcceptedTerms') ?? false;
    _locationEnabled = prefs.getBool('locationEnabled') ?? false;
    notifyListeners();
  }

  Future<void> toggleTerms(bool value) async {
    _hasAcceptedTerms = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasAcceptedTerms', value);
    notifyListeners();
  }

  Future<bool> toggleLocation(bool value) async {
    if (value) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try requesting permissions again (this is also where Android's shouldShowRequestPermissionRationale comes into play).
          return false;
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately. 
        return false;
      }
    }

    _locationEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('locationEnabled', value);
    notifyListeners();
    return true;
  }
}
