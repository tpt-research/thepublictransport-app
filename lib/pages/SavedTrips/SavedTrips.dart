import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:thepublictransport_app/backend/database/TripDatabaseHelper.dart';
import 'package:thepublictransport_app/backend/models/main/Trip.dart';
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

  _SavedTripsState();

  var theme = ThemeEngine.getCurrentTheme();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      floatingActionButton: FloatingActionButton(
          heroTag: "HEROOOO2",
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
            height: MediaQuery.of(context).size.height * 0.20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Gespeicherte Fahrten",
                      style: TextStyle(
                          color: theme.titleColor,
                          fontSize: 30,
                          fontFamily: 'NunitoSansBold'
                      ),
                    ),
                  ),
                ],
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
                      return Center(
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
                      );
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Text(snapshot.error);
                      } else {
                        if (snapshot.data == null) {
                          return Center(
                            child: Text("Keine Trips gespeichert", style: TextStyle(color: theme.subtitleColor)),
                          );
                        }
                        if (snapshot.data.length == 0) {
                          return Center(
                            child: Text("Keine Trips gespeichert", style: TextStyle(color: theme.subtitleColor)),
                          );
                        }
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return createCard(snapshot.data[index]);
                            }
                        );
                      }
                  }
                  return Center(
                    child: Text("Keine Trips gespeichert", style: TextStyle(color: theme.subtitleColor)),
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

    for (var i in trip.legs) {
      if (i.line == null)
        continue;

      travels.add(i.line.name.replaceAll(new RegExp("[^A-Za-z]+"), ""));
      counter++;
    }


    return Card(
      color: theme.cardColor,
      child: InkWell(
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(builder: (context) => SavedTripsDetailed(trip: trip)));
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
                          Text("Von:", style: TextStyle(color: theme.textColor)),
                          Text("Nach:", style: TextStyle(color: theme.textColor)),
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
