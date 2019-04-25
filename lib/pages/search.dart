import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/components/searchbar.dart';
import 'package:thepublictransport_app/ui/colors/colorconstants.dart';
import 'package:thepublictransport_app/pages/loadscreen.dart';
import 'package:thepublictransport_app/ui/components/mapswidget.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:thepublictransport_app/ui/components/welcomecity.dart';
import 'package:thepublictransport_app/ui/animations/showup.dart';

import 'package:thepublictransport_app/pages/searchinput.dart';

class SearchWidget extends StatefulWidget {
  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {

  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).padding.left,
            0,
            MediaQuery.of(context).padding.right,
            MediaQuery.of(context).padding.bottom
        ),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                new SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: new FutureBuilder<MapsWidget>(
                    future: MapsWidgetDelayed(),
                    builder: (BuildContext context, AsyncSnapshot<MapsWidget> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return new Container(
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.10),
                            child: new SizedBox(
                                width: 50,
                                height: 50,
                                child: new CircularProgressIndicator()
                            ),
                          );
                        case ConnectionState.done:
                          if (snapshot.hasError)
                            return new Text('Error: ${snapshot.error}');
                          return snapshot.data;
                      }
                      return null; // unreachable
                    },
                  )
                ),
                new Center(
                  child: new Container(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.20),
                    child: new SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.70,
                      child: NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overscroll) {
                          overscroll.disallowGlow();
                        },
                        child: new ListView(
                          children: <Widget>[
                            ShowUp(
                              delay: 0,
                              child: new SizedBox(
                                width: MediaQuery.of(context).size.width * 0.95,
                                height: 375,
                                child: new Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          width: 0,
                                          color: Colors.black
                                      )
                                  ),
                                  color: Colors.white,
                                  child: new Container(
                                    padding: EdgeInsets.only(top: 10),
                                    child: new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Searchbar(
                                          text: "Start",
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) => SearchInput(title: "Start", mode: 1)
                                                )
                                            );
                                          },
                                        ),
                                        new Searchbar(
                                          text: "Ziel",
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) => SearchInput(title: "Ziel", mode: 2)
                                                )
                                            );
                                          },
                                        ),
                                        new Container(
                                          padding: EdgeInsets.only(top: 10),
                                          child: new Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              new Container(
                                                padding: EdgeInsets.fromLTRB(20, 10, 9, 0),
                                                child: new GradientButton(
                                                    increaseWidthBy: 30,
                                                    gradient: ColorConstants.tptfabgradient,
                                                    child: new Container(
                                                      padding: EdgeInsets.only(left: 10),
                                                      child: new Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: <Widget>[
                                                          new Icon(
                                                            Icons.calendar_today,
                                                            size: 20
                                                          ),
                                                          new Container(
                                                            padding: EdgeInsets.only(left: 7),
                                                            child: new Text(
                                                                '06.01.2000'
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    callback: () {

                                                    }
                                                ),
                                              ),
                                              new Container(
                                                padding: EdgeInsets.fromLTRB(0, 10, 12, 0),
                                                child: new GradientButton(
                                                    gradient: ColorConstants.tptfabgradient,
                                                    child: new Container(
                                                      padding: EdgeInsets.only(left: 10),
                                                      child: new Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: <Widget>[
                                                          new Icon(Icons.access_time),
                                                          new Container(
                                                            padding: EdgeInsets.only(left: 7),
                                                            child: new Text(
                                                                '5:45'
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    callback: () {

                                                    }
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        new Container(
                                          padding: EdgeInsets.fromLTRB(23, 20, 0, 0),
                                          child: new OutlineButton(
                                            highlightElevation: 0,
                                            borderSide: new BorderSide(style: BorderStyle.solid, width: 2, color: Colors.black),
                                            highlightedBorderColor: Colors.black,
                                            child: Text(
                                                'Optionen',
                                                style: new TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 17
                                                )
                                            ),
                                            onPressed: () {

                                            }
                                          ),
                                        ),
                                        new Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: <Widget>[
                                            new Container(
                                              alignment: Alignment.bottomRight,
                                              padding: EdgeInsets.fromLTRB(0, 5, 27, 10),
                                              child: new CircularGradientButton(
                                                  gradient: ColorConstants.tptfabgradient,
                                                  child: new Icon(
                                                      Icons.search
                                                  ),
                                                  callback: (){
                                                    onSubmit();
                                                  }
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ShowUp(
                                child: new WelcomeCity(
                                  city: "Berlin",
                                ),
                                delay: 300,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]
            )
          ],
        ),
      ),
    );
  }

  Future<MapsWidget> MapsWidgetDelayed() {
    return Future.delayed(const Duration(milliseconds: 1000), () {
      return MapsWidget();
    });
  }

  onSubmit() {
    http.get('https://2.db.transport.rest/stations?query=Mainz').then((query) {
      var decode = json.decode(query.body);
      print(decode[0]['id']);
      http.get('https://2.db.transport.rest/stations/' + decode[0]['id'].toString() + '/departures').then((departures) {
        var decode = json.decode(departures.body);
        print(decode.length);
      });
    });
  }
}