import 'package:thepublictransport_app/backend/models/voi/VoiModel.dart';
import 'package:thepublictransport_app/framework/http/SuperchargedHttp.dart';

class VoiService {
  static Future<List<VoiModel>> getVoiScooter(double lat, double lon) async {
    var result = await SuperchargedHTTP.request(
        URL:  'https://api.voiapp.io/v1/vehicle/status/ready?lat=' + lat.toString() + '&lng=' + lon.toString(),
        timeout: 5000
    );

    return List<VoiModel>.from(result.map((x) => VoiModel.fromJson(x)));
  }
}