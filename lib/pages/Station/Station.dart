import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thepublictransport_app/backend/models/main/Location.dart';
import 'package:thepublictransport_app/framework/language/GlobalTranslations.dart';
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
                allTranslations.text('STATION.TITLE'),
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
}
