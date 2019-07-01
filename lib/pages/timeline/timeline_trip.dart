import 'package:desiredrive_api_flutter/models/rmv/rmv_subtrip.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:thepublictransport_app/pages/trip/trip_detail.dart';
import 'package:thepublictransport_app/ui/base/tptscaffold.dart';
import 'package:thepublictransport_app/ui/colors/color_theme_engine.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchResultTripPage extends StatefulWidget {
  SearchResultTripPage({@required this.result});

  final List<RMVSubtripModel> result;

  @override
  _SearchResultTripPageState createState() =>
      _SearchResultTripPageState(result);
}

class _SearchResultTripPageState extends State<SearchResultTripPage> {
  _SearchResultTripPageState(this.result);

  int currentPosition = 0;

  final List<RMVSubtripModel> result;

  Widget build(BuildContext context) {
    return new TPTScaffold(
      title: "Ihre Fahrt",
      keyboardFocusRemove: false,
      bodyIsExpanded: false,
      hasFab: true,
      body: new Container(
        child: new Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 200,
            child: Timeline(
              children: getTrip(result),
              position: TimelinePosition.Left,
            )),
      ),
    );
  }

  List<TimelineModel> getTrip(List<RMVSubtripModel> model) {
    List<TimelineModel> parsed = [];
    for (var part in model) {
      parsed.add(getTripCard(part));

      if (part.type != "WALK" &&
          currentPosition + 1 <
              model.length) if (model[currentPosition + 1].type != "WALK")
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
            child: InkWell(
              onTap: () {
                openWay(model.origin.name, model.destination.name);
              },
              child: new Card(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: ColorThemeEngine.decideBorderSide()),
                clipBehavior: Clip.antiAlias,
                color: ColorThemeEngine.cardColor,
                child: new Container(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: new Text("Von".toUpperCase(),
                            style: new TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: ColorThemeEngine.titleColor)),
                        subtitle: new GradientText(
                          model.origin.name,
                          style: new TextStyle(
                              fontFamily: 'NunitoSemiBold',
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.grey),
                          gradient: ColorThemeEngine.tptgradient,
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            new GradientText(
                              model.origin.time.hour
                                      .toString()
                                      .padLeft(2, '0') +
                                  ":" +
                                  model.origin.time.minute
                                      .toString()
                                      .padLeft(2, '0'),
                              style: new TextStyle(
                                  fontFamily: 'NunitoSemiBold',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.grey),
                              gradient: ColorThemeEngine.tptgradient,
                            )
                          ],
                        ),
                      ),
                      ListTile(
                        title: new Text("Nach".toUpperCase(),
                            style: new TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: ColorThemeEngine.titleColor)),
                        subtitle: new GradientText(
                          model.destination.name,
                          style: new TextStyle(
                              fontFamily: 'NunitoSemiBold',
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.grey),
                          gradient: ColorThemeEngine.tptgradient,
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            new GradientText(
                              model.destination.time.hour
                                      .toString()
                                      .padLeft(2, '0') +
                                  ":" +
                                  model.destination.time.minute
                                      .toString()
                                      .padLeft(2, '0'),
                              style: new TextStyle(
                                  fontFamily: 'NunitoSemiBold',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.grey),
                              gradient: ColorThemeEngine.tptgradient,
                            )
                          ],
                        ),
                      ),
                      ListTile(
                          title: new Text("Laufzeit".toUpperCase(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: ColorThemeEngine.titleColor)),
                          subtitle: new GradientText(
                            walktime.inMinutes == 1
                                ? walktime.inMinutes.toString() + " Minute"
                                : walktime.inMinutes.toString() + " Minuten",
                            style: new TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.grey),
                            gradient: ColorThemeEngine.tptgradient,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
          position: TimelineItemPosition.left,
          iconBackground: Colors.purple,
          icon: Icon(Icons.directions_run, color: ColorThemeEngine.iconColor));
    }

    return TimelineModel(
        Container(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TripDetailPage(model: model)));
            },
            child: new Card(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: ColorThemeEngine.decideBorderSide()),
              color: ColorThemeEngine.cardColor,
              clipBehavior: Clip.antiAlias,
              child: new Container(
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 10)),
                    ListTile(
                      title: new Text("Einstieg".toUpperCase(),
                          style: new TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: ColorThemeEngine.titleColor)),
                      subtitle: new GradientText(
                        model.origin.name,
                        style: new TextStyle(
                            fontFamily: 'NunitoSemiBold',
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.grey),
                        gradient: ColorThemeEngine.tptgradient,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          new GradientText(
                            model.origin.time.hour.toString().padLeft(2, '0') +
                                ":" +
                                model.origin.time.minute
                                    .toString()
                                    .padLeft(2, '0'),
                            style: new TextStyle(
                                fontFamily: 'NunitoSemiBold',
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.grey),
                            gradient: ColorThemeEngine.tptgradient,
                          ),
                          new GradientText(
                            model.origin.track,
                            style: new TextStyle(
                                fontFamily: 'NunitoSemiBold',
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.grey),
                            gradient: ColorThemeEngine.tptgradient,
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: new Text("Ausstieg".toUpperCase(),
                          style: new TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: ColorThemeEngine.titleColor)),
                      subtitle: new GradientText(
                        model.destination.name,
                        style: new TextStyle(
                            fontFamily: 'NunitoSemiBold',
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.grey),
                        gradient: ColorThemeEngine.tptgradient,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          new GradientText(
                            model.destination.time.hour
                                    .toString()
                                    .padLeft(2, '0') +
                                ":" +
                                model.destination.time.minute
                                    .toString()
                                    .padLeft(2, '0'),
                            style: new TextStyle(
                                fontFamily: 'NunitoSemiBold',
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.grey),
                            gradient: ColorThemeEngine.tptgradient,
                          ),
                          new GradientText(
                            model.destination.track,
                            style: new TextStyle(
                                fontFamily: 'NunitoSemiBold',
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.grey),
                            gradient: ColorThemeEngine.tptgradient,
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                        title: new Text("Linie".toUpperCase(),
                            style: new TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: ColorThemeEngine.titleColor)),
                        subtitle: new GradientText(
                          model.lineName + " nach " + model.direction,
                          style: new TextStyle(
                              fontFamily: 'NunitoSemiBold',
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.grey),
                          gradient: ColorThemeEngine.tptgradient,
                        )),
                    Padding(padding: EdgeInsets.only(top: 10)),
                  ],
                ),
              ),
            ),
          ),
        ),
        position: TimelineItemPosition.left,
        iconBackground: ColorThemeEngine.iconColor,
        icon: Icon(Icons.location_on, color: ColorThemeEngine.backgroundColor));
  }

  TimelineModel getWayInTime(RMVSubtripModel model) {
    Duration wayIn;
    try {
      wayIn = result[currentPosition + 1]
          .origin
          .time
          .difference(result[currentPosition].destination.time);
    } catch (e) {
      wayIn = Duration(minutes: 0);
    }

    String expression = "Minute";

    if (wayIn.inMinutes != 1) expression = "Minuten";

    return TimelineModel(
        Container(
          child: new Card(
            margin: EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
                side: ColorThemeEngine.decideBorderSide()),
            color: ColorThemeEngine.cardColor,
            clipBehavior: Clip.antiAlias,
            child: new Container(
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 10)),
                  ListTile(
                    title: new Text("Umsteigezeit".toUpperCase(),
                        style: new TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: ColorThemeEngine.titleColor)),
                    subtitle: new GradientText(
                      "Sie haben " +
                          wayIn.inMinutes.toString() +
                          " " +
                          expression +
                          " Umsteigezeit",
                      style: new TextStyle(
                          fontFamily: 'NunitoSemiBold',
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                          color: Colors.grey),
                      gradient: ColorThemeEngine.tptgradient,
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
        icon: Icon(Icons.directions_run, color: ColorThemeEngine.iconColor));
  }

  TimelineModel getFinishedCard() {
    return TimelineModel(
        Container(
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
                side: ColorThemeEngine.decideBorderSide()),
            color: ColorThemeEngine.cardColor,
            clipBehavior: Clip.antiAlias,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Center(
                child: new GradientText(
                  "Sie haben ihr Ziel erreicht! 🎉",
                  gradient: ColorThemeEngine.tptgradient,
                  style: new TextStyle(
                      fontFamily: 'NunitoSemiBold',
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
        position: TimelineItemPosition.left,
        iconBackground: Colors.pink,
        icon: Icon(Icons.done, color: Colors.white));
  }

  openWay(String from, String to) async {
    var url =
        "https://www.google.com/maps?origin=" + from + "&destination=" + to;

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
