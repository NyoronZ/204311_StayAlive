/*
 * File: hospital_service.dart
 * Description: Handles network requests to the Overpass API to fetch nearby hospitals,
 * processes the geographic data, and handles external map routing.
 *
 * Dependencies:
 * - geolocator (For distance calculations and position data)
 * - http (For Overpass API requests)
 * - dart:convert (For JSON parsing)
 * - url_launcher (For opening external maps)
 *
 * Notes:
 * - No UI logic should appear in this file
 * - Uses async network operations
 *
 * Author: Kitichai Fanprom
 * Course: Mobile Application Development Framework
 */

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

/// A service class for fetching hospital data and handling map routing.
class HospitalService {
  static List<Map<String, dynamic>>? _cachedHospitals;
  static Position? _lastFetchPosition;

  /// Fetches nearby hospitals within a 10km radius from the given [position].
  ///
  /// Uses cached data if the device has moved less than 100 meters since the last fetch.
  /// Throws an [Exception] if the network request fails or the server returns an error.
  static Future<List<Map<String, dynamic>>> fetchNearbyHospitals(
      Position position) async {
    // Return cached data if the user has moved less than 100 meters.
    if (_cachedHospitals != null && _lastFetchPosition != null) {
      final distanceDiff = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          _lastFetchPosition!.latitude,
          _lastFetchPosition!.longitude);

      if (distanceDiff < 100) {
        return _cachedHospitals!;
      }
    }

    final lat = position.latitude;
    final lon = position.longitude;
    const radius = 10000; // 10 kilometers

    final query = '''
      [out:json][timeout:25];
      (
        node["amenity"="hospital"](around:$radius,$lat,$lon);
        way["amenity"="hospital"](around:$radius,$lat,$lon);
      );
      out center;
    ''';

    final url = Uri.parse(
        'https://overpass-api.de/api/interpreter?data=${Uri.encodeComponent(query)}');

    final response = await http.get(url).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      final elements = data['elements'] as List;
      List<Map<String, dynamic>> fetchedHospitals = [];

      for (var el in elements) {
        final tags = el['tags'] ?? {};
        final nameTh = tags['name:th'] ?? tags['name'] ?? '';
        final nameEn = tags['name:en'] ?? tags['name'] ?? '';

        if (nameTh.isEmpty && nameEn.isEmpty) continue;

        final nameLower = (nameTh + nameEn).toLowerCase();

        // Filter out irrelevant clinics, dental offices, and animal hospitals.
        if (nameLower.contains('คลินิก') ||
            nameLower.contains('clinic') ||
            nameLower.contains('ทันตกรรม') ||
            nameLower.contains('dental') ||
            nameLower.contains('สัตว์') ||
            nameLower.contains('animal') ||
            nameLower.contains('ความงาม') ||
            nameLower.contains('ศัลยกรรม')) {
          continue;
        }

        final hLat = el['lat'] ?? el['center']['lat'];
        final hLon = el['lon'] ?? el['center']['lon'];
        final distanceKm =
            Geolocator.distanceBetween(lat, lon, hLat, hLon) / 1000;

        fetchedHospitals.add({
          'name': nameTh.isNotEmpty ? nameTh : nameEn,
          'name_en': nameEn,
          'lat': hLat,
          'lon': hLon,
          'distance': distanceKm,
        });
      }

      // Sort hospitals by proximity.
      fetchedHospitals.sort((a, b) => a['distance'].compareTo(b['distance']));

      _cachedHospitals = fetchedHospitals;
      _lastFetchPosition = position;

      return fetchedHospitals;
    } else {
      throw Exception('server_error');
    }
  }

  /// Opens the external map application to the specified coordinates.
  ///
  /// The [lat] and [lon] must be valid map coordinates.
  static Future<void> openRealMap(double lat, double lon) async {
    final String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    final Uri uri = Uri.parse(googleMapsUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
