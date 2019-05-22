import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/components/searchbar.dart';
import 'package:thepublictransport_app/ui/colors/colorconstants.dart';
import 'package:thepublictransport_app/ui/components/mapswidget.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:thepublictransport_app/ui/components/welcomecity.dart';
import 'package:desiredrive_api_flutter/service/geocode/geocode.dart';
import 'package:desiredrive_api_flutter/service/nominatim/nominatim_request.dart';
import 'package:thepublictransport_app/ui/animations/showup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thepublictransport_app/pages/searchinput.dart';
import 'package:desiredrive_api_flutter/models/rmv/rmv_query.dart';
import 'package:thepublictransport_app/ui/components/optionswitch.dart';

class SearchWidget extends StatefulWidget {
  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {

  SharedPreferences pref;
  RMVQueryModel from;
  RMVQueryModel to;
  String datestring;
  String timestring;


  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).padding.left,
            0,
            MediaQuery.of(context).padding.right,
            MediaQuery.of(context).padding.bottom
        ),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                new SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: new FutureBuilder<MapsWidget>(
                    future: MapsWidgetDelayed(),
                    builder: (BuildContext context, AsyncSnapshot<MapsWidget> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return new Container(
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.10),
                            child: new SizedBox(
                                width: 50,
                                height: 50,
                                child: new CircularProgressIndicator()
                            ),
                          );
                        case ConnectionState.done:
                          if (snapshot.hasError)
                            return new Text('Error: ${snapshot.error}');
                          return snapshot.data;
                      }
                      return null; // unreachable
                    },
                  )
                ),
                new Center(
                  child: new Container(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.20),
                    child: new SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.70,
                      child: NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overscroll) {
                          overscroll.disallowGlow();
                        },
                        child: new ListView(
                          children: <Widget>[
                            ShowUp(
                              delay: 0,
                              child: new SizedBox(
                                width: MediaQuery.of(context).size.width * 0.95,
                                height: 375,
                                child: new Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  color: Colors.white,
                                  child: new Container(
                                    padding: EdgeInsets.only(top: 10),
                                    child: new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new ShowUp(
                                          delay: 200,
                                          child: new Searchbar(
                                            text: decideSearchbarString("Start", 1),
                                            onTap: () {
                                              _navigateAndDisplaySelection(context, "Start", 1);
                                            },
                                          ),
                                        ),
                                        new ShowUp(
                                          delay: 200,
                                          child: new Searchbar(
                                            text: decideSearchbarString("Ziel", 2),
                                            onTap: () {
                                              _navigateAndDisplaySelection(context, "Ziel", 2);
                                            },
                                          ),
                                        ),
                                        new ShowUp(
                                          delay: 400,
                                          child: new Container(
                                            padding: EdgeInsets.only(top: 10),
                                            child: new Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                new Container(
                                                  padding: EdgeInsets.fromLTRB(20, 10, 9, 0),
                                                  child: new GradientButton(
                                                      increaseWidthBy: 30,
                                                      gradient: ColorConstants.tptfabgradient,
                                                      child: new Container(
                                                        padding: EdgeInsets.only(left: 10),
                                                        child: new Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            new Icon(
                                                              Icons.calendar_today,
                                                              size: 20
                                                            ),
                                                            new Container(
                                                              padding: EdgeInsets.only(left: 7),
                                                              child: new Text(
                                                                  decideDateString()
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      callback: () {
                                                        _selectDate();
                                                      }
                                                  ),
                                                ),
                                                new Container(
                                                  padding: EdgeInsets.fromLTRB(0, 10, 12, 0),
                                                  child: new GradientButton(
                                                      gradient: ColorConstants.tptfabgradient,
                                                      child: new Container(
                                                        padding: EdgeInsets.only(left: 10),
                                                        child: new Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            new Icon(Icons.access_time),
                                                            new Container(
                                                              padding: EdgeInsets.only(left: 7),
                                                              child: new Text(
                                                                  decideTimeString()
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      callback: () {
                                                        _selectTime();
                                                      }
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        new ShowUp(
                                          delay: 500,
                                          child: new Container(
                                            padding: EdgeInsets.fromLTRB(23, 20, 0, 0),
                                            child: new OutlineButton(
                                              highlightElevation: 0,
                                              borderSide: new BorderSide(style: BorderStyle.solid, width: 2, color: Colors.black),
                                              highlightedBorderColor: Colors.black,
                                              child: Text(
                                                  'Optionen',
                                                  style: new TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 17
                                                  )
                                              ),
                                              onPressed: () {
                                                showOptions();
                                              }
                                            ),
                                          ),
                                        ),
                                        new ShowUp(
                                          delay: 600,
                                          child: new Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: <Widget>[
                                              new Container(
                                                alignment: Alignment.bottomRight,
                                                padding: EdgeInsets.fromLTRB(0, 5, 27, 10),
                                                child: new CircularGradientButton(
                                                    gradient: ColorConstants.tptfabgradient,
                                                    child: new Icon(
                                                        Icons.search
                                                    ),
                                                    callback: (){

                                                    }
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            new FutureBuilder<ShowUp>(
                              future: welcomeCityRenderer(),
                              builder: (BuildContext context, AsyncSnapshot<ShowUp> snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.active:
                                  case ConnectionState.waiting:
                                  case ConnectionState.none:
                                    return new Container();
                                  case ConnectionState.done:
                                    if (snapshot.hasError)
                                      return new Text('Error: ${snapshot.error}');
                                    return snapshot.data;
                                }
                                return null; // unreachable
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]
            )
          ],
        ),
      ),
    );
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2019),
        lastDate: new DateTime(2020)
    );

    if(picked != null)
      setState(() {
        datestring = picked.day.toString().padLeft(2, '0') + "." + picked.month.toString().padLeft(2, '0') + "." + picked.year.toString();
      });
  }

  Future _selectTime() async {
    TimeOfDay selectedTime24Hour = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 10, minute: 47),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );

    if(selectedTime24Hour != null)
      setState(() {
        timestring = selectedTime24Hour.hour.toString().padLeft(2, '0') + ":" + selectedTime24Hour.minute.toString().padLeft(2, '0');
      });

  }

  String decideSearchbarString(String previous, int mode) {
    String result;
    try {
      switch (mode) {
        case 1:
          result = from.name;
          break;
        case 2:
          result = to.name;
      }
    } catch (e) {
      result = previous;
    }

    print(result);
    return result;
  }

  String decideDateString() {
    var now = DateTime.now();
    if (datestring != null)
      return datestring;
    else
      return now.day.toString().padLeft(2, '0') + "." + now.month.toString().padLeft(2, '0') + "." + now.year.toString();
  }

  String decideTimeString() {
    var now = TimeOfDay.now();
    if (timestring != null)
      return timestring;
    else
      return now.hour.toString().padLeft(2, '0') + ":" + now.minute.toString().padLeft(2, '0');
  }

  _navigateAndDisplaySelection(BuildContext context, String title, int mode) async {
    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the Selection Screen!
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchInput(title: title, mode: mode)),
    );

    if (result != null) {
      setState(() {
        switch (mode) {
          case 1:
            from = result;
            break;
          case 2:
            to = result;
        }
      });
    }
  }

  Future<ShowUp> welcomeCityRenderer() async {
    var nominatim = new NominatimRequest();
    var geocode = new DesireDriveGeocode();

    return nominatim.getPlace(await geocode.latitude(), await geocode.longitude()).then((nominatim) {
      return ShowUp(
        child: new WelcomeCity(
          city: nominatim.city,
        ),
        delay: 300,
      );
    });
  }

  Future<MapsWidget> MapsWidgetDelayed() {
    return Future.delayed(const Duration(milliseconds: 2000), () {
      return MapsWidget();
    });
  }

  showOptions() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          final ThemeData themeData = Theme.of(context);
          return Theme(
            data: themeData.copyWith(canvasColor: Colors.white),
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.transparent),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22.0),
                    topRight: Radius.circular(22.0)),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new OptionSwitch(
                        title: "Nur Nahverkehr",
                        icon: Icons.directions_bus,
                        id: "just_busses"
                    ),
                    new OptionSwitch(
                        title: "Zuverlässigere Erreichbarkeit",
                        icon: Icons.access_time,
                        id: "good_trips"
                    ),
                    new OptionSwitch(
                        title: "Nur Direktverbindungen",
                        icon: Icons.fast_forward,
                        id: "direct_trips"
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}