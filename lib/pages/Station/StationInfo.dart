import 'dart:math';

import 'package:flutter/material.dart';
import 'package:thepublictransport_app/backend/models/main/Location.dart';
import 'package:thepublictransport_app/backend/service/geocode/Geocode.dart';
import 'package:thepublictransport_app/framework/language/GlobalTranslations.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/ui/components/Maps/MapsShow.dart';

class StationInfo extends StatefulWidget {
  final Location location;

  const StationInfo({Key key, this.location}) : super(key: key);

  @override
  _StationInfoState createState() => _StationInfoState(this.location);
}

class _StationInfoState extends State<StationInfo> {
  final Location location;

  var theme = ThemeEngine.getCurrentTheme();

  _StationInfoState(this.location);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          ListTile(
            title: Text(
              allTranslations.text('STATION.STOP'),
              style: TextStyle(
                  fontFamily: 'NunitoSansBold',
                  color: theme.titleColor
              ),
            ),
            subtitle: Text(
              location.name,
              style: TextStyle(
                  color: theme.subtitleColor
              ),
            ),
          ),
          ListTile(
            title: Text(
              allTranslations.text('STATION.VEHICLES'),
              style: TextStyle(
                  fontFamily: 'NunitoSansBold',
                  color: theme.titleColor
              ),
            ),
            subtitle: Text(
              joinArray(location.products),
              style: TextStyle(
                  color: theme.subtitleColor
              ),
            ),
          ),
          ListTile(
            title: Text(
              allTranslations.text('STATION.COORDINATES'),
              style: TextStyle(
                  fontFamily: 'NunitoSansBold',
                  color: theme.titleColor
              ),
            ),
            subtitle: Text(
              location.latAsDouble.toString() + ", " + location.lonAsDouble.toString(),
              style: TextStyle(
                  color: theme.subtitleColor
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: theme.titleColor),
            ),
            height: MediaQuery.of(context).size.height * 0.34,
            child: MapsShow(
                location: location
            ),
          )
        ],
      ),
    );
  }

  Future<String> calculateDistance() async {
    var coordinates = await Geocode.location();

    double lat1 = coordinates.latitude;
    double lon1 = coordinates.longitude;

    double lat2 = location.latAsDouble;
    double lon2 = location.lonAsDouble;

    var EarthRadius = 6378137.0; // WGS84 major axis
    double distance = 2 * EarthRadius * asin(
        sqrt(
            pow(sin(lat2 - lat1) / 2, 2)
                + cos(lat1)
                * cos(lat2)
                * pow(sin(lon2 - lon1) / 2, 2)
        )
    );

    distance /= 100;

    return distance.round().toString() + "m";
  }

  String joinArray(List<String> products) {
    var result = "";

    for (var i in products) {
      if (i == products.last)
        result += getString(i);
      else
        result += getString(i) + ", ";
    }

    return result;
  }

  String getString(String vehicle) {
    switch (vehicle) {
      case "HIGH_SPEED_TRAIN":
        return "ICE/IC/EC";
      case "REGIONAL_TRAIN":
        return "Regionalbahn";
      case "SUBURBAN_TRAIN":
        return "S-Bahn";
      case "BUS":
        return "Bus";
      case "TRAM":
        return "Straßenbahn";
      default:
        return "Andere";
    }
  }
}
