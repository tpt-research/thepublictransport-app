import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:preferences/preferences.dart';
import 'package:thepublictransport_app/backend/models/core/FluxDelayStream.dart';
import 'package:thepublictransport_app/backend/models/fluxfail/Report.dart';
import 'package:thepublictransport_app/backend/service/fluxfail/FluxFailService.dart';
import 'package:thepublictransport_app/framework/time/DurationParser.dart';
import 'package:thepublictransport_app/ui/animations/ScaleUp.dart';
import 'package:url_launcher/url_launcher.dart';

class Delay extends StatefulWidget {
  @override
  _DelayState createState() => _DelayState();
}

class _DelayState extends State<Delay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "HEROOOO",
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20),
                  Text(
                    "Verspätungen",
                    style: TextStyle(
                        color: Colors.black,
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
                              color: Colors.black,
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
                        if (snapshot.data.reports == null) {
                          return Center(
                            child: Text("Diese Suche ergab leider keinen Treffer", style: TextStyle(color: Colors.grey)),
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
                        fontFamily: 'NunitoSansBold'
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
                    fontFamily: 'NunitoSansBold'
                ),
              ),
              Text(
                "Gemeldet in: " + report.city + " - " + report.location,
                style: TextStyle(
                    fontSize: 15,
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
          title: SizedBox(
              height: 40,
              width: 100,
              child: Image.asset('icons/fluxfail.png')
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                  "flux.fail ist ein Projekt aus Berlin, welches das Ziel verfolgt, alle Verspätungen dieser Welt zu protokollieren, aber ohne eure Daten zu sammeln."
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  "Wir als Partner von flux.fail, wollen dies auch unterstützen."
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  'Wenn es euer Interesse geweckt hat und ihr vielleicht auch die Welt zu einer besseren machen wollt, dann klickt auf den "Ich bin dabei" Button und ihr werdet direkt umgeleitet.'
              )
            ],
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Ich bin dabei"),
              onPressed: () {
                _launchURL();
              },
            ),
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

  _launchURL() async {
    const url = 'https://flux.fail';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
