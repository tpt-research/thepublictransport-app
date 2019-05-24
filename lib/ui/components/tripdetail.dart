import 'package:flutter/material.dart';
import 'dart:async';
import 'package:desiredrive_api_flutter/models/core/desire_nearby.dart';
import 'package:thepublictransport_app/ui/animations/showup.dart';
import 'package:thepublictransport_app/pages/tripshow.dart';
import 'package:thepublictransport_app/ui/colors/colorconstants.dart';

class TripDetails extends StatefulWidget {
  TripDetails({this.result});

  final DesireNearbyModel result;

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

  final DesireNearbyModel value;
  
  Color importanceColor(int value) {
    if (value < 3) return Colors.red;
    if (value <= 5) return Colors.blue;
    else return Colors.green;
  }

  Widget build(BuildContext context) {
    return new Visibility(
      visible: chooseVisibility(createTimeleft(value.realtime)),
      child: new InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => TripShowPage(model: value)));
        },
        child: new ListTile(
          title: new Text(
              value.direction,
              style: new TextStyle(
                color: ColorConstants.textColor
              ),
          ),
          subtitle: new Text(
            (value.realtime.hour.toString().padLeft(2, '0') + ":" + value.realtime.minute.toString().padLeft(2, '0'))  + " • " + chooseAdditionalLineString(value.product) + value.name + chooseDelay(value.time, value.realtime),
            style: new TextStyle(
              color: ColorConstants.subtitleColor
            ),
          ),
          leading: Container(
            child: new SizedBox(
                width: 50,
                height: 50,
                child: chooseIcon(value.product)
            ),
          ),
          trailing: new ShowUp(
            delay: 50,
            child: new Text(
                createTimeleft(value.realtime).toString(),
                style: TextStyle(
                    fontSize: 35,
                    color: importanceColor(createTimeleft(value.realtime)),
                    fontWeight: FontWeight.w300
                )
            ),
          ),
        ),
      ),
    );
  }
  
  Icon chooseIcon(String type) {
    switch (type) {
      case "RB":
      case "R-Bahn":
      case "IC":
      case "ICE":
      case "train":
        return Icon(
            Icons.train,
            color: ColorConstants.iconColor,
            size: 30,
        );
      case "Niederflurbus":
      case "bus":
        return Icon(
            Icons.directions_bus,
            color: ColorConstants.iconColor,
            size: 30,
        );
      case "Niederflurstraßenbahn":
      case "tram":
        return Icon(
            Icons.tram,
            color: ColorConstants.iconColor,
            size: 30,
        );
      default:
        return Icon(
            Icons.directions,
            color: ColorConstants.iconColor,
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
      case "RB":
      case "R-Bahn":
      case "IC":
      case "ICE":
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

  String chooseDelay(DateTime time, DateTime realtime) {
    var compare = realtime.difference(time);

    if (compare.inMinutes >= 5)
      return " • Verspätet";
    else
      return "";
  }
}