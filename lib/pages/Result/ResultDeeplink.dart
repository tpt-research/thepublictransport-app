import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:thepublictransport_app/backend/models/core/TripModel.dart';
import 'package:thepublictransport_app/backend/models/main/Trip.dart';
import 'package:thepublictransport_app/backend/service/core/CoreService.dart';
import 'package:thepublictransport_app/backend/service/shortener/ShortenerService.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/framework/time/DateParser.dart';
import 'package:thepublictransport_app/framework/time/DurationParser.dart';
import 'package:thepublictransport_app/framework/time/UnixTimeParser.dart';
import 'package:thepublictransport_app/ui/animations/Marquee.dart';

import 'ResultDetailed.dart';

class ResultDeeplink extends StatefulWidget {

  final String fromName;
  final String toName;
  final String fromID;
  final String toID;
  final String time;
  final String date;
  final String barrier;
  final String slowwalk;
  final String fastroute;
  final String source;

  toBool(String bool) {
    if (bool == "true")
      return true;

    return false;
  }

  toDateTime(String date) {
    return DateTime.parse(date);
  }

  toTimeOfDay(String time) {
    return TimeOfDay(hour: int.parse(time.split(":")[0]), minute: int.parse(time.split(":")[1]));
  }

  const ResultDeeplink({Key key, this.fromName, this.toName, this.fromID, this.toID, this.time, this.date, this.barrier, this.slowwalk, this.fastroute, this.source}) : super(key: key);


  @override
  _ResultDeeplinkState createState() => _ResultDeeplinkState(this.fromName, this.toName, this.fromID, this.toID, toTimeOfDay(time), toDateTime(date), toBool(barrier), toBool(slowwalk), toBool(fastroute), source);
}

class _ResultDeeplinkState extends State<ResultDeeplink> {

  final String fromName;
  final String toName;
  final String fromID;
  final String toID;
  final TimeOfDay time;
  final DateTime date;
  final bool barrier;
  final bool slowwalk;
  final bool fastroute;
  final String source;

  _ResultDeeplinkState(this.fromName, this.toName, this.fromID, this.toID, this.time, this.date, this.barrier, this.slowwalk, this.fastroute, this.source);

  var theme = ThemeEngine.getCurrentTheme();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
              heroTag: "HEROOOO2",
              onPressed: () {
                Navigator.of(context).pop();
              },
              backgroundColor: theme.floatingActionButtonColor,
              child: Icon(Icons.arrow_back, color: theme.floatingActionButtonIconColor),
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: "NOHERO",
            onPressed: () async {
              var prepared = 'https://thepublictransport.de/share?fromName='
                  + fromName +
                  '&fromID=' + fromID +
                  '&toName=' + toName +
                  '&toID=' + toID +
                  '&date=' + date.toString() +
                  '&time=' + time.hour.toString() + ":" + time.minute.toString().padLeft(2, '0') +
                  '&barrier=' + barrier.toString() +
                  '&slowwalk=' + slowwalk.toString() +
                  '&fastroute=' + fastroute.toString();

              var shortened = await ShortenerService.createLink(Uri.encodeFull(prepared).toString());

              Share.share(shortened);
            },
            backgroundColor: theme.floatingActionButtonColor,
            child: Icon(Icons.share, color: theme.floatingActionButtonIconColor),
          ),
        ],
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20),
                  Text(
                    "Suche",
                    style: TextStyle(
                        color: theme.titleColor,
                        fontSize: 30,
                        fontFamily: 'NunitoSansBold'
                    ),
                  ),
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
                              Text("Nach:", style: TextStyle(color: theme.textColor))
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
                                    fromName,
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
                                    toName,
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
                            time.hour.toString() + ":" + time.minute.toString().padLeft(2, '0'),
                            style: TextStyle(
                                color: theme.textColor
                            ),
                          ),
                          Text(
                              date.day.toString().padLeft(2, '0') + "." + date.month.toString().padLeft(2, '0') + "." + date.year.toString().padLeft(4, '0'),
                            style: TextStyle(
                                color: theme.textColor
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: FutureBuilder(
                future: getTrips(),
                builder: (BuildContext context, AsyncSnapshot<TripModel> snapshot) {
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
                        if (snapshot.data.trips == null) {
                          return Center(
                            child: Text("Diese Suche ergab leider keinen Treffer", style: TextStyle(color: theme.subtitleColor)),
                          );
                        }
                        return ListView.builder(
                            itemCount: snapshot.data.trips.length,
                            itemBuilder: (BuildContext context, int index) {
                              return createCard(snapshot.data.trips[index]);
                            }
                        );
                      }
                  }
                  return null;
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
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResultDetailed(trip: trip)));
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.15,
          padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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

  Future<TripModel> getTrips() async {
    String barrier_mode = barrier == true ? "BARRIER_FREE" : "NEUTRAL";
    String slowwalk_mode = slowwalk == true ? "SLOW" : "NORMAL";
    String fastroute_mode = fastroute == true ? "LEAST_DURATION" : "LEAST_CHANGES";

    return CoreService.getTripById(
        fromID,
        toID,
        DateParser.getTPTDate(date, time),
        barrier_mode,
        fastroute_mode,
        slowwalk_mode,
        source
    );
  }
}
