import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:thepublictransport_app/backend/models/core/FlixbusJourneyModel.dart';
import 'package:thepublictransport_app/backend/models/flixbus/QueryResult.dart';
import 'package:thepublictransport_app/backend/models/flixbus/Message.dart';
import 'package:thepublictransport_app/backend/service/flixbus/FlixbusService.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/framework/time/DateParser.dart';
import 'package:thepublictransport_app/framework/time/DurationParser.dart';
import 'package:thepublictransport_app/ui/animations/Marquee.dart';
import 'package:thepublictransport_app/ui/animations/ScaleUp.dart';

import 'FlixbusResultDetailed.dart';

class FlixbusResult extends StatefulWidget {

  final QueryResult from_search;
  final QueryResult to_search;
  final TimeOfDay time;
  final DateTime date;

  const FlixbusResult({Key key, this.from_search, this.to_search, this.time, this.date}) : super(key: key);


  @override
  _FlixbusResultState createState() => _FlixbusResultState(from_search, to_search, time, date);
}

class _FlixbusResultState extends State<FlixbusResult> {

  final QueryResult from_search;
  final QueryResult to_search;
  final TimeOfDay time;
  final DateTime date;

  _FlixbusResultState(this.from_search, this.to_search, this.time, this.date);

  var theme = ThemeEngine.getCurrentTheme();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      floatingActionButton: FloatingActionButton(
          heroTag: "HEROOOO",
          onPressed: () {
            Navigator.of(context).pop();
          },
          backgroundColor: theme.floatingActionButtonColor,
          child: Icon(Icons.arrow_back, color: theme.floatingActionButtonIconColor),
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
                    "Flixbus Suche",
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
                                    from_search.name,
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
                                    to_search.name,
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
                future: getJourney(),
                builder: (BuildContext context, AsyncSnapshot<FlixbusJourneyModel> snapshot) {
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
                        if (snapshot.data.message == null) {
                          return Center(
                            child: Column(
                              children: <Widget>[
                                Text("Diese Suche ergab leider keinen Treffer", style: TextStyle(color: theme.subtitleColor)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Beachten sie, dass die Suche am besten mit Bahnhöfen funktioniert, und nicht mit Bushaltestellen, weil es für diese keinen Sparpreis gibt.")
                              ],
                            ),
                          );
                        }
                        return ListView.builder(
                            itemCount: snapshot.data.message.length,
                            itemBuilder: (BuildContext context, int index) {
                              return createCard(snapshot.data.message[index]);
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

  Widget createCard(Message message) {
    var begin = message.legs.first.departure;
    var end = message.legs.last.arrival;
    var difference = DurationParser.parse(end.difference(begin));


    return Card(
      color: theme.cardColor,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => FlixbusResultDetailed(trip: message)));
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.15,
          padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
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
                        message.legs.length.toString(),
                        style: TextStyle(
                            fontSize: 15,
                            color: theme.textColor
                        ),
                      ),
                    ],
                  ),
                  Text(
                    message.price.amount.toString() + " " + message.price.currency.toString(),
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'NunitoSansBold',
                        color: expensiveColor(message.price.amount)
                    ),
                  )
                ],
              ),
              Divider(
                height: 2.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Start: ",
                    style: TextStyle(
                        fontSize: 15,
                        color: theme.textColor
                    ),
                  ),
                  Text(
                    message.legs.first.origin.name,
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'NunitoSansBold',
                        color: theme.textColor
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Ziel: ",
                    style: TextStyle(
                        fontSize: 15,
                        color: theme.textColor
                    ),
                  ),
                  Text(
                    message.legs.last.destination.name,
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'NunitoSansBold',
                        color: theme.textColor
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Color expensiveColor(double amount) {
    if (amount > 41)
      return Colors.red;

    return Colors.green;
  }

  Future<FlixbusJourneyModel> getJourney() async {
    return FlixbusService.getJourney(from_search.id, from_search.type, to_search.id, to_search.type, DateParser.getRFCDate(date, time));
  }
}
