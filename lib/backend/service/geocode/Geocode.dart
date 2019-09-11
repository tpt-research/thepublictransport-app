import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:thepublictransport_app/backend/models/geolocation/Geolocation.dart';

class Geocode {
  static Future<Geolocation> location() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high, locationPermissionLevel: GeolocationPermission.location);
    return Geolocation.fromPosition(position);
  }
}