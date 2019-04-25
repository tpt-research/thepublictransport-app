import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:desiredrive_api_flutter/models/db_departure.dart';

class TripDetails extends StatefulWidget {
  TripDetails({this.result});

  final DeutscheBahnDepartureModel result;

  @override
  _TripDetailsState createState() => _TripDetailsState(this.result);
}

class _TripDetailsState extends State<TripDetails> {
  _TripDetailsState(this.value);

  final DeutscheBahnDepartureModel value;
  
  Color importanceColor(String value) {
    var convert = int.parse(value);
    if (convert < 3) return Colors.red;
    if (convert <= 5) return Colors.blue;
    else return Colors.green;
  }

  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(value.direction),
      subtitle: new Text((value.when.hour.toString() + ":" + value.when.minute.toString())  + " • " + value.line_mode),
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
      /*trailing: new Text(
          value['timeleft'],
          style: TextStyle(
              fontSize: 35,
              color: importanceColor(value['timeleft']),
              fontWeight: FontWeight.w300
          )
      ),*/
    );
  }
}