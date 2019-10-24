import 'package:thepublictransport_app/backend/models/nextbike/NextbikeModel.dart';
import 'package:thepublictransport_app/framework/http/SuperchargedHttp.dart';

class NextbikeService {
  static Future<NextbikeModel> getNextbike() async {
    var result = await SuperchargedHTTP.request(
        URL:  'https://gbfs.nextbike.net/maps/gbfs/v1/nextbike_de/de/free_bike_status.json',
        timeout: 5000
    );

    return NextbikeModel.fromJson(result);
  }
}