import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thepublictransport_app/backend/models/core/ICEPortalModel.dart';


class FluxFailService {
  static Future<IcePortalModel> getDelayStream(
      String limit,
      String offset) {
    return http.get(
        "https://iceportal.de/api1/rs/tripInfo/trip"
    ).then((res) {

      var decode = json.decode(res.body);

      return IcePortalModel.fromJson(decode);

    });
  }
}