import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:thepublictransport_app/backend/models/core/TripModel.dart';
import 'package:thepublictransport_app/backend/models/main/SuggestedLocation.dart';
import 'package:thepublictransport_app/backend/models/main/Trip.dart';
import 'package:thepublictransport_app/backend/service/core/CoreService.dart';
import 'package:thepublictransport_app/framework/time/DurationParser.dart';
import 'package:thepublictransport_app/framework/time/UnixTimeParser.dart';
import 'package:thepublictransport_app/ui/animations/Marquee.dart';
import 'package:thepublictransport_app/ui/animations/ScaleUp.dart';

import 'ResultDetailed.dart';

class Result extends StatefulWidget {

  final SuggestedLocation from_search;
  final SuggestedLocation to_search;
  final TimeOfDay time;
  final DateTime date;
  final bool barrier;
  final bool slowwalk;
  final bool fastroute;

  const Result({Key key, this.from_search, this.to_search, this.time, this.date, this.barrier, this.slowwalk, this.fastroute}) : super(key: key);


  @override
  _ResultState createState() => _ResultState(from_search, to_search, time, date, barrier, slowwalk, fastroute);
}

class _ResultState extends State<Result> {

  final SuggestedLocation from_search;
  final SuggestedLocation to_search;
  final TimeOfDay time;
  final DateTime date;
  final bool barrier;
  final bool slowwalk;
  final bool fastroute;

  _ResultState(this.from_search, this.to_search, this.time, this.date, this.barrier, this.slowwalk, this.fastroute);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          heroTag: "HEROOOO2",
          onPressed: () {
            Navigator.of(context).pop();
          },
          backgroundColor: Colors.black,
          child: Icon(Icons.arrow_back, color: Colors.white),
      ),
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
                        color: Colors.black,
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
                              Text("Von:"),
                              Text("Nach:")
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
                                    from_search.location.name + (from_search.location.place != null ? ", " + from_search.location.place : ""),
                                    style: TextStyle(
                                      fontFamily: 'NunitoSansBold'
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: Marquee(
                                  direction: Axis.horizontal,
                                  child: Text(
                                    to_search.location.name + (to_search.location.place != null ? ", " + to_search.location.place : ""),
                                    style: TextStyle(
                                        fontFamily: 'NunitoSansBold'
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
                          ),
                          Text(
                              date.day.toString().padLeft(2, '0') + "." + date.month.toString().padLeft(2, '0') + "." + date.year.toString().padLeft(4, '0')
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
                      return ScaleUp(
                        duration: Duration(milliseconds: 500),
                        delay: 100,
                        child: Center(
                            child: SpinKitPulse(
                              size: 100,
                              color: Colors.black,
                            )
                        ),
                      );
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Text(snapshot.error);
                      } else {
                        if (snapshot.data.trips == null) {
                          return Center(
                            child: Text("Diese Suche ergab leider keinen Treffer", style: TextStyle(color: Colors.grey)),
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
    }


    return Card(
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
                        fontFamily: 'NunitoSansBold'
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    end.hour.toString().padLeft(2, '0') + ":" + end.minute.toString().padLeft(2, '0'),
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'NunitoSansBold'
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    difference,
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'NunitoSansBold'
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    counter.toString(),
                    style: TextStyle(
                      fontSize: 15,
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
                    fontFamily: 'NunitoSansBold'
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
        from_search.location.id,
        to_search.location.id,
        dateStringBuilder(),
        barrier_mode,
        fastroute_mode,
        slowwalk_mode,
        "DB"
    );
  }

  String dateStringBuilder() {
    return date.day.toString().padLeft(2, '0')
        + "." +
        date.month.toString().padLeft(2, '0')
        + "." +
        date.year.toString().padLeft(4, '0')
        + "T" +
        time.hour.toString().padLeft(2, '0')
        + ":" +
        time.minute.toString().padLeft(2, '0')
        + ":" + "00";
  }
}
