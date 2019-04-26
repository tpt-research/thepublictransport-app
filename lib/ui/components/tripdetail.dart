import 'package:flutter/material.dart';
import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
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
  
  Color importanceColor(String value) {
    var convert = int.parse(value);
    if (convert < 3) return Colors.red;
    if (convert <= 5) return Colors.blue;
    else return Colors.green;
  }

  Widget build(BuildContext context) {
    return ShowUp(
      delay: 1,
      child: new ListTile(
        title: new Text(value.direction),
        subtitle: new Text((value.when.add(Duration(hours: 2)).hour.toString() + ":" + value.when.minute.toString())  + " • " + value.line_mode),
        leading: Container(
          child: new SizedBox(
            width: 50,
            height: 50,
            child: new AutoSizeText(
                value.line_name,
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w500
                ),
                maxLines: 1,
            ),
          ),
        ),
        trailing: new Text(
            createTimeleft(value.when),
            style: TextStyle(
                fontSize: 35,
                color: importanceColor(createTimeleft(value.when)),
                fontWeight: FontWeight.w300
            )
        ),
      ),
    );
  }

  createTimeleft(DateTime time) {
    var left = time.difference(DateTime.now());

    return left.inMinutes.toString();
  }
}