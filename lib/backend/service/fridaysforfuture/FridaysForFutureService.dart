import 'package:thepublictransport_app/backend/models/fridaysforfuture/FridaysForFutureModel.dart';
import 'package:thepublictransport_app/framework/http/SuperchargedHttp.dart';

class FridaysForFutureService {
  static Future<FridaysForFutureModel> getFFF() async {
    var result = await SuperchargedHTTP.request(
        URL: 'https://api.thepublictransport.de/fff/v1/get',
        timeout: 5000
    );

    return FridaysForFutureModel.fromJson(result);
  }

  static Future<FridaysForFutureModel> getFFFSearch(String parameter, String value) async {
    var result = await SuperchargedHTTP.request(
        URL:  'https://api.thepublictransport.de/fff/v1/search/' + parameter + "/" + value,
        timeout: 5000
    );

    return FridaysForFutureModel.fromJson(result);
  }
}