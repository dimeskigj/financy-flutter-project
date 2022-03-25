import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class LocationService {
  LocationService._internal();

  static Location location = Location();
  static late bool _serviceEnabled;
  static late PermissionStatus _permissionGranted;
  static const String _url = 'https://geocode.maps.co/reverse';

  static final LocationService _instance = LocationService._internal();

  factory() {
    return _instance;
  }

  static Future<LatLng> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return LatLng(0, 0);
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return LatLng(0, 0);
      }
    }

    LocationData l = await location.getLocation();
    return LatLng(l.latitude ?? 0, l.longitude ?? 0);
  }

  static Future<String> reverseGeocode(LatLng latLng) async {
    final requestUrl = '$_url?lat=${latLng.latitude}&lon=${latLng.longitude}';

    var response = await http.get(Uri.parse(requestUrl));
    var json = convert.jsonDecode(response.body);
    return json['display_name'];
  }
}
