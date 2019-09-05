import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:thepublictransport_app/backend/models/core/SparpreisFinderModel.dart';
import 'package:thepublictransport_app/backend/models/main/SuggestedLocation.dart';
import 'package:thepublictransport_app/backend/models/sparpreis/Message.dart';
import 'package:thepublictransport_app/backend/service/sparpreis/SparpreisService.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/framework/time/DateParser.dart';
import 'package:thepublictransport_app/framework/time/DurationParser.dart';
import 'package:thepublictransport_app/ui/animations/Marquee.dart';
import 'package:thepublictransport_app/ui/animations/ScaleUp.dart';

class SparpreisResult extends StatefulWidget {

  final SuggestedLocation from_search;
  final SuggestedLocation to_search;
  final TimeOfDay time;
  final DateTime date;

  const SparpreisResult({Key key, this.from_search, this.to_search, this.time, this.date}) : super(key: key);


  @override
  _SparpreisResultState createState() => _SparpreisResultState(from_search, to_search, time, date);
}

class _SparpreisResultState extends State<SparpreisResult> {

  final SuggestedLocation from_search;
  final SuggestedLocation to_search;
  final TimeOfDay time;
  final DateTime date;

  _SparpreisResultState(this.from_search, this.to_search, this.time, this.date);

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
                    "Sparpreis Finder",
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
                                    from_search.location.name + (from_search.location.place != null ? ", " + from_search.location.place : ""),
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
                                    to_search.location.name + (to_search.location.place != null ? ", " + to_search.location.place : ""),
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
                future: getSparpreise(),
                builder: (BuildContext context, AsyncSnapshot<SparpreisFinderModel> snapshot) {
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
    var travels = [];
    var counter = 0;

    for (var i in message.legs) {
      if (i.line == null)
        continue;

      travels.add(i.line.name.replaceAll(new RegExp("[^A-Za-z]+"), ""));
      counter++;
    }


    return Card(
      color: theme.cardColor,
      child: InkWell(
        onTap: () {

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
                        counter.toString(),
                        style: TextStyle(
                          fontSize: 15,
                            color: theme.textColor
                        ),
                      ),
                    ],
                  ),
                  Text(
                    message.price.amount.toString() + "0 " + message.price.currency.toString(),
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

  Color expensiveColor(double amount) {
    if (amount > 41)
      return Colors.red;

    return Colors.green;
  }

  Future<SparpreisFinderModel> getSparpreise() async {
    return SparpreisService.getSparpreise(from_search.location.id, to_search.location.id, DateParser.getRFCDate(date, time));
  }
}
