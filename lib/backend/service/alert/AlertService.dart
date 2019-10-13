import 'package:thepublictransport_app/backend/constants/TrainAPIConstants.dart';
import 'package:thepublictransport_app/backend/models/core/AlertModel.dart';
import 'package:thepublictransport_app/framework/http/SuperchargedHttp.dart';

class AlertService {
  static Future<AlertModel> getAlert() async {
    var result = await SuperchargedHTTP.request(
        URL:  TrainAPIConstants.API_URL + TrainAPIConstants.API_ENDPOINT_ALERT,
        timeout: 5000
    );

    return AlertModel.fromJson(result);
  }
}