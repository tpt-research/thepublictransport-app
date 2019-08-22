import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thepublictransport_app/backend/models/core/FluxDelayStream.dart';

class FluxFailService {
  static Future<FluxDelayStream> getDelayStream(
      String limit,
      String offset) {
    return http.get(
        "https://flux.fail/api/flux/fail/stream/line?" +
            "limit=" + limit +
            "&offset=" + offset +
            "&user=false"
    ).then((res) {

      var decode = json.decode(res.body);

      return FluxDelayStream.fromJson(decode);

    });
  }
}