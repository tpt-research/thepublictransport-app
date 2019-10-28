import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morpheus/morpheus.dart';
import 'package:thepublictransport_app/backend/database/TripDatabaseHelper.dart';
import 'package:thepublictransport_app/backend/models/main/Trip.dart';
import 'package:thepublictransport_app/framework/language/GlobalTranslations.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/framework/time/DurationParser.dart';
import 'package:thepublictransport_app/framework/time/UnixTimeParser.dart';
import 'package:thepublictransport_app/pages/SavedTrips/SavedTripsDetailed.dart';
import 'package:thepublictransport_app/ui/animations/Marquee.dart';

class SavedTrips extends StatefulWidget {

  const SavedTrips({Key key}) : super(key: key);

  @override
  _SavedTripsState createState() => _SavedTripsState();
}

class _SavedTripsState extends State<SavedTrips> {
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(36.0),
    topRight: Radius.circular(36.0),
  );

  var theme = ThemeEngine.getCurrentTheme();

  @override
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
      backgroundColor: Color(0xfff64f59),
      floatingActionButton: FloatingActionButton(
          heroTag: "HEROOOO",
          onPressed: () {
            Navigator.of(context).pop();
          },
          backgroundColor: theme.floatingActionButtonColor,
          child: Icon(Icons.arrow_back, color: theme.floatingActionButtonIconColor),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xfff64f59),
            ),
            height: MediaQuery.of(context).padding.top + MediaQuery.of(context).size.height * 0.34,
            child: Center(
              child: Text(
                allTranslations.text('SAVED_TRIPS.TITLE'),
                style: TextStyle(
                    fontFamily: 'NunitoSansBold',
                    fontSize: 40,
                    color: Colors.white
                ),
              ),
            ),
          ),
          Flexible(
            child: FutureBuilder(
                future: getTrips(),
                builder: (BuildContext context, AsyncSnapshot<List<Trip>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                    return ClipRRect(
                      borderRadius: radius,
                      child: Container(
                        height: double.infinity,
                        color: theme.backgroundColor,
                        child: Center(
                          child: SizedBox(
                            width: 500,
                            height: 500,
                            child: FlareActor(
                              'anim/cloud_loading.flr',
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                              animation: 'Sync',
                            ),
                          ),
                        ),
                      ),
                    );
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return ClipRRect(
                          borderRadius: radius,
                          child: Container(
                              color: theme.backgroundColor,
                              height: double.infinity,
                              child: Center(
                                  child: Text(
                                      snapshot.error,
                                      style: TextStyle(
                                          color: theme.subtitleColor
                                      )
                                )
                              )
                          ),
                        );
                      } else {
                        if (snapshot.data == null) {
                          return ClipRRect(
                            borderRadius: radius,
                            child: Container(
                              height: double.infinity,
                              color: theme.backgroundColor,
                              child: Center(
                                child: Text(allTranslations.text('SAVED_TRIPS.NO_TRIPS'), style: TextStyle(color: theme.subtitleColor)),
                              ),
                            ),
                          );
                        }
                        if (snapshot.data.length == 0) {
                          return ClipRRect(
                            borderRadius: radius,
                            child: Container(
                              height: double.infinity,
                              color: theme.backgroundColor,
                              child: Center(
                                child: Text(allTranslations.text('SAVED_TRIPS.NO_TRIPS'), style: TextStyle(color: theme.subtitleColor)),
                              ),
                            ),
                          );
                        }
                        return ClipRRect(
                          borderRadius: radius,
                          child: Container(
                            height: double.infinity,
                            color: theme.backgroundColor,
                            child: ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return createCard(snapshot.data[index]);
                                }
                            ),
                          ),
                        );
                      }
                  }
                  return ClipRRect(
                    borderRadius: radius,
                    child: Container(
                      height: double.infinity,
                      color: theme.backgroundColor,
                      child: Center(
                        child: Text(allTranslations.text('SAVED_TRIPS.NO_TRIPS'), style: TextStyle(color: theme.subtitleColor)),
                      ),
                    ),
                  );
                }
            ),
          )
        ],
      ),
    );
  }

  Widget createCard(Trip trip) {
    var begin = UnixTimeParser.parse(trip.firstDepartureTime);
    var end = UnixTimeParser.parse(trip.lastArrivalTime);
    var difference = DurationParser.parse(end.difference(begin));
    var travels = [];
    var counter = 0;
    final _parentKey = GlobalKey();

    for (var i in trip.legs) {
      if (i.line == null)
        continue;

      travels.add(i.line.name.replaceAll(new RegExp("[^A-Za-z]+"), ""));
      counter++;
    }


    return Card(
      key: _parentKey,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0)
      ),
      color: theme.cardColor,
      child: InkWell(
        onTap: () async {
          await Navigator.of(context).push(MorpheusPageRoute(parentKey: _parentKey, builder: (context) => SavedTripsDetailed(trip: trip)));
          setState(() {

          });
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(allTranslations.text('SAVED_TRIPS.FROM'), style: TextStyle(color: theme.textColor)),
                          Text(allTranslations.text('SAVED_TRIPS.TO'), style: TextStyle(color: theme.textColor)),
                        ],
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.50,
                            child: Marquee(
                              direction: Axis.horizontal,
                              child: Text(
                                trip.from.name + (trip.from.place != null ? ", " + trip.from.place : ""),
                                style: TextStyle(
                                    fontFamily: 'NunitoSansBold',
                                    color: theme.textColor
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.50,
                            child: Marquee(
                              direction: Axis.horizontal,
                              child: Text(
                                trip.to.name + (trip.to.place != null ? ", " + trip.to.place : ""),
                                style: TextStyle(
                                    fontFamily: 'NunitoSansBold',
                                    color: theme.textColor
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        begin.hour.toString() + ":" + begin.minute.toString().padLeft(2, '0'),
                        style: TextStyle(
                            color: theme.textColor
                        ),
                      ),
                      Text(
                        begin.day.toString().padLeft(2, '0') + "." + begin.month.toString().padLeft(2, '0') + "." + begin.year.toString().padLeft(4, '0'),
                        style: TextStyle(
                            color: theme.textColor
                        ),
                      )
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    begin.hour.toString().padLeft(2, '0') + ":" + begin.minute.toString().padLeft(2, '0'),
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'NunitoSansBold',
                        color: theme.textColor
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    end.hour.toString().padLeft(2, '0') + ":" + end.minute.toString().padLeft(2, '0'),
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'NunitoSansBold',
                        color: theme.textColor
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    difference,
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'NunitoSansBold',
                        color: theme.textColor
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    counter.toString(),
                    style: TextStyle(
                      fontSize: 15,
                        color: theme.textColor
                    ),
                  ),
                ],
              ),
              Divider(
                height: 2.0,
              ),
              Text(
                travels.join(" - "),
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'NunitoSansBold',
                    color: theme.textColor
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Trip>> getTrips() async {
    TripDatabaseHelper _helper = new TripDatabaseHelper();

    return _helper.get();
  }
}
