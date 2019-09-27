import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thepublictransport_app/backend/models/core/AlertModel.dart';
import 'package:thepublictransport_app/backend/constants/TrainAPIConstants.dart';

class AlertService {
  static Future<AlertModel> getAlert() {
    return http.get(
        TrainAPIConstants.API_URL + TrainAPIConstants.API_ENDPOINT_ALERT
    ).then((res) {

      var decode = json.decode(res.body);

      return AlertModel.fromJson(decode);

    });
  }
}