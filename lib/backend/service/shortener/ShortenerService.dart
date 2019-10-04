import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:thepublictransport_app/backend/constants/TrainAPIConstants.dart';

class ShortenerService {
  static Future<Uri> getLink(String link) async {
    final http.Client client = http.Client();
    final request = new Request('GET', Uri.parse(link))
      ..followRedirects = false;
    final response = await client.send(request);

    if (response.headers['location'] == null)
      return null;

    return Uri.parse(response.headers['location']);
  }

  static Future<String> createLink(String url) {
    return http.post(
        TrainAPIConstants.API_URL + TrainAPIConstants.API_ENDPOINT_SHORTENER,
        body: json.encode({'long_url': url})
    ).then((res) {

      var decode = json.decode(res.body);

      String id = decode['short_url'];
      id = id.replaceAll('localhost:80', '');

      return TrainAPIConstants.API_URL + TrainAPIConstants.API_ENDPOINT_TRIP_LINK + id;
    });
  }
}