import 'dart:convert';

import 'package:thepublictransport_app/backend/constants/ptetptconstants.dart';
import 'package:thepublictransport_app/backend/models/core/SparpreisFinderModel.dart';
import 'package:http/http.dart' as http;

class SparpreisService {

  static Future<SparpreisFinderModel> getSparpreise(
      String from,
      String to,
      String when) {

    return http.get(
        PTETPTConstants.API_URL + "/sparpreise/" + from + "/" + to + "/" + when

    ).then((res) {

      var decode = json.decode(res.body);

      return SparpreisFinderModel.fromJson(decode);

    });
  }


}