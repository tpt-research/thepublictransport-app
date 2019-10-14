import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';
import 'package:thepublictransport_app/backend/models/core/FluxDelayStream.dart';
import 'package:thepublictransport_app/backend/models/fluxfail/Report.dart';
import 'package:thepublictransport_app/backend/service/fluxfail/FluxFailService.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/framework/time/DurationParser.dart';
import 'package:url_launcher/url_launcher.dart';

// WIP, Won't be implemented until finished

class Delay extends StatefulWidget {
  @override
  _DelayState createState() => _DelayState();
}

class _DelayState extends State<Delay> {

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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20),
                  Text(
                    "Verspätungen",
                    style: TextStyle(
                        color: theme.titleColor,
                        fontSize: 30,
                        fontFamily: 'NunitoSansBold'
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Powered by ",
                          style: TextStyle(
                              color: theme.titleColor,
                              fontSize: 20,
                          ),
                        ),
                        InkWell(
                          onTap: _showMessage,
                          child: SizedBox(
                              height: 40,
                              width: 100,
                              child: Image.asset('icons/fluxfail.png')
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: FutureBuilder(
                future: getDelays(),
                builder: (BuildContext context, AsyncSnapshot<FluxDelayStream> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Center(
                        child: SizedBox(
                          width: 150,
                          height: 150,
                          child: FlareActor(
                            'anim/loader.flr',
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                            animation: 'Loading',
                          ),
                        ),
                      );
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Text(snapshot.error);
                      } else {
                        if (snapshot.data.reports == null) {
                          return Center(
                            child: Text("Diese Suche ergab leider keinen Treffer", style: TextStyle(color: theme.subtitleColor)),
                          );
                        }
                        return ListView.builder(
                            itemCount: snapshot.data.reports.length,
                            itemBuilder: (BuildContext context, int index) {
                              return createCard(snapshot.data.reports[index]);
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

  Widget createCard(Report report) {
    var begin = report.scheduledAt;
    var end = report.actuallyAt;
    var difference = DurationParser.parse(end.difference(begin));

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
                        color: Colors.red
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    difference,
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'NunitoSansBold',
                        color: Colors.red
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    begin.day.toString().padLeft(2, '0') + "." + begin.month.toString().padLeft(2, '0') + "." + begin.year.toString().padLeft(4, '0'),
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
                report.line + " " + report.direction,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'NunitoSansBold',
                    color: theme.textColor
                ),
              ),
              Text(
                "Gemeldet in: " + report.city + " - " + report.location,
                style: TextStyle(
                    fontSize: 15,
                    color: theme.textColor
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<FluxDelayStream> getDelays() async {
    return FluxFailService.getDelayStream(PrefService.getBool("datasave_mode") == false ? 10.toString() : 5.toString(), 0.toString());
  }

  void _showMessage() {
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
          title: SizedBox(
              height: 40,
              width: 100,
              child: Image.asset('icons/fluxfail.png')
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                  "flux.fail ist ein Projekt aus Berlin, welches das Ziel verfolgt, alle Verspätungen dieser Welt zu protokollieren, aber ohne eure Daten zu sammeln.",
                  style: TextStyle(
                    color: theme.textColor
                  ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  "Wir als Partner von flux.fail, wollen dies auch unterstützen.",
                  style: TextStyle(
                      color: theme.textColor
                  ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  'Wenn es euer Interesse geweckt hat und ihr vielleicht auch die Welt zu einer besseren machen wollt, dann klickt auf den "Ich bin dabei" Button und ihr werdet direkt umgeleitet.',
                  style: TextStyle(
                      color: theme.textColor
                  ),
              )
            ],
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                  "Ich bin dabei",
                  style: TextStyle(
                      color: theme.textColor
                  ),
              ),
              onPressed: () {
                _launchURL();
              },
            ),
            new FlatButton(
              child: new Text(
                  "Schließen",
                  style: TextStyle(
                      color: theme.textColor
                  ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _launchURL() async {
    const url = 'https://flux.fail';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
