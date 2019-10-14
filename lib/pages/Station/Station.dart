import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thepublictransport_app/backend/models/main/Location.dart';
import 'package:thepublictransport_app/backend/service/geocode/Geocode.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/pages/Station/StationInfo.dart';

import 'StationDeparture.dart';

class Station extends StatefulWidget {
  final Location location;

  Station(this.location);

  @override
  _StationState createState() => _StationState(location);
}

class _StationState extends State<Station> {
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(36.0),
    topRight: Radius.circular(36.0),
  );

  final Location location;

  var theme = ThemeEngine.getCurrentTheme();

  PageController _pageController = new PageController();
  int _selectedIndex = 0;

  _StationState(this.location);

  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: theme.backgroundColor,
      statusBarColor: Colors.transparent, // status bar color
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
        backgroundColor: Color(0xff339955),
        floatingActionButton: FloatingActionButton(
          heroTag: "HEROOOO2",
          onPressed: () {
            Navigator.of(context).pop();
          },
          backgroundColor: theme.floatingActionButtonColor,
          child: Icon(Icons.arrow_back, color: theme.floatingActionButtonIconColor),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            height: 75,
            color: theme.backgroundColor,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  iconSize: 30.0,
                  padding: EdgeInsets.only(left: 28.0),
                  icon: Icon(Icons.info, color: _selectedIndex == 0 ? Color(0xff339955) : Colors.grey),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                      _pageController.animateToPage(0,
                          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                    });
                  },
                ),
                IconButton(
                  iconSize: 30.0,
                  padding: EdgeInsets.only(right: 28.0),
                  icon: Icon(Icons.location_on, color: _selectedIndex == 1 ? Color(0xff339955) : Colors.grey),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 1;
                      _pageController.animateToPage(1,
                          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xff339955),
            ),
            height: MediaQuery.of(context).padding.top + MediaQuery.of(context).size.height * 0.34,
            child: Center(
              child: Text(
                "Station",
                style: TextStyle(
                    fontFamily: 'NunitoSansBold',
                    fontSize: 40,
                    color: Colors.white
                ),
              ),
            ),
          ),
          Flexible(
            child: ClipRRect(
              borderRadius: radius,
              child: Container(
                height: double.infinity,
                color: theme.backgroundColor,
                child: PageView(
                  onPageChanged: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  controller: _pageController,
                  children: <Widget>[
                    StationInfo(location: location),
                    StationDeparture(location.id)
                  ],
                ),
              ),
            ),
          ),
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
            "Verkehrsmittel",
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
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        ListTile(
          title: Text(
            "Demnächst",
            style: TextStyle(
                fontFamily: 'NunitoSansBold',
                color: theme.titleColor
            ),
          ),
        ),
      ],
    );
  }
}
