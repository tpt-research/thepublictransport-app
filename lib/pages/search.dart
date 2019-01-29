import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchWidget extends StatefulWidget {
  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
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
                        new Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            new Card(
                              shape: StadiumBorder(side: BorderSide(width: 2.0)),
                              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: SizedBox(
                                  height: 50,
                                  child: new Container(
                                      padding: EdgeInsets.only(left: 17),
                                      child : new Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          new Text(
                                              'Start',
                                              style: new TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 17
                                              )
                                          )
                                        ],
                                      )
                                  )
                              ),
                            ),
                            new Card(
                              shape: StadiumBorder(side: BorderSide(width: 2.0)),
                              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: SizedBox(
                                  height: 50,
                                  child: new Container(
                                      padding: EdgeInsets.only(left: 17),
                                      child : new Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          new Text(
                                              'Ziel',
                                              style: new TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 17
                                              )
                                          ),
                                        ],
                                      )
                                  )
                              ),
                            ),
                          ],
                        )
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
                            onPressed: () {},
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

class MapsWidget extends StatefulWidget {
  @override
  State createState() => MapsWidgetState();
}

class MapsWidgetState extends State<MapsWidget> {

  GoogleMapController mapController;
  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(50.1287204, 8.6295871),
    zoom:17.0,
  );

  @override
  Widget build(BuildContext context) {
    return new GoogleMap(
        myLocationEnabled: true,
        initialCameraPosition: _kInitialPosition,
        onMapCreated: _onMapCreated,
        rotateGesturesEnabled: false,
        scrollGesturesEnabled: false,
        tiltGesturesEnabled: false,
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() { mapController = controller; });
  }
}