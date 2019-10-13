import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:thepublictransport_app/backend/models/core/SparpreisFinderModel.dart';
import 'package:thepublictransport_app/backend/models/sparpreis/Message.dart';
import 'package:thepublictransport_app/backend/service/sparpreis/SparpreisService.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/framework/time/DateParser.dart';
import 'package:thepublictransport_app/framework/time/DurationParser.dart';
import 'package:url_launcher/url_launcher.dart';

class AlternativeSparpreis extends StatefulWidget {
  final String fromID;
  final String toID;
  final DateTime dateTime;

  const AlternativeSparpreis({Key key, this.fromID, this.toID, this.dateTime}) : super(key: key);

  @override
  _AlternativeSparpreisState createState() => _AlternativeSparpreisState(fromID, toID, dateTime);
}

class _AlternativeSparpreisState extends State<AlternativeSparpreis> {
  final String fromID;
  final String toID;
  final DateTime dateTime;

  _AlternativeSparpreisState(this.fromID, this.toID, this.dateTime);

  var theme = ThemeEngine.getCurrentTheme();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
    return SparpreisService.getSparpreise(fromID, toID, DateParser.getPureRFCDate(dateTime));
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
