import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/components/tripdetail.dart';

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
                    return TripDetails(result: values[position]);
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