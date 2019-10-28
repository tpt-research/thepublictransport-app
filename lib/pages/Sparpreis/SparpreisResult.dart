import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:thepublictransport_app/backend/models/core/SparpreisFinderModel.dart';
import 'package:thepublictransport_app/backend/models/main/SuggestedLocation.dart';
import 'package:thepublictransport_app/backend/models/sparpreis/Message.dart';
import 'package:thepublictransport_app/backend/service/sparpreis/SparpreisService.dart';
import 'package:thepublictransport_app/framework/language/GlobalTranslations.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/framework/time/DateParser.dart';
import 'package:thepublictransport_app/framework/time/DurationParser.dart';
import 'package:url_launcher/url_launcher.dart';

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
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(36.0),
    topRight: Radius.circular(36.0),
  );

  final SuggestedLocation from_search;
  final SuggestedLocation to_search;
  final TimeOfDay time;
  final DateTime date;

  _SparpreisResultState(this.from_search, this.to_search, this.time, this.date);

  var theme = ThemeEngine.getCurrentTheme();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
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
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            height: MediaQuery.of(context).padding.top + MediaQuery.of(context).size.height * 0.34,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    allTranslations.text('SPARPREIS.TITLE'),
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
                              from_search.location.name + (from_search.location.place != null ? ", " + from_search.location.place : ""),
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                            Text(
                              to_search.location.name + (to_search.location.place != null ? ", " + to_search.location.place : ""),
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
                              time.hour.toString() + ":" + time.minute.toString().padLeft(2, '0'),
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                            Text(
                              date.day.toString().padLeft(2, '0') + "." + date.month.toString().padLeft(2, '0') + "." + date.year.toString().padLeft(4, '0'),
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
            child: FutureBuilder(
                future: getSparpreise(),
                builder: (BuildContext context, AsyncSnapshot<SparpreisFinderModel> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return ClipRRect(
                        borderRadius: radius,
                        child: Container(
                          color: theme.backgroundColor,
                          height: double.infinity,
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
                              child: Text(snapshot.error),
                          ),
                        );
                      } else {
                        if (snapshot.data == null) {
                          return ClipRRect(
                            borderRadius: radius,
                            child: Container(
                              color: theme.backgroundColor,
                              height: double.infinity,
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    Text(allTranslations.text('SPARPREIS.RESULT.FAILED'), style: TextStyle(color: theme.subtitleColor)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(allTranslations.text('SPARPREIS.RESULT.FAILED_MESSAGE'))
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        return ClipRRect(
                          borderRadius: radius,
                          child: Container(
                            color: theme.backgroundColor,
                            height: double.infinity,
                            child: ListView.builder(
                                itemCount: snapshot.data.message.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return createCard(snapshot.data.message[index]);
                                }
                            ),
                          ),
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
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0)
      ),
      color: theme.cardColor,
      child: InkWell(
        onTap: () {
          getDBPage(message);
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

  getDBPage(Message message) async {
    var url = 'https://link.bahn.guru/?journey=' + message.toRawJson() + '&bc=0&class=2';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
