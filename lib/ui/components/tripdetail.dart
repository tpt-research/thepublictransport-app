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
  
  Color importanceColor(String value) {
    var convert = int.parse(value);
    if (convert < 3) return Colors.red;
    if (convert <= 5) return Colors.blue;
    else return Colors.green;
  }

  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(value['linedirection']),
      subtitle: new Text(value['stop'] + " • " + value['arrival'] + " • " + value['type']),
      leading: new Text(
          value['line'],
          style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w500
          )
      ),
      trailing: new Text(
          value['timeleft'],
          style: TextStyle(
              fontSize: 35,
              color: importanceColor(value['timeleft']),
              fontWeight: FontWeight.w300
          )
      ),
    );
  }
}