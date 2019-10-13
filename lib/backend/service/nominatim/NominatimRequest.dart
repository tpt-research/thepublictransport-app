import 'dart:async';

import 'package:thepublictransport_app/backend/constants/OSMConstants.dart';
import 'package:thepublictransport_app/backend/models/osm/Nominatim.dart';
import 'package:thepublictransport_app/framework/http/SuperchargedHttp.dart';

class NominatimRequest {

  static Future<Nominatim> getPlace(double lat, double lon) async {

    var result = await SuperchargedHTTP.request(
        URL:  OSMConstants.API_URL +
            '/reverse?format=json&lat=' +
            lat.toString() +
            '&lon=' + lon.toString() +
            '&addressdetails=1',
        timeout: 5000
    );

    return Nominatim.fromJson(result);
  }
}