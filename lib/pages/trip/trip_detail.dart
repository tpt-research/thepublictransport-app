import 'package:desiredrive_api_flutter/models/rmv/rmv_subtrip.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:thepublictransport_app/pages/timeline/timeline.dart';
import 'package:thepublictransport_app/ui/base/tptscaffold.dart';
import 'package:thepublictransport_app/ui/colors/color_theme_engine.dart';
import 'package:url_launcher/url_launcher.dart';

class TripDetailPage extends StatefulWidget {
  final RMVSubtripModel model;

  TripDetailPage({this.model});

  @override
  _TripDetailPageState createState() => _TripDetailPageState(this.model);
}

class _TripDetailPageState extends State<TripDetailPage> {
  final RMVSubtripModel model;

  _TripDetailPageState(this.model);

  Widget build(BuildContext context) {
    return TPTScaffold(
      title: "Reiseabschnitt",
      keyboardFocusRemove: false,
      bodyIsExpanded: true,
      hasFab: true,
      body: Container(
        padding: EdgeInsets.fromLTRB(
            15, 0, 15, MediaQuery.of(context).size.height * 0.10),
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
                  model.origin.name,
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
                      openCity(model.origin.name);
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
                  model.origin.time.hour.toString().padLeft(2, '0') +
                      ":" +
                      model.origin.time.minute.toString().padLeft(2, '0'),
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
                  model.destination.name,
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
                      openCity(model.destination.name);
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
                  model.destination.time.hour.toString().padLeft(2, '0') +
                      ":" +
                      model.destination.time.minute.toString().padLeft(2, '0'),
                  style: new TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      color: Colors.grey),
                  gradient: ColorThemeEngine.tptgradient,
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 15)),
              ListTile(
                title: new Text("Linie".toUpperCase(),
                    style: new TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: ColorThemeEngine.titleColor)),
                subtitle: new GradientText(
                  model.lineName,
                  style: new TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      color: Colors.grey),
                  gradient: ColorThemeEngine.tptgradient,
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 15)),
              ListTile(
                title: new Text("Zwischenhaltestellen".toUpperCase(),
                    style: new TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: ColorThemeEngine.titleColor)),
                subtitle: new GradientText(
                  "Zwischenhaltestellen anzeigen",
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
                          builder: (context) => TimelinePage(model.journeyID)));
                    }),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TimelinePage(model.journeyID)));
                },
              ),
            ],
          ),
        ),
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
