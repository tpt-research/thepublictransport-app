import 'dart:convert';

import 'package:thepublictransport_app/backend/constants/SparpreisConstants.dart';
import 'package:thepublictransport_app/backend/models/core/SparpreisFinderModel.dart';
import 'package:http/http.dart' as http;

class SparpreisService {

  static Future<SparpreisFinderModel> getSparpreise(
      String from,
      String to,
      String when) {

    return http.get(
        SparpreisConstants.API_URL + SparpreisConstants.API_ENDPOINT_SPARPREIS + "/" + from + "/" + to + "/" + when

    ).then((res) {

      var decode = json.decode(res.body);

      return SparpreisFinderModel.fromJson(decode);

    });
  }


}