import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thepublictransport_app/backend/constants/SparpreisConstants.dart';
import 'package:thepublictransport_app/backend/models/core/SparpreisFinderModel.dart';

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