import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:thepublictransport_app/backend/constants/TrainAPIConstants.dart';
import 'package:thepublictransport_app/backend/models/core/DepartureModel.dart';
import 'package:thepublictransport_app/backend/models/core/LocationModel.dart';
import 'package:thepublictransport_app/backend/models/core/TripModel.dart';
import 'package:thepublictransport_app/backend/service/geocode/Geocode.dart';
import 'package:thepublictransport_app/backend/service/nominatim/NominatimRequest.dart';

class CoreService {

  static Future<DepartureModel> getDeparture(
      String stationId,
      String source) {
    return http.get(
        TrainAPIConstants.API_URL +
            TrainAPIConstants.API_ENDPOINT_DEPARTURE +
            "?stationId=" + stationId +
            "&source=" + source +
            "&hourshift=" + "2" +
            "&equiv=" + "true"
    ).then((res) {

      var decode = json.decode(res.body);

      return DepartureModel.fromJson(decode);

    });
  }

  static Future<TripModel> getTripByName(
      String from,
      String to,
      String when,
      String accessibility,
      String optimization,
      String walkspeed,
      String source) {

    return http.get(
            TrainAPIConstants.API_URL +
            TrainAPIConstants.API_ENDPOINT_TRIP +
            TrainAPIConstants.API_ENDPOINT_TRIP_SEARCH_NAME +
                "?from=" + from +
                "&to=" + to +
                "&when=" + when +
                "&accessibility=" + accessibility +
                "&optimization=" + optimization +
                "&walkspeed=" + walkspeed +
                "&source=" + source
    ).then((res) {

      var decode = json.decode(res.body);

      return TripModel.fromJson(decode);

    });
  }

  static Future<TripModel> getTripById(
      String from,
      String to,
      String when,
      String accessibility,
      String optimization,
      String walkspeed,
      String source) {

    print(TrainAPIConstants.API_URL +
        TrainAPIConstants.API_ENDPOINT_TRIP +
        TrainAPIConstants.API_ENDPOINT_TRIP_SEARCH_ID +
        "?from=" + from +
        "&to=" + to +
        "&when=" + when +
        "&accessibility=" + accessibility +
        "&optimization=" + optimization +
        "&walkspeed=" + walkspeed +
        "&source=" + source);

    return http.get(
            TrainAPIConstants.API_URL +
            TrainAPIConstants.API_ENDPOINT_TRIP +
            TrainAPIConstants.API_ENDPOINT_TRIP_SEARCH_ID +
                "?from=" + from +
                "&to=" + to +
                "&when=" + when +
                "&accessibility=" + accessibility +
                "&optimization=" + optimization +
                "&walkspeed=" + walkspeed +
                "&source=" + source
    ).then((res) {

      var decode = json.decode(res.body);

      return TripModel.fromJson(decode);

    });
  }

  static Future<LocationModel> getLocationQuery(
      String query,
      String types,
      String maxLocations,
      String source) {

    return http.get(
        TrainAPIConstants.API_URL +
            TrainAPIConstants.API_ENDPOINT_LOCATION +
            TrainAPIConstants.API_ENDPOINT_LOCATION_SUGGEST +
            "?q=" + query +
            "&maxLocations=" + maxLocations +
            "&maxDistance=" + "10000" +
            "&source=" + source
    ).then((res) {

      var decode = json.decode(res.body);

      return LocationModel.fromJson(decode);

    });
  }

  static Future<LocationModel> getLocationNearby(
      String maxLocations,
      String source) async {

    var coordinates = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);


    return http.get(
            TrainAPIConstants.API_URL +
            TrainAPIConstants.API_ENDPOINT_LOCATION +
            TrainAPIConstants.API_ENDPOINT_LOCATION_NEARBY +
            "?lat=" + coordinates.latitude.toString() +
            "&lon=" + coordinates.longitude.toString() +
            "&types=" + "STATION"+
            "&maxLocations=" + maxLocations +
            "&source=" + source
    ).then((res) {

      var decode = json.decode(res.body);

      return LocationModel.fromJson(decode);

    });
  }

  static Future<LocationModel> getLocationNearbyAlternative(
      String maxLocations,
      String source) async {

    var coordinates = await Geocode.location();
    var nominatim = await NominatimRequest.getPlace(coordinates.latitude, coordinates.longitude);


    return http.get(
        TrainAPIConstants.API_URL +
            TrainAPIConstants.API_ENDPOINT_LOCATION +
            TrainAPIConstants.API_ENDPOINT_LOCATION_SUGGEST +
            "?q=" + nominatim.address.road + "," + nominatim.address.city +
            "&types=" + "STATION"+
            "&maxLocations=" + maxLocations +
            "&source=" + source
    ).then((res) {

      var decode = json.decode(res.body);

      return LocationModel.fromJson(decode);

    });
  }
}