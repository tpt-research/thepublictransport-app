import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:sprung/next.dart';
import 'package:thepublictransport_app/backend/database/TripDatabaseHelper.dart';
import 'package:thepublictransport_app/backend/models/main/From.dart';
import 'package:thepublictransport_app/backend/models/main/Leg.dart';
import 'package:thepublictransport_app/backend/models/main/Stop.dart';
import 'package:thepublictransport_app/backend/models/main/Trip.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/framework/time/UnixTimeParser.dart';
import 'package:thepublictransport_app/pages/Alternative/Alternative.dart';
import 'package:thepublictransport_app/pages/Alternative/AlternativeTrip.dart';
import 'package:thepublictransport_app/pages/Station/Station.dart';
import 'package:thepublictransport_app/ui/animations/Marquee.dart';
import 'package:toast/toast.dart';

class SavedTripsDetailed extends StatefulWidget {

  final Trip trip;

  const SavedTripsDetailed({Key key, this.trip}) : super(key: key);

  @override
  _SavedTripsDetailedState createState() => _SavedTripsDetailedState(trip);
}

class _SavedTripsDetailedState extends State<SavedTripsDetailed> {

  final Trip trip;

  _SavedTripsDetailedState(this.trip);

  DateTime begin;
  DateTime end;

  var theme = ThemeEngine.getCurrentTheme();

  TripDatabaseHelper _databaseHelper = new TripDatabaseHelper();

  @override
  void initState() {
    begin = UnixTimeParser.parse(trip.firstDepartureTime);
    end = UnixTimeParser.parse(trip.lastArrivalTime);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: theme.titleColor,
        overlayColor: theme.backgroundColor,
        curve: Sprung.overDamped(),
        heroTag: "HEROOOO2",
        animatedIconTheme: IconThemeData(size: 22.0, color: theme.titleColorInverted),
          children: [
            SpeedDialChild(
                child: Icon(Icons.arrow_back),
                backgroundColor: Colors.red,
                label: 'Zurück',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () => Navigator.of(context).pop()
            ),
            SpeedDialChild(
              child: Icon(Icons.monetization_on),
              backgroundColor: Colors.blue,
              label: 'Günstige Alternative finden',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AlternativeTrip(trip: trip))),
            ),
            SpeedDialChild(
              child: Icon(Icons.close),
              backgroundColor: Colors.green,
              label: 'Entfernen',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () async {
                await _databaseHelper.delete(trip).then((res) {
                  Toast.show("Entfernen abgeschlossen", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                  Navigator.of(context).pop();
                }).catchError((err) {
                  Toast.show("Entfernen fehlgeschlagen", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                });
              },
            ),
          ]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                                fontFamily: 'NunitoSansBold',
                                color: theme.textColor
                            ),
                          ),
                          Text(
                            end.hour.toString() + ":" + end.minute.toString().padLeft(2, '0'),
                            style: TextStyle(
                                fontFamily: 'NunitoSansBold',
                                color: theme.textColor
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
                    fontFamily: 'NunitoSansBold',
                    color: theme.textColor
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
          color: theme.cardColor,
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
                                    fontFamily: 'NunitoSansBold',
                                    color: theme.textColor
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
                            fontFamily: 'NunitoSansBold',
                            color: theme.textColor
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
                        Icon(getIcon(leg.line.product), color: theme.iconColor),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(leg.line.name, style: TextStyle(color: theme.textColor)),
                            Text(leg.destination.name, style: TextStyle(color: theme.textColor))
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                                leg.message == null ? Icons.check : Icons.warning,
                                color: leg.message == null ? Colors.grey : Colors.red,
                            ),
                            onPressed: leg.message == null ? null : () {
                              _showMessage(leg.message);
                            }
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.more,
                              color: theme.iconColor,
                            ),
                            onPressed: () {
                              _showIntermediateStops(leg.intermediateStops);
                            }
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.monetization_on,
                              color: theme.iconColor,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Alternative(leg: leg)));
                            }
                        ),
                      ],
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
                                    fontFamily: 'NunitoSansBold',
                                    color: theme.textColor
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
                            fontFamily: 'NunitoSansBold',
                            color: theme.textColor
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
          fontFamily: 'NunitoSansBold',
          color: theme.textColor
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


    var begin = UnixTimeParser.parse(leg.arrivalTime + (leg.arrivalDelay != null ? leg.arrivalDelay : 0));
    var end = UnixTimeParser.parse(futureLeg.departureTime + (futureLeg.departureDelay != null ? futureLeg.departureDelay : 0));
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
              difference.inMinutes.toString() + " Minuten " + "Umstiegszeit",
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'NunitoSansBold',
                  color: theme.textColor
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
          backgroundColor: theme.backgroundColor,
          title: new Text("Meldungen", style: TextStyle(color: theme.textColor)),
          content: new Text(message != null ? message : "Keine Meldungen", style: TextStyle(color: theme.textColor)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Schließen", style: TextStyle(color: theme.textColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showIntermediateStops(List<Stop> stops) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: theme.backgroundColor,
          title: new Text("Zwischenhalte", style: TextStyle(color: theme.textColor)),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.90,
            width: MediaQuery.of(context).size.width * 0.90,
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: stops.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Icon(Icons.location_on, color: theme.iconColor),
                    title: Text(
                      stops[index].location.name,
                      style: TextStyle(
                        color: theme.titleColor
                      ),
                    ),
                    trailing: SizedBox(
                      height: 50,
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          getIntermediateDelay(stops[index].departureTime, stops[index].departureDelay),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Station(From.toLocation(stops[index].location))));
                    },
                  );
                },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Schließen", style: TextStyle(color: theme.textColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  getIntermediateDelay(int currentTime, int currentDelay) {
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
          time.hour.toString().padLeft(2, '0') + ":" + time.minute.toString().padLeft(2, '0') + "  ",
          style: TextStyle(
              fontSize: 15,
              fontFamily: 'NunitoSansBold',
              color: Colors.green
          ),
        ),
      ],
    );
  }
}
