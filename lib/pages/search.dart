import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/components/searchbar.dart';
import 'package:thepublictransport_app/ui/colors/colorconstants.dart';
import 'package:thepublictransport_app/ui/components/mapswidget.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:thepublictransport_app/ui/animations/showup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thepublictransport_app/pages/searchinput.dart';
import 'package:desiredrive_api_flutter/models/rmv/rmv_query.dart';
import 'package:thepublictransport_app/ui/components/optionswitch.dart';
import 'package:thepublictransport_app/pages/search_result.dart';
import 'package:desiredrive_api_flutter/service/geocode/geocode.dart';
import 'package:desiredrive_api_flutter/service/rmv/rmv_query_request.dart';


class SearchWidget extends StatefulWidget {
  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {

  SharedPreferences pref;
  RMVQueryModel from;
  RMVQueryModel to;
  String datestring;
  String datestring_rmv;
  String timestring;
  String timestring_rmv;

  GlobalKey<MapsWidgetState> _mapskey = new GlobalKey();


  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
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
                  child: new MapsWidget(key: _mapskey)
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
                                    side: ColorConstants.decideBorderSide()
                                  ),
                                  color: ColorConstants.cardColor,
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
                                            onButtonPressed: () async {
                                              DesireDriveGeocode geocode = new DesireDriveGeocode();
                                              from = await RMVQueryRequest.getMostRelevantAndNearestStation(await geocode.latitude(), await geocode.longitude());
                                              setState(() {

                                              });
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
                                            onButtonPressed: () async {
                                              DesireDriveGeocode geocode = new DesireDriveGeocode();
                                              to = await RMVQueryRequest.getMostRelevantAndNearestStation(await geocode.latitude(), await geocode.longitude());
                                              setState(() {

                                              });
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
                                              borderSide: new BorderSide(style: BorderStyle.solid, width: 2, color: ColorConstants.textColor),
                                              highlightedBorderColor: ColorConstants.textColor,
                                              child: Text(
                                                  'Optionen',
                                                  style: new TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 17,
                                                      color: ColorConstants.textColor
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
                                                    callback: () async {
                                                      super.reassemble();
                                                      SharedPreferences _prefs = await SharedPreferences.getInstance();
                                                      await Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) => SearchResultPage(
                                                                from: from,
                                                                to: to,
                                                                time: timestring_rmv,
                                                                date: datestring_rmv,
                                                                saveDrive: _prefs.getBool('good_trips_pref') ?? false
                                                              )
                                                          )
                                                      );
                                                      setState(() {

                                                      });
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
                            // Place for future widgets
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
        datestring_rmv = picked.year.toString() + "-" + picked.month.toString().padLeft(2, '0') + "-" + picked.day.toString().padLeft(2, '0');
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
        timestring_rmv = selectedTime24Hour.hour.toString().padLeft(2, '0') + ":" + selectedTime24Hour.minute.toString().padLeft(2, '0');
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
    if (datestring != null) {
      return datestring;
    } else {
      datestring_rmv = now.year.toString() + "-" + now.month.toString().padLeft(2, '0') + "-" + now.day.toString().padLeft(2, '0');
      return now.day.toString().padLeft(2, '0') + "." + now.month.toString().padLeft(2, '0') + "." + now.year.toString();
    }

  }

  String decideTimeString() {
    var now = TimeOfDay.now();
    if (timestring != null) {
      return timestring;
    } else {
      timestring_rmv = now.hour.toString().padLeft(2, '0') + ":" + now.minute.toString().padLeft(2, '0');
      return now.hour.toString().padLeft(2, '0') + ":" + now.minute.toString().padLeft(2, '0');
    }
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
            break;
          default:
            break;
        }
      });
    }
  }

  showOptions() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          final ThemeData themeData = Theme.of(context);
          return Theme(
            data: themeData.copyWith(canvasColor: ColorConstants.backgroundColor),
            child: DecoratedBox(
              decoration: BoxDecoration(color: ColorConstants.backgroundColor),
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