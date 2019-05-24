import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/base/tptfabscaffold.dart';
import 'package:desiredrive_api_flutter/models/rmv/rmv_subtrip.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:thepublictransport_app/ui/colors/colorconstants.dart';
import 'package:thepublictransport_app/pages/timeline_result.dart';

class SearchResultTripPage extends StatefulWidget {
  SearchResultTripPage({@required this.result});

  final List<RMVSubtripModel> result;

  @override
  _SearchResultTripPageState createState() => _SearchResultTripPageState(result);
}

class _SearchResultTripPageState extends State<SearchResultTripPage> {
  _SearchResultTripPageState(this.result);

  int currentPosition = 0;

  final List<RMVSubtripModel> result;

  Widget build(BuildContext context) {
    return new TPTScaffold(
      title: "Ihre Fahrt",
      body: new Container(
        child: new Container(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 200,
          child: Timeline(
            children: getTrip(result),
            position: TimelinePosition.Left,
          )
        ),
      ),
    );
  }

  List<TimelineModel> getTrip(List<RMVSubtripModel> model) {
    List<TimelineModel> parsed = [];
    for (var part in model) {
      parsed.add(getTripCard(part));

      if (part.type != "WALK" && currentPosition + 1 < model.length)
        if (model[currentPosition + 1].type != "WALK")
          parsed.add(getWayInTime(part));

      currentPosition++;
    }

    parsed.add(getFinishedCard());

    return parsed;
  }

  TimelineModel getTripCard(RMVSubtripModel model) {
    if (model.type == "WALK") {
      var walktime = model.destination.time.difference(model.origin.time);
      return TimelineModel(
          Container(
            child: new Card(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: ColorConstants.decideBorderSide()
              ),
              clipBehavior: Clip.antiAlias,
              color: ColorConstants.cardColor,
              child: new Container(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: new Text(
                          "Einstieg".toUpperCase(),
                          style: new TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: ColorConstants.titleColor
                          )
                      ),
                      subtitle: new GradientText(
                        model.origin.name,
                        style: new TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.grey
                        ),
                        gradient: ColorConstants.tptgradient,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          new GradientText(
                            model.origin.time.hour.toString().padLeft(2, '0') + ":" + model.origin.time.minute.toString().padLeft(2, '0'),
                            style: new TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.grey
                            ),
                            gradient: ColorConstants.tptgradient,
                          )
                        ],
                      ),
                      onTap:() {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => TimelineResultPage(model.origin.extID, model.origin.name)));
                      },
                    ),
                    ListTile(
                      title: new Text(
                          "Ausstieg".toUpperCase(),
                          style: new TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: ColorConstants.titleColor
                          )
                      ),
                      subtitle: new GradientText(
                        model.destination.name,
                        style: new TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.grey
                        ),
                        gradient: ColorConstants.tptgradient,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          new GradientText(
                            model.destination.time.hour.toString().padLeft(2, '0') + ":" + model.destination.time.minute.toString().padLeft(2, '0'),
                            style: new TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.grey
                            ),
                            gradient: ColorConstants.tptgradient,
                          )
                        ],
                      ),
                      onTap:() {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => TimelineResultPage(model.destination.extID, model.destination.name)));
                      },
                    ),
                    ListTile(
                        title: new Text(
                            "Laufzeit".toUpperCase(),
                            style: new TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: ColorConstants.titleColor
                            )
                        ),
                        subtitle: new GradientText(
                          walktime.inMinutes == 1 ? walktime.inMinutes.toString() + " Minute" : walktime.inMinutes.toString() + " Minuten",
                          style: new TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.grey
                          ),
                          gradient: ColorConstants.tptgradient,
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),
          position: TimelineItemPosition.left,
          iconBackground: Colors.purple,
          icon: Icon(Icons.directions_run, color: Colors.white)
      );
    }

    return TimelineModel(
      Container(
        child: new Card(
          margin: EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
              side: ColorConstants.decideBorderSide()
          ),
          color: ColorConstants.cardColor,
          clipBehavior: Clip.antiAlias,
          child: new Container(
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 10)),
                ListTile(
                  title: new Text(
                      "Von".toUpperCase(),
                      style: new TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: ColorConstants.titleColor
                      )
                  ),
                  subtitle: new GradientText(
                    model.origin.name,
                    style: new TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.grey
                    ),
                    gradient: ColorConstants.tptgradient,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      new GradientText(
                        model.origin.time.hour.toString().padLeft(2, '0') + ":" + model.origin.time.minute.toString().padLeft(2, '0'),
                        style: new TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.grey
                        ),
                        gradient: ColorConstants.tptgradient,
                      ),
                      new GradientText(
                        model.origin.track,
                        style: new TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.grey
                        ),
                        gradient: ColorConstants.tptgradient,
                      ),
                    ],
                  ),
                  onTap:() {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TimelineResultPage(model.origin.extID, model.origin.name)));
                  },
                ),
                ListTile(
                  title: new Text(
                      "Nach".toUpperCase(),
                      style: new TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: ColorConstants.titleColor
                      )
                  ),
                  subtitle: new GradientText(
                    model.destination.name,
                    style: new TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.grey
                    ),
                    gradient: ColorConstants.tptgradient,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      new GradientText(
                        model.destination.time.hour.toString().padLeft(2, '0') + ":" + model.destination.time.minute.toString().padLeft(2, '0'),
                        style: new TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.grey
                        ),
                        gradient: ColorConstants.tptgradient,
                      ),
                      new GradientText(
                        model.destination.track,
                        style: new TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.grey
                        ),
                        gradient: ColorConstants.tptgradient,
                      ),
                    ],
                  ),
                  onTap:() {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TimelineResultPage(model.destination.extID, model.destination.name)));
                  },
                ),
                ListTile(
                  title: new Text(
                      "Linie".toUpperCase(),
                      style: new TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: ColorConstants.titleColor
                      )
                  ),
                  subtitle: new GradientText(
                    model.lineName + " nach " + model.direction,
                    style: new TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.grey
                    ),
                    gradient: ColorConstants.tptgradient,
                  )
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
              ],
            ),
          ),
        ),
      ),
        position: TimelineItemPosition.left,
        iconBackground: ColorConstants.backgroundColor,
        icon: Icon(Icons.location_on, color: ColorConstants.iconColor)
    );
  }

  TimelineModel getWayInTime(RMVSubtripModel model) {
    Duration wayIn;
    try {
      wayIn = result[currentPosition + 1].origin.time.difference(result[currentPosition].destination.time);
    } catch (e) {
      wayIn = Duration(minutes: 0);
    }

    print(wayIn);

    String expression = "Minute";

    if (wayIn.inMinutes != 1)
      expression = "Minuten";

    return TimelineModel(
      Container(
        child: new Card(
          margin: EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
              side: ColorConstants.decideBorderSide()
          ),
          color: ColorConstants.cardColor,
          clipBehavior: Clip.antiAlias,
          child: new Container(
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 10)),
                ListTile(
                  title: new Text(
                      "Umsteigezeit".toUpperCase(),
                      style: new TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: ColorConstants.titleColor
                      )
                  ),
                  subtitle: new GradientText(
                    "Sie haben " + wayIn.inMinutes.toString() + " " + expression + " Umsteigezeit",
                    style: new TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                        color: Colors.grey
                    ),
                    gradient: ColorConstants.tptgradient,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
              ],
            ),
          ),
        ),
      ),
        position: TimelineItemPosition.left,
        iconBackground: Colors.purple,
        icon: Icon(Icons.directions_run, color: ColorConstants.iconColor)
    );
  }

  TimelineModel getFinishedCard() {
    return TimelineModel(
      Container(
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
              side: ColorConstants.decideBorderSide()
          ),
          color: ColorConstants.cardColor,
          clipBehavior: Clip.antiAlias,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Center(
              child: new GradientText(
                "Sie haben ihr Ziel erreicht! 🎉",
                gradient: ColorConstants.tptgradient,
                style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: Colors.grey
                ),
              ),
            ),
          ),
        ),
      ),
        position: TimelineItemPosition.left,
        iconBackground: Colors.pink,
        icon: Icon(Icons.done, color: Colors.white)
    );
  }

}