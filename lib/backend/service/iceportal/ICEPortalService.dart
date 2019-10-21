import 'package:thepublictransport_app/backend/models/core/ICEPortalModel.dart';
import 'package:thepublictransport_app/framework/http/SuperchargedHttp.dart';


class ICEPortalService {
  static Future<IcePortalModel> getICEPortal() async {
    var result = await SuperchargedHTTP.request(
        URL:  'https://iceportal.de/api1/rs/tripInfo/trip',
        timeout: 5000
    );

    return IcePortalModel.fromJson(result);
  }
}