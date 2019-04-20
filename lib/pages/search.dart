import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/components/searchbar.dart';
import 'package:thepublictransport_app/ui/colors/colorconstants.dart';
import 'package:thepublictransport_app/pages/loadscreen.dart';
import 'package:thepublictransport_app/ui/components/mapswidget.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

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
                  child: new MapsWidget()
                ),
                new Center(
                  child: new Container(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.20),
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
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => SearchInput(title: "Start", mode: 1)
                                    )
                                );
                              },
                              child: new Searchbar(
                                text: "Start",
                              ),
                            ),
                            new InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => SearchInput(title: "Ziel", mode: 2)
                                    )
                                );
                              },
                              child: new Searchbar(
                                text: "Ziel",
                              ),
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
                                    padding: EdgeInsets.fromLTRB(0, 10, 9, 0),
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
                                  padding: EdgeInsets.fromLTRB(0, 5, 27, 0),
                                  child: new CircularGradientButton(
                                      gradient: ColorConstants.tptfabgradient,
                                      child: new Icon(
                                          Icons.search
                                      ),
                                      callback: (){}
                                  ),
                                ),
                              ],
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

  onSubmit(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoadScreenWidget()
        )
    );
  }
}