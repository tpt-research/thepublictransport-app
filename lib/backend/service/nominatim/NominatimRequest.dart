import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thepublictransport_app/backend/constants/osmconstants.dart';
import 'package:thepublictransport_app/backend/models/osm/Nominatim.dart';

class NominatimRequest {

  static Future<Nominatim> getPlace(double lat, double lon) {
    return http.get(OsmConstants.API_URL + '/reverse?format=json&lat=' + lat.toString() + '&lon=' + lon.toString() + '&addressdetails=1').then((res) {
      var decode = json.decode(res.body);

      return Nominatim.fromJson(decode);
    });
  }
}