import 'package:geolocator/geolocator.dart';
import 'package:thepublictransport_app/backend/models/osm/Nominatim.dart';
import 'package:thepublictransport_app/backend/service/nominatim/NominatimRequest.dart';

class Geolocation {
  final double latitude;
  final double longitude;
  final double accuracy;
  final double altitude;
  final double speed;

  Geolocation({
    this.latitude,
    this.longitude,
    this.accuracy,
    this.altitude,
    this.speed
  });


  factory Geolocation.fromPosition(Position position) => new Geolocation(
    latitude: position.latitude,
    longitude: position.longitude,
    accuracy: position.accuracy,
    altitude: position.altitude,
    speed: position.speed
  );

  Future<Nominatim> getNominatim() async {
    return await NominatimRequest.getPlace(latitude, longitude);
  }
}