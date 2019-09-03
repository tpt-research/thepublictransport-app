import 'dart:convert';

import 'package:thepublictransport_app/backend/constants/FlixConstants.dart';
import 'package:thepublictransport_app/backend/models/core/FlixbusJourneyModel.dart';
import 'package:http/http.dart' as http;
import 'package:thepublictransport_app/backend/models/core/FlixbusQueryModel.dart';

class FlixbusService {

  static Future<FlixbusJourneyModel> getJourney(
      String from,
      String fromType,
      String to,
      String toType,
      String when) {

    return http.get(
        FlixConstants.API_URL + FlixConstants.API_ENDPOINT_FLIX + FlixConstants.API_ENDPOINT_JOURNEY + "/" + from + "/" + fromType + "/" + to + "/" + toType + "/" + when + "/de"
    ).then((res) {

      var decode = json.decode(res.body);

      return FlixbusJourneyModel.fromJson(decode);

    });
  }

  static Future<FlixbusQueryModel> getQuery(String query, int limit) {

    return http.get(
        FlixConstants.API_URL + FlixConstants.API_ENDPOINT_FLIX + FlixConstants.API_ENDPOINT_QUERY + "/" + query + "/" + limit.toString()
    ).then((res) {

      var decode = json.decode(res.body);

      return FlixbusQueryModel.fromJson(decode);

    });
  }
}