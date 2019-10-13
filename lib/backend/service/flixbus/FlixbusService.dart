import 'package:thepublictransport_app/backend/constants/FlixConstants.dart';
import 'package:thepublictransport_app/backend/models/core/DB2FlixModel.dart';
import 'package:thepublictransport_app/backend/models/core/FlixbusJourneyModel.dart';
import 'package:thepublictransport_app/backend/models/core/FlixbusQueryModel.dart';
import 'package:thepublictransport_app/framework/http/SuperchargedHttp.dart';

class FlixbusService {

  static Future<FlixbusJourneyModel> getJourney(
      String from,
      String fromType,
      String to,
      String toType,
      String when) async {

    var result = await SuperchargedHTTP.request(
        URL:  FlixConstants.API_URL +
              FlixConstants.API_ENDPOINT_FLIX +
              FlixConstants.API_ENDPOINT_JOURNEY +
              "/" + from +
              "/" + fromType +
              "/" + to +
              "/" + toType +
              "/" + when +
              "/de",
        timeout: 5000
    );

    print(FlixConstants.API_URL +
        FlixConstants.API_ENDPOINT_FLIX +
        FlixConstants.API_ENDPOINT_JOURNEY +
        "/" + from +
        "/" + fromType +
        "/" + to +
        "/" + toType +
        "/" + when +
        "/de");

    return FlixbusJourneyModel.fromJson(result);
  }

  static Future<FlixbusQueryModel> getQuery(String query, int limit) async {

    var result = await SuperchargedHTTP.request(
        URL:  FlixConstants.API_URL +
              FlixConstants.API_ENDPOINT_FLIX +
              FlixConstants.API_ENDPOINT_QUERY +
              "/" + query +
              "/" + limit.toString(),
        timeout: 5000
    );

    return FlixbusQueryModel.fromJson(result);
  }
  static Future<DB2FlixModel> getDBToFlix(String id) async {

    var result = await SuperchargedHTTP.request(
        URL:  FlixConstants.API_URL +
            FlixConstants.API_ENDPOINT_FLIX +
            FlixConstants.API_ENDPOINT_CONVERT +
            FlixConstants.API_ENDPOINT_DBTOFLIX +
            "/" + id,
        timeout: 5000
    );

    return DB2FlixModel.fromJson(result);
  }
}