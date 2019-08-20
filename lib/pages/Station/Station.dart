import 'dart:math';

import 'package:flutter/material.dart';
import 'package:thepublictransport_app/backend/models/main/Location.dart';
import 'package:thepublictransport_app/backend/service/geocode/Geocode.dart';
import 'package:thepublictransport_app/ui/components/Maps/MapsShow.dart';

import 'StationDeparture.dart';

class Station extends StatefulWidget {
  final Location location;

  Station(this.location);

  @override
  _StationState createState() => _StationState(location);
}

class _StationState extends State<Station> {
  final Location location;

  _StationState(this.location);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.35,
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    MapsShow(location: location),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.04,
                            MediaQuery.of(context).size.height * 0.04,
                            0,
                            0
                        ),
                        child: SizedBox(
                          height: 45,
                          width: 45,
                          child: FloatingActionButton(
                            elevation: 0,
                            backgroundColor: Colors.grey.withAlpha(90),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            heroTag: "HEROOOO",
                            child: Icon(Icons.arrow_back, color: Colors.white),
                          ),
                        )
                    )
                  ],
                )
            )
          ),
          showMainData(),
          Flexible(child: StationDeparture(location.id))
        ],
      )
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
    print(vehicle);
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

  Column showMainData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ListTile(
          title: Text(
            "Haltestelle",
            style: TextStyle(
                fontFamily: 'NunitoSansBold'
            ),
          ),
          subtitle: Text(location.name),
        ),
        ListTile(
          title: Text(
            "Verkehrsmittel",
            style: TextStyle(
                fontFamily: 'NunitoSansBold'
            ),
          ),
          subtitle: Text(joinArray(location.products)),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        ListTile(
          title: Text(
            "Demnächst",
            style: TextStyle(
                fontFamily: 'NunitoSansBold'
            ),
          ),
        ),
      ],
    );
  }
}
