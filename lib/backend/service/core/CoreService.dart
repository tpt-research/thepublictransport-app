import 'dart:convert';

import 'package:thepublictransport_app/backend/constants/ptetptconstants.dart';
import 'package:thepublictransport_app/backend/models/core/DepartureModel.dart';
import 'package:http/http.dart' as http;
import 'package:thepublictransport_app/backend/models/core/LocationModel.dart';
import 'package:thepublictransport_app/backend/models/core/TripModel.dart';
import 'package:thepublictransport_app/backend/service/geocode/Geocode.dart';
import 'package:thepublictransport_app/backend/service/nominatim/NominatimRequest.dart';

class CoreService {

  static Future<DepartureModel> getDeparture(
      String stationId,
      String source) {
    return http.get(
        PTETPTConstants.API_URL +
            PTETPTConstants.API_ENDPOINT_DEPARTURE +
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
            PTETPTConstants.API_URL +
            PTETPTConstants.API_ENDPOINT_TRIP +
            PTETPTConstants.API_ENDPOINT_TRIP_SEARCH_NAME +
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

    print(PTETPTConstants.API_URL +
        PTETPTConstants.API_ENDPOINT_TRIP +
        PTETPTConstants.API_ENDPOINT_TRIP_SEARCH_ID +
        "?from=" + from +
        "&to=" + to +
        "&when=" + when +
        "&accessibility=" + accessibility +
        "&optimization=" + optimization +
        "&walkspeed=" + walkspeed +
        "&source=" + source);

    return http.get(
            PTETPTConstants.API_URL +
            PTETPTConstants.API_ENDPOINT_TRIP +
            PTETPTConstants.API_ENDPOINT_TRIP_SEARCH_ID +
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
        PTETPTConstants.API_URL +
            PTETPTConstants.API_ENDPOINT_LOCATION +
            PTETPTConstants.API_ENDPOINT_LOCATION_SUGGEST +
            "?q=" + query +
            "&maxLocations=" + maxLocations +
            "&source=" + source
    ).then((res) {

      var decode = json.decode(res.body);

      return LocationModel.fromJson(decode);

    });
  }

  static Future<LocationModel> getLocationNearby(
      String maxLocations,
      String source) async {

    var coordinates = await Geocode.location();
    var nominatim = await NominatimRequest.getPlace(coordinates.latitude, coordinates.longitude);


    return http.get(
        PTETPTConstants.API_URL +
            PTETPTConstants.API_ENDPOINT_LOCATION +
            PTETPTConstants.API_ENDPOINT_LOCATION_SUGGEST +
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