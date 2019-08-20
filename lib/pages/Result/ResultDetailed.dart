import 'package:flutter/material.dart';
import 'package:thepublictransport_app/backend/models/main/From.dart';
import 'package:thepublictransport_app/backend/models/main/Leg.dart';
import 'package:thepublictransport_app/backend/models/main/Trip.dart';
import 'package:thepublictransport_app/framework/time/UnixTimeParser.dart';
import 'package:thepublictransport_app/pages/Station/Station.dart';
import 'package:thepublictransport_app/ui/animations/Marquee.dart';

class ResultDetailed extends StatefulWidget {

  final Trip trip;

  const ResultDetailed({Key key, this.trip}) : super(key: key);

  @override
  _ResultDetailedState createState() => _ResultDetailedState(trip);
}

class _ResultDetailedState extends State<ResultDetailed> {

  final Trip trip;

  _ResultDetailedState(this.trip);

  DateTime begin;
  DateTime end;

  @override
  void initState() {
    begin = UnixTimeParser.parse(trip.firstDepartureTime);
    end = UnixTimeParser.parse(trip.lastArrivalTime);
  }



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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
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
                                    trip.from.name + (trip.from.place != null ? ", " + trip.from.place : ""),
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
                                    trip.to.name + (trip.to.place != null ? ", " + trip.to.place : ""),
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
                            begin.hour.toString() + ":" + begin.minute.toString().padLeft(2, '0'),
                            style: TextStyle(
                                fontFamily: 'NunitoSansBold'
                            ),
                          ),
                          Text(
                            end.hour.toString() + ":" + end.minute.toString().padLeft(2, '0'),
                            style: TextStyle(
                                fontFamily: 'NunitoSansBold'
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: trip.legs.length,
                itemBuilder: (BuildContext context, int index) {
                  return createCard(trip.legs[index], index + 1 != trip.legs.length ? trip.legs[index + 1] :  null);
                }
            ),
          )
        ],
      ),
    );
  }


  Widget createCard(Leg leg, Leg futureLeg) {
    if (leg.line == null) {
      var begin = UnixTimeParser.parse(leg.departureTime);
      var end = UnixTimeParser.parse(leg.arrivalTime);
      var difference = end.difference(begin);

      return Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(23, 20, 23, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                difference.inMinutes.remainder(60).toString() + " Minuten " + "Umstiegszeit",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'NunitoSansBold'
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: <Widget>[
        Card(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Station(From.toLocation(leg.departure))));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          getDelay(leg.departureTime, leg.departureDelay),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.50,
                            child: Marquee(
                              direction: Axis.horizontal,
                              child: Text(
                                leg.departure.name,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'NunitoSansBold'
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        leg.departurePosition != null ? "Gl. " + leg.departurePosition.name : "",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'NunitoSansBold'
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  height: 2.0,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(getIcon(leg.line.product)),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(leg.line.name),
                            Text(leg.destination.name)
                          ],
                        )
                      ],
                    ),
                    IconButton(
                        icon: Icon(
                            leg.message == null ? Icons.check : Icons.warning,
                            color: leg.message == null ? Colors.grey : Colors.red,
                        ),
                        onPressed: leg.message == null ? null : () {
                          _showMessage(leg.message);
                        }
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  height: 2.0,
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Station(From.toLocation(leg.arrival))));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          getDelay(leg.arrivalTime, leg.arrivalDelay),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.50,
                            child: Marquee(
                              direction: Axis.horizontal,
                              child: Text(
                                leg.arrival.name,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'NunitoSansBold'
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        leg.arrivalPosition != null ? "Gl. " + leg.arrivalPosition.name : "",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'NunitoSansBold'
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        createTimeCard(leg, futureLeg)
      ],
    );
  }

  Widget getDelay(int currentTime, int currentDelay) {
    var time = UnixTimeParser.parse(currentTime);

    if (currentDelay != null) {
      var time_delay = UnixTimeParser.parse(currentTime + currentDelay);

      return Column(
        children: <Widget>[
          Text(
            time.hour.toString().padLeft(2, '0') + ":" + time.minute.toString().padLeft(2, '0') + "  ",
            style: TextStyle(
                fontSize: 15,
                fontFamily: 'NunitoSansBold'
            ),
          ),
          Text(
            time_delay.hour.toString().padLeft(2, '0') + ":" + time_delay.minute.toString().padLeft(2, '0') + "  ",
            style: TextStyle(
                fontSize: 15,
                fontFamily: 'NunitoSansBold',
                color: Colors.red
            ),
          ),
        ],
      );
    }

    return Text(
      time.hour.toString().padLeft(2, '0') + ":" + time.minute.toString().padLeft(2, '0') + "  ",
      style: TextStyle(
          fontSize: 15,
          fontFamily: 'NunitoSansBold'
      ),
    );
  }

  IconData getIcon(String vehicle) {
    print(vehicle);
    switch (vehicle) {
      case "HIGH_SPEED_TRAIN":
      case "REGIONAL_TRAIN":
      case "SUBURBAN_TRAIN":
        return Icons.train;
      case "BUS":
        return Icons.directions_bus;
      case "TRAM":
        return Icons.tram;
      default:
        return Icons.train;
    }
  }
  
  createTimeCard(Leg leg, Leg futureLeg) {

    if (futureLeg == null)
      return Container();


    var begin = UnixTimeParser.parse(leg.arrivalTime);
    var end = UnixTimeParser.parse(futureLeg.departureTime);
    var difference = end.difference(begin);
    
    if (futureLeg.line == null)
      return Container();

    return Center(
      child: Container(
        padding: EdgeInsets.fromLTRB(23, 20, 23, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              difference.inMinutes.remainder(60).toString() + " Minuten " + "Umstiegszeit",
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'NunitoSansBold'
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMessage(String message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Meldungen"),
          content: new Text(message != null ? message : "Keine Meldungen"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Schließen"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
