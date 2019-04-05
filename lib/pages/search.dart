import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/components/searchbar.dart';
import 'package:thepublictransport_app/ui/components/mapswidget.dart';
import 'package:thepublictransport_app/ui/base/tptscaffold.dart';

class SearchWidget extends StatefulWidget {
  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {

  Widget build(BuildContext context) {
    return new TPTScaffold(
      body: new Container(
        child: new Stack(
          children: <Widget>[
            new Positioned(
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: MapsWidget()
                    ),
                  ]
              ),
            ),
            new Container(
              child: new Card(
                margin: EdgeInsets.fromLTRB(10, 150, 10, 100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)
                ),
                child: new Column(
                  children: <Widget>[
                    new Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new Searchbar(
                          text: "Start",
                        ),
                        new Searchbar(
                          text: "Ziel",
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Card(
                          shape: StadiumBorder(),
                          elevation: 0,
                          color: Colors.grey[100],
                          margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                          child: new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Card(
                                elevation: 0,
                                shape: StadiumBorder(),
                                color: Colors.grey[300],
                                child: Icon(const IconData(0xe192, fontFamily: 'MaterialIcons')),
                              ),
                              new Text('12:24' + '   ',
                              style: new TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 17
                                )
                              ),
                            ],
                          ),
                        ),
                        new Card(
                          shape: StadiumBorder(),
                          elevation: 0,
                          color: Colors.grey[100],
                          margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
                          child: new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Card(
                                elevation: 0,
                                shape: StadiumBorder(),
                                color: Colors.grey[300],
                                child: Icon(const IconData(0xe935, fontFamily: 'MaterialIcons')),
                              ),
                              new Text('06.01.2000' + '   ',
                                  style: new TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 17
                                  )
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    new Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                          child: new OutlineButton(
                            highlightElevation: 0,
                            borderSide: new BorderSide(style: BorderStyle.solid, width: 2, color: Colors.black),
                            onPressed: () {},
                            child: Text(
                              'Optionen',
                              style: new TextStyle(
                                  fontFamily: 'Roboto',
                                  fontStyle: FontStyle.normal,
                                  fontSize: 17)),
                          ),
                        )
                      ],
                    ),
                    new Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: new FloatingActionButton(
                            elevation: 0,
                            backgroundColor: Colors.black,
                            onPressed: () {
                            },
                            child: Icon(const IconData(0xe52e, fontFamily: 'MaterialIcons')),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            )
          ],
        ),
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.center,
      ),
    );
  }
}