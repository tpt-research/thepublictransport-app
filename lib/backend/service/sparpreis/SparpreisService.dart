import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thepublictransport_app/backend/constants/SparpreisConstants.dart';
import 'package:thepublictransport_app/backend/models/core/SparpreisFinderModel.dart';
import 'package:thepublictransport_app/framework/http/SuperchargedHttp.dart';

class SparpreisService {

  static Future<SparpreisFinderModel> getSparpreise(
      String from,
      String to,
      String when) async {

    var result = await SuperchargedHTTP.request(
        URL:  SparpreisConstants.API_URL + SparpreisConstants.API_ENDPOINT_SPARPREIS + "/" + from + "/" + to + "/" + when,
        timeout: 5000
    );

    return SparpreisFinderModel.fromJson(result);
  }


}