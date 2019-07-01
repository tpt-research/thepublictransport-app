import 'package:desiredrive_api_flutter/models/rmv/rmv_subtrip.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:thepublictransport_app/pages/timeline/timeline_trip.dart';
import 'package:thepublictransport_app/ui/base/tptscaffold.dart';
import 'package:thepublictransport_app/ui/colors/color_theme_engine.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchResultShowPage extends StatefulWidget {
  SearchResultShowPage({@required this.result});

  final List<RMVSubtripModel> result;

  @override
  _SearchResultShowPageState createState() =>
      _SearchResultShowPageState(result);
}

class _SearchResultShowPageState extends State<SearchResultShowPage> {
  _SearchResultShowPageState(this.result);

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
            padding: EdgeInsets.fromLTRB(
                15, 0, 15, MediaQuery.of(context).size.height * 0.05),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 200,
            child: Card(
              elevation: 5,
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36.0),
                  side: ColorThemeEngine.decideBorderSide()),
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  ListTile(
                    title: new Text("Abfahrt".toUpperCase(),
                        style: new TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: ColorThemeEngine.titleColor)),
                    subtitle: new GradientText(
                      result.first.origin.name,
                      style: new TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                          color: ColorThemeEngine.titleColor),
                      gradient: ColorThemeEngine.tptgradient,
                    ),
                    trailing: IconButton(
                        icon: new Icon(
                          Icons.map,
                          color: ColorThemeEngine.iconColor,
                          size: 30,
                        ),
                        onPressed: () {
                          openCity(result.first.origin.name);
                        }),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  ListTile(
                    title: new Text("Abfahrtszeit".toUpperCase(),
                        style: new TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: ColorThemeEngine.titleColor)),
                    subtitle: new GradientText(
                      result.first.origin.time.hour.toString().padLeft(2, '0') +
                          ":" +
                          result.first.origin.time.minute
                              .toString()
                              .padLeft(2, '0'),
                      style: new TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                          color: Colors.grey),
                      gradient: ColorThemeEngine.tptgradient,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  ListTile(
                    title: new Text("Ankunft".toUpperCase(),
                        style: new TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: ColorThemeEngine.titleColor)),
                    subtitle: new GradientText(
                      result.last.destination.name,
                      style: new TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                          color: Colors.grey),
                      gradient: ColorThemeEngine.tptgradient,
                    ),
                    trailing: IconButton(
                        icon: new Icon(
                          Icons.map,
                          color: ColorThemeEngine.iconColor,
                          size: 30,
                        ),
                        onPressed: () {
                          openCity(result.last.destination.name);
                        }),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  ListTile(
                    title: new Text("Ankunftszeit".toUpperCase(),
                        style: new TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: ColorThemeEngine.titleColor)),
                    subtitle: new GradientText(
                      result.last.destination.time.hour
                              .toString()
                              .padLeft(2, '0') +
                          ":" +
                          result.last.destination.time.minute
                              .toString()
                              .padLeft(2, '0'),
                      style: new TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                          color: Colors.grey),
                      gradient: ColorThemeEngine.tptgradient,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  ListTile(
                    title: new Text("Fahrverlauf".toUpperCase(),
                        style: new TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: ColorThemeEngine.titleColor)),
                    subtitle: new GradientText(
                      "Fahrverlauf anzeigen",
                      style: new TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                          color: Colors.grey),
                      gradient: ColorThemeEngine.tptgradient,
                    ),
                    trailing: IconButton(
                        icon: new Icon(
                          Icons.timeline,
                          color: ColorThemeEngine.iconColor,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  SearchResultTripPage(result: result)));
                        }),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              SearchResultTripPage(result: result)));
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }

  openCity(String city) async {
    var url = "https://www.google.com/maps?q=" + city;

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
