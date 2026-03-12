import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; 
import '../../core/language_provider.dart';
import '../../core/privacy_provider.dart';

class FindHospitalScreen extends StatefulWidget {
  const FindHospitalScreen({super.key});

  @override
  State<FindHospitalScreen> createState() => _FindHospitalScreenState();
}

class _FindHospitalScreenState extends State<FindHospitalScreen> {
  final Color primaryGreen = const Color(0xFF10B981);
  
  bool _isLoading = true;
  bool _hasPermission = false;
  bool _isGpsEnabled = false;
  String? _errorMessage;

  Position? _currentPosition;
  List<Map<String, dynamic>> _hospitals = [];
  List<Map<String, dynamic>> _filteredHospitals = [];
  Map<String, dynamic>? _selectedHospital;

  final TextEditingController _searchController = TextEditingController();
  final MapController _mapController = MapController();

  static List<Map<String, dynamic>>? _cachedHospitals;
  static Position? _lastFetchPosition;

  @override
  void initState() {
    super.initState();
    _checkLocationStatus();
  }

  Future<void> _checkLocationStatus() async {
    setState(() => _isLoading = true);
    final privacyProvider = Provider.of<PrivacyProvider>(context, listen: false);
    
    _isGpsEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();
    _hasPermission = (permission == LocationPermission.always || permission == LocationPermission.whileInUse);
    
    // Check both OS permissions and app-level privacy setting
    if (_isGpsEnabled && _hasPermission && privacyProvider.locationEnabled) {
      await _fetchLocationAndHospitals();
    } else {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _requestPermissionAndEnableGps() async {
    final lang = Provider.of<LanguageProvider>(context, listen: false);
    setState(() { _isLoading = true; _errorMessage = null; });
    final privacyProvider = Provider.of<PrivacyProvider>(context, listen: false);

    _isGpsEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_isGpsEnabled) {
      await Geolocator.openLocationSettings();
      setState(() => _isLoading = false);
      return; 
    }
    
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission(); 
    }
    
    if (permission == LocationPermission.deniedForever) {
      setState(() { 
        _errorMessage = lang.translate('find_hospital_sec', 'app_settings_needed'); 
        _isLoading = false; 
      });
      await Geolocator.openAppSettings();
      return;
    }
    
    _hasPermission = (permission == LocationPermission.always || permission == LocationPermission.whileInUse);
    
    if (_hasPermission) {
      // If OS permission is granted, also enable it in app-level privacy settings
      await privacyProvider.toggleLocation(true);
    }

    if (_isGpsEnabled && _hasPermission && privacyProvider.locationEnabled) {
      await _fetchLocationAndHospitals();
    } else {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchLocationAndHospitals() async {
    final lang = Provider.of<LanguageProvider>(context, listen: false);
    setState(() { _isLoading = true; _errorMessage = null; });
    try {
      _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high, timeLimit: const Duration(seconds: 10));
    } catch (e) {
      _currentPosition = await Geolocator.getLastKnownPosition();
      if (_currentPosition == null) {
        setState(() { 
          _errorMessage = lang.translate('find_hospital_sec', 'no_coordinates'); 
          _isLoading = false; 
        });
        return;
      }
    }

    if (_cachedHospitals != null && _lastFetchPosition != null) {
      final distanceDiff = Geolocator.distanceBetween(
        _currentPosition!.latitude, _currentPosition!.longitude, 
        _lastFetchPosition!.latitude, _lastFetchPosition!.longitude
      );
      
      if (distanceDiff < 100) { 
        setState(() { _hospitals = _cachedHospitals!; _filteredHospitals = _cachedHospitals!; _isLoading = false; });
        return; 
      }
    }

    try {
      final lat = _currentPosition!.latitude;
      final lon = _currentPosition!.longitude;
      final radius = 10000; 

      final query = '''
        [out:json][timeout:25];
        (
          node["amenity"="hospital"](around:$radius,$lat,$lon);
          way["amenity"="hospital"](around:$radius,$lat,$lon);
        );
        out center;
      ''';

      final url = Uri.parse('https://overpass-api.de/api/interpreter?data=${Uri.encodeComponent(query)}');
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
          if (nameLower.contains('คลินิก') || nameLower.contains('clinic') || nameLower.contains('ทันตกรรม') || nameLower.contains('dental') || nameLower.contains('สัตว์') || nameLower.contains('animal') || nameLower.contains('ความงาม') || nameLower.contains('ศัลยกรรม')) {
            continue; 
          }

          final hLat = el['lat'] ?? el['center']['lat'];
          final hLon = el['lon'] ?? el['center']['lon'];
          final distanceKm = Geolocator.distanceBetween(lat, lon, hLat, hLon) / 1000;

          fetchedHospitals.add({
            'name': nameTh.isNotEmpty ? nameTh : nameEn,
            'name_en': nameEn,
            'lat': hLat,
            'lon': hLon,
            'distance': distanceKm,
          });
        }
        fetchedHospitals.sort((a, b) => a['distance'].compareTo(b['distance']));

        _cachedHospitals = fetchedHospitals;
        _lastFetchPosition = _currentPosition;

        setState(() { _hospitals = fetchedHospitals; _filteredHospitals = fetchedHospitals; _isLoading = false; });
      } else {
        setState(() { 
          _errorMessage = lang.translate('find_hospital_sec', 'server_error'); 
          _isLoading = false; 
        });
      }
    } catch (e) {
      setState(() { 
        _errorMessage = lang.translate('find_hospital_sec', 'connection_error'); 
        _isLoading = false; 
      });
    }
  }

  void _filterSearch(String query) {
    final lowerQuery = query.toLowerCase();
    setState(() {
      _filteredHospitals = _hospitals.where((h) {
        final nameTh = h['name'].toString().toLowerCase();
        final nameEn = (h['name_en'] ?? '').toString().toLowerCase();
        return nameTh.contains(lowerQuery) || nameEn.contains(lowerQuery);
      }).toList();
    });
  }

  Future<void> _openRealMap(double lat, double lon) async {
    final String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    final Uri uri = Uri.parse(googleMapsUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication); 
    }
  }

  void _handleBack() {
    if (_selectedHospital != null) {
      setState(() => _selectedHospital = null);
    } else {
      Navigator.pop(context);
    }
  }

  void _fitMapBounds(Map<String, dynamic> hospital) {
    if (_currentPosition == null) return;
    
    final userPt = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
    final hospPt = LatLng(hospital['lat'], hospital['lon']);
    
    final bounds = LatLngBounds.fromPoints([userPt, hospPt]);
    
    _mapController.fitCamera(
      CameraFit.bounds(
        bounds: bounds,
        padding: const EdgeInsets.all(50.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);

    return PopScope(
      canPop: _selectedHospital == null,
      onPopInvoked: (didPop) { if (!didPop) _handleBack(); },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, 
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black54), 
            onPressed: _handleBack
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor, 
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: primaryGreen, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(Theme.of(context).brightness == Brightness.dark ? 0.2 : 0.05), 
                    blurRadius: 10, offset: const Offset(0, 5)
                  )
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    decoration: BoxDecoration(color: primaryGreen, borderRadius: const BorderRadius.vertical(top: Radius.circular(18))),
                    child: Row(
                      children: [
                        const Icon(Icons.add_box, color: Colors.white, size: 28), const SizedBox(width: 15),
                        Text(lang.translate('find_hospital_sec', 'title'), style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Expanded(child: _buildBodyContent(lang)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBodyContent(LanguageProvider lang) {
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: Color(0xFF10B981)), const SizedBox(height: 15),
            Text(lang.translate('find_hospital_sec', 'loc_fetching'), style: const TextStyle(fontSize: 16)),
          ],
        ),
      );
    }

    final privacyProvider = Provider.of<PrivacyProvider>(context);

    if (!_isGpsEnabled || !_hasPermission || !privacyProvider.locationEnabled) {
      return Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on, size: 80, color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[800] : Colors.grey.shade300), const SizedBox(height: 20),
            Text(lang.translate('find_hospital_sec', 'loc_permission_title'), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), const SizedBox(height: 10),
            Text(lang.translate('find_hospital_sec', 'loc_permission_desc'), textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black54)), const SizedBox(height: 30),
            SizedBox(
              width: double.infinity, height: 55,
              child: ElevatedButton(
                onPressed: _requestPermissionAndEnableGps,
                style: ElevatedButton.styleFrom(backgroundColor: primaryGreen, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                child: Text(lang.translate('find_hospital_sec', 'loc_permission_btn'), style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            if (_errorMessage != null) ...[const SizedBox(height: 15), Text(_errorMessage!, style: const TextStyle(color: Colors.redAccent, fontSize: 13), textAlign: TextAlign.center)]
          ],
        ),
      );
    }

    if (_errorMessage != null && _hospitals.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off, size: 60, color: Colors.redAccent), const SizedBox(height: 15),
              Text(_errorMessage!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14)), const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _fetchLocationAndHospitals, 
                style: ElevatedButton.styleFrom(backgroundColor: primaryGreen), 
                child: Text(
                  lang.translate('find_hospital_sec', 'try_again'), 
                  style: const TextStyle(color: Colors.white)
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_selectedHospital != null) {
      return _buildDestinationView(lang);
    }
    return _buildSearchList(lang);
  }

  Widget _buildSearchList(LanguageProvider lang) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(lang.translate('find_hospital_sec', 'search'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(width: 5),
              const Icon(Icons.search, size: 22),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _searchController, onChanged: _filterSearch,
            decoration: InputDecoration(
              hintText: lang.translate('find_hospital_sec', 'search_hint'), 
              hintStyle: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white38 : Colors.black38), 
              filled: true, 
              fillColor: Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(0.05) : Colors.grey.shade50, 
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: primaryGreen, width: 2)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: primaryGreen, width: 2)),
            ),
          ),
          const SizedBox(height: 20),
          Text(lang.translate('find_hospital_sec', 'near_me'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), const SizedBox(height: 10),
          Expanded(
            child: _filteredHospitals.isEmpty
                ? Center(child: Text(lang.translate('find_hospital_sec', 'no_hosp'), style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white54 : Colors.black54)))
                : ListView.separated(
                    itemCount: _filteredHospitals.length, separatorBuilder: (context, index) => Divider(color: Theme.of(context).dividerColor, height: 25),
                    itemBuilder: (context, index) {
                      final hospital = _filteredHospitals[index];
                      return GestureDetector(
                        // 🌟 แก้ไขตรงนี้: สั่งให้กล้องจัดเฟรมใหม่ทุกครั้งที่กดเลือกจากลิสต์
                        onTap: () {
                          setState(() { 
                            FocusScope.of(context).unfocus(); 
                            _selectedHospital = hospital; 
                          });
                          Future.delayed(const Duration(milliseconds: 150), () {
                            if (mounted && _selectedHospital != null) {
                              _fitMapBounds(_selectedHospital!);
                            }
                          });
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.domain_add, color: primaryGreen, size: 30), const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(hospital['name'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: primaryGreen)), const SizedBox(height: 2),
                                  Text(hospital['name_en'], style: TextStyle(fontSize: 12, color: Theme.of(context).brightness == Brightness.dark ? Colors.white54 : Colors.black54)),
                                ],
                              ),
                            ),
                            Text("${hospital['distance'].toStringAsFixed(1)} ${lang.translate('find_hospital_sec', 'km')}", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black87))
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationView(LanguageProvider lang) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(lang.translate('find_hospital_sec', 'select_dest'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15), 
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(0.05) : Colors.grey.shade100, 
              borderRadius: BorderRadius.circular(12)
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Map<String, dynamic>>(
                isExpanded: true, 
                value: _selectedHospital, 
                icon: Icon(Icons.keyboard_arrow_down, color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black87),
                items: _hospitals.map((hosp) {
                  return DropdownMenuItem<Map<String, dynamic>>(value: hosp, child: Text(hosp['name'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis));
                }).toList(),
                onChanged: (newValue) {
                  setState(() => _selectedHospital = newValue);
                  if (newValue != null) {
                    Future.delayed(const Duration(milliseconds: 100), () => _fitMapBounds(newValue));
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[900] : Colors.grey.shade200, 
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: primaryGreen, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13), 
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCameraFit: CameraFit.bounds(
                      bounds: LatLngBounds.fromPoints([
                        LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                        LatLng(_selectedHospital!['lat'], _selectedHospital!['lon']),
                      ]),
                      padding: const EdgeInsets.all(50.0), 
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.stayalive.app', 
                    ),
                    MarkerLayer(
                      markers: [
                        if (_currentPosition != null)
                          Marker(
                            point: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                            width: 50, height: 50,
                            child: const Icon(Icons.person_pin_circle, color: Colors.blue, size: 45),
                          ),
                        Marker(
                          point: LatLng(_selectedHospital!['lat'], _selectedHospital!['lon']),
                          width: 50, height: 50,
                          child: const Icon(Icons.location_on, color: Colors.red, size: 45),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),

          GestureDetector(
            onTap: () => _openRealMap(_selectedHospital!['lat'], _selectedHospital!['lon']),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: primaryGreen, borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: primaryGreen.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.map, color: Colors.white), const SizedBox(width: 10),
                  Text(lang.translate('find_hospital_sec', 'open_map'), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}