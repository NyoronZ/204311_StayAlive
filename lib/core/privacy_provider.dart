/*
 * File: privacy_provider.dart
 * Description: ChangeNotifier that manages Terms acceptance and
 *              location permission state, persisting both via SharedPreferences.
 *
 * Dependencies:
 * - SharedPreferences
 * - geolocator
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
import 'package:geolocator/geolocator.dart';

/// Manages Terms acceptance and location permission state.
///
/// Fields:
/// - _hasAcceptedTerms: whether the user has accepted Terms and Conditions
/// - _locationEnabled: whether location permission has been granted
///
/// Usage:
/// - Provided globally via [MultiProvider] in main.dart
/// - Read by `SplashScreen`, `TermsConsentScreen`, and `PrivacySettingsScreen`
class PrivacyProvider extends ChangeNotifier {
  bool _hasAcceptedTerms = false;
  bool _locationEnabled = false;

  /// Whether the user has accepted the Terms and Conditions.
  bool get hasAcceptedTerms => _hasAcceptedTerms;

  /// Whether location permission is currently enabled.
  bool get locationEnabled => _locationEnabled;

  /// Creates a [PrivacyProvider] and loads persisted preferences.
  PrivacyProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _hasAcceptedTerms = prefs.getBool('hasAcceptedTerms') ?? false;
    _locationEnabled = prefs.getBool('locationEnabled') ?? false;
    notifyListeners();
  }

  /// Updates the Terms acceptance state and persists the change.
  ///
  /// Side effects:
  /// - Updates [_hasAcceptedTerms]
  /// - Writes [hasAcceptedTerms] to SharedPreferences
  /// - Notifies all listeners
  Future<void> toggleTerms(bool value) async {
    _hasAcceptedTerms = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasAcceptedTerms', value);
    notifyListeners();
  }

  /// Requests location permission and updates the enabled state.
  ///
  /// Returns `true` if permission is granted, `false` if denied or
  /// permanently denied.
  ///
  /// Side effects:
  /// - Calls [Geolocator.requestPermission] when enabling
  /// - Updates [_locationEnabled] and writes to SharedPreferences
  /// - Notifies all listeners
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
