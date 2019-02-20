import 'package:flutter/material.dart';

class NearbyWidget extends StatefulWidget {
  @override
  NearbyWidgetState createState() => NearbyWidgetState();
}

class NearbyWidgetState extends State<NearbyWidget> {
  var values = getNearby();
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, position) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.fromLTRB(25, 0, 10, 20),
                          child: new SizedBox(
                            width: 50,
                            child: new Text(values[position]['line'],
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w500
                            )),
                          )
                        ),
                        new Container(
                          margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(values[position]['linedirection'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500
                                  )),
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Icon(const IconData(0xe570, fontFamily: 'MaterialIcons')),
                                  new Container(
                                    margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    child: Center(
                                      child: new Text(values[position]['stop'] + " • " + values[position]['arrival']),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            new Container(
                              margin: EdgeInsets.fromLTRB(60, 0, 0, 0),
                              child: new Center(
                                child: new Text(values[position]['timeleft'],
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w300
                                    )),
                              ),
                            )
                          ],
                        )
                      ],
                    );
                  },
                  itemCount: values.length,
                )
              ),
            ],
          )
      ),
    );
  }


  static List<Map<String, dynamic>> getNearby() {

    var map1 = {
      'line': 'U5',
      'linedirection': 'Preungesheim',
      'stop': 'Haltestelle 2',
      'type': 'metro',
      'arrival': '9:00',
      'timeleft': '0'
    };

    var map2 = {
      'line': 'U4',
      'linedirection': 'Enkheim',
      'stop': 'Haltestelle 2',
      'type': 'metro',
      'arrival': '9:06',
      'timeleft': '6'
    };

    var map3 = {
      'line': '34',
      'linedirection': 'Bornheim Mitte',
      'stop': 'Haltestelle 4',
      'type': 'bus',
      'arrival': '9:10',
      'timeleft': '10'
    };

    List<Map<String, dynamic>> list = [
      map1,
      map2,
      map3
    ];

    return list;
  }
}