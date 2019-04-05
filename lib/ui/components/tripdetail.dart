import 'package:flutter/material.dart';

class TripDetails extends StatefulWidget {
  TripDetails({this.result});

  final Map<String, dynamic> result;

  @override
  _TripDetailsState createState() => _TripDetailsState(this.result);
}

class _TripDetailsState extends State<TripDetails> {
  _TripDetailsState(this.value);

  final Map<String, dynamic> value;

  Widget build(BuildContext context) {
    return new Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
              margin: EdgeInsets.fromLTRB(25, 0, 10, 20),
              child: new SizedBox(
                width: 50,
                child: new Text(value['line'],
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w500
                    )
                ),
              )
          ),
          new Container(
              margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(value['linedirection'],
                      style: TextStyle(
                          fontWeight: FontWeight.w500
                      )
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Icon(const IconData(0xe570, fontFamily: 'MaterialIcons')),
                      new Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Center(
                          child: new Text(value['stop'] + " • " + value['arrival']),
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
                  child: new Text(value['timeleft'],
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w300
                      )
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}