import 'package:flutter/material.dart';
import 'dart:async';
import 'package:desiredrive_api_flutter/models/db_departure.dart';
import 'package:thepublictransport_app/ui/animations/showup.dart';

class TripDetails extends StatefulWidget {
  TripDetails({this.result});

  final DeutscheBahnDepartureModel result;

  @override
  _TripDetailsState createState() => _TripDetailsState(this.result);
}

class _TripDetailsState extends State<TripDetails> {
  _TripDetailsState(this.value);

  Timer _everySecond;

  @override
  void initState() {
    super.initState();

    // defines a timer
    _everySecond = Timer.periodic(Duration(minutes: 1), (Timer t) {
      setState(() {

      });
    });
  }

  final DeutscheBahnDepartureModel value;
  
  Color importanceColor(int value) {
    if (value < 3) return Colors.red;
    if (value <= 5) return Colors.blue;
    else return Colors.green;
  }

  Widget build(BuildContext context) {
    return new Visibility(
      visible: chooseVisibility(createTimeleft(value.when)),
      child: ShowUp(
        delay: 1,
        child: new ListTile(
          title: new Text(value.direction),
          subtitle: new Text((value.when.add(Duration(hours: 2)).hour.toString() + ":" + value.when.minute.toString())  + " • " + chooseAdditionalLineString(value.line_mode) + value.line_name),
          leading: Container(
            child: new SizedBox(
              width: 50,
              height: 50,
              child: chooseIcon(value.line_mode)
            ),
          ),
          trailing: new Text(
              createTimeleft(value.when).toString(),
              style: TextStyle(
                  fontSize: 35,
                  color: importanceColor(createTimeleft(value.when)),
                  fontWeight: FontWeight.w300
              )
          ),
        ),
      ),
    );
  }
  
  Icon chooseIcon(String type) {
    switch (type) {
      case "train":
        return Icon(
            Icons.train,
            color: Colors.black,
            size: 30,
        );
      case "bus":
        return Icon(
            Icons.directions_bus,
            color: Colors.black,
            size: 30,
        );
      case "tram":
        return Icon(
            Icons.tram,
            color: Colors.black,
            size: 30,
        );
      default:
        return Icon(
            Icons.directions,
            color: Colors.black,
            size: 30,
        );
    }
  }
  
  bool chooseVisibility(int time) {
    if (time < 0)
      return false;
    else 
      return true;
  }

  String chooseAdditionalLineString(String type) {
    switch (type) {
      case "train":
        return " ";
      default:
        return "Linie: ";
    }
  }

  int createTimeleft(DateTime time) {
    var left = time.difference(DateTime.now());

    return left.inMinutes;
  }
}