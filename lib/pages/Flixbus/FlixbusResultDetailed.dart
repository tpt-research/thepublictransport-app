import 'package:flutter/material.dart';
import 'package:thepublictransport_app/backend/models/flixbus/Leg.dart';
import 'package:thepublictransport_app/backend/models/flixbus/Message.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/ui/animations/Marquee.dart';

class FlixbusResultDetailed extends StatefulWidget {

  final Message trip;

  const FlixbusResultDetailed({Key key, this.trip}) : super(key: key);

  @override
  _FlixbusResultDetailedState createState() => _FlixbusResultDetailedState(trip);
}

class _FlixbusResultDetailedState extends State<FlixbusResultDetailed> {
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(36.0),
    topRight: Radius.circular(36.0),
  );

  final Message trip;

  _FlixbusResultDetailedState(this.trip);

  DateTime begin;
  DateTime end;
  Duration diff;
  String diffString;

  var theme = ThemeEngine.getCurrentTheme();

  @override
  void initState() {
    begin = trip.legs.first.departure;
    end = trip.legs.last.arrival;
    diff = difference(begin, end);
    diffString ="${diff.inHours}:${diff.inMinutes.remainder(60)}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
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
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.lightGreen,
            ),
            height: MediaQuery.of(context).padding.top + MediaQuery.of(context).size.height * 0.34,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Flixbus",
                    style: TextStyle(
                        fontFamily: 'NunitoSansBold',
                        fontSize: 40,
                        color: Colors.white
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              trip.legs.first.origin.name,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                            Text(
                              trip.legs.last.destination.name,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              diffString,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                            Text(
                              begin.day.toString().padLeft(2, '0') + "." + begin.month.toString().padLeft(2, '0') + "." + begin.year.toString().padLeft(4, '0'),
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            child: ClipRRect(
              borderRadius: radius,
              child: Container(
                height: double.infinity,
                color: theme.backgroundColor,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: trip.legs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return createCard(trip.legs[index], index + 1 != trip.legs.length ? trip.legs[index + 1] :  null);
                    }
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


  Widget createCard(Leg leg, Leg futureLeg) {
    if (leg.legOperator == null) {
      var begin = leg.departure;
      var end = leg.arrival;
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
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0)
          ),
          color: theme.cardColor,
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        getTime(leg.departure),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.50,
                          child: Marquee(
                            direction: Axis.horizontal,
                            child: Text(
                              leg.origin.name,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.directions_bus, color: theme.iconColor),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Flixbus", style: TextStyle(color: theme.textColor)),
                            Text(leg.destination.name, style: TextStyle(color: theme.textColor))
                          ],
                        )
                      ],
                    ),
                    IconButton(
                        icon: Icon(
                            trip.info.message == null ? Icons.check : Icons.warning,
                            color: trip.info.message == null ? Colors.grey : Colors.red,
                        ),
                        onPressed: trip.info.message == null ? null : () {
                          _showMessage(trip.info.message);
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        getTime(leg.arrival),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.50,
                          child: Marquee(
                            direction: Axis.horizontal,
                            child: Text(
                              leg.destination.name,
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
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget getTime(DateTime time) {
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

  void _showMessage(String message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0)
          ),
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

  Duration difference(DateTime begin, DateTime end) {
    return end.difference(begin);
  }
}
