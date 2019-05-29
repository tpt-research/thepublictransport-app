import 'package:flutter/material.dart';
import 'package:desiredrive_api_flutter/models/core/desire_nearby.dart';
import 'package:thepublictransport_app/ui/base/tpttripshowscaffold.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:thepublictransport_app/ui/colors/color_theme_engine.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:thepublictransport_app/pages/timeline/timeline.dart';
import "package:flare_flutter/flare_actor.dart";

class TripShowPage extends StatefulWidget {
  final DesireNearbyModel model;

  TripShowPage({this.model});

  @override
  _TripShowPageState createState() => _TripShowPageState(this.model);
}

class _TripShowPageState extends State<TripShowPage> {
  final DesireNearbyModel model;

  _TripShowPageState(this.model);

  Widget build(BuildContext context) {
    return TPTScaffold(
      title: model.stop + " -> " + model.direction,
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: <Widget>[
            ListTile(
              title: new Text(
                  "Haltestelle in der Nähe".toUpperCase(),
                  style: new TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: ColorThemeEngine.titleColor
                  )
              ),
              subtitle: new GradientText(
                model.stop,
                style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: ColorThemeEngine.titleColor
                ),
                gradient: ColorThemeEngine.tptgradient,
              ),
              trailing: IconButton(
                  icon: new Icon(
                      Icons.map,
                      color: ColorThemeEngine.iconColor,
                      size: 30,
                  ),
                  onPressed: () {
                    openCity(model.stop);
                  }
              ),
            ),
            Padding(padding: EdgeInsets.only(top:15)),
            ListTile(
              title: new Text(
                  "Zwischenhaltestellen".toUpperCase(),
                  style: new TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: ColorThemeEngine.titleColor
                  )
              ),
              subtitle: new GradientText(
                "Zwischenhaltestellen anzeigen",
                style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: Colors.grey
                ),
                gradient: ColorThemeEngine.tptgradient,
              ),
              trailing: IconButton(
                  icon: new Icon(
                    Icons.timeline,
                    color: ColorThemeEngine.iconColor,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TimelinePage(model.journeyID)));
                  }
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => TimelinePage(model.journeyID)));
              },
            ),
            Padding(padding: EdgeInsets.only(top:15)),
            ListTile(
              title: new Text(
                  "Endhaltestelle".toUpperCase(),
                  style: new TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: ColorThemeEngine.titleColor
                  )
              ),
              subtitle: new GradientText(
                model.direction,
                style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: Colors.grey
                ),
                gradient: ColorThemeEngine.tptgradient,
              ),
              trailing: IconButton(
                  icon: new Icon(
                      Icons.map,
                      color: ColorThemeEngine.iconColor,
                      size: 30,
                  ),
                  onPressed: () {
                    openCity(model.direction);
                  }
              ),
            ),
            Padding(padding: EdgeInsets.only(top:15)),
            ListTile(
              title: new Text(
                  "Geplante Ankunft".toUpperCase(),
                  style: new TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: ColorThemeEngine.titleColor
                  )
              ),
              subtitle: new GradientText(
                model.time.hour.toString().padLeft(2, '0') + ":" + model.time.minute.toString().padLeft(2, '0'),
                style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: Colors.grey
                ),
                gradient: ColorThemeEngine.tptgradient,
              ),
            ),
            Padding(padding: EdgeInsets.only(top:15)),
            ListTile(
              title: new Text(
                  "Zurzeitige Ankunft".toUpperCase(),
                  style: new TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: ColorThemeEngine.titleColor
                  )
              ),
              subtitle: new GradientText(
                model.realtime.hour.toString().padLeft(2, '0') + ":" + model.realtime.minute.toString().padLeft(2, '0'),
                style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: Colors.grey
                ),
                gradient: ColorThemeEngine.tptgradient,
              ),
            ),
            Padding(padding: EdgeInsets.only(top:15)),
            ListTile(
              title: new Text(
                  "Linie".toUpperCase(),
                  style: new TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: ColorThemeEngine.titleColor
                  )
              ),
              subtitle: new GradientText(
                model.name,
                style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: Colors.grey
                ),
                gradient: ColorThemeEngine.tptgradient,
              ),
            ),
            Padding(padding: EdgeInsets.only(top:15)),
            ListTile(
              title: new Text(
                  "Typ".toUpperCase(),
                  style: new TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: ColorThemeEngine.titleColor
                  )
              ),
              subtitle: new GradientText(
                chooseType(model.product),
                style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: Colors.grey
                ),
                gradient: ColorThemeEngine.tptgradient,
              ),
              trailing: chooseIcon(model.product)
            ),
            Padding(padding: EdgeInsets.only(top:15)),
            chooseDelay(model.time, model.realtime)
          ],
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
          color: ColorThemeEngine.iconColor,
          size: 30,
        );
      case "Niederflurbus":
      case "bus":
        return Icon(
          Icons.directions_bus,
          color: ColorThemeEngine.iconColor,
          size: 30,
        );
      case "Niederflurstraßenbahn":
      case "tram":
        return Icon(
          Icons.tram,
          color: ColorThemeEngine.iconColor,
          size: 30,
        );
      default:
        return Icon(
          Icons.directions,
          color: ColorThemeEngine.iconColor,
          size: 30,
        );
    }
  }
  
  String chooseType(String type) {
    switch (type) {
      case "RB":
      case "R-Bahn":
      case "IC":
      case "ICE":
      case "train":
        return "Zug";
      case "Niederflurbus":
      case "bus":
        return "Bus";
      case "Niederflurstraßenbahn":
      case "tram":
        return "Straßenbahn";
      default:
        return "Unbekannt";
    }
  }

  openCity(String city) async {
    var url = "https://www.google.com/maps?q=" + city;

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget chooseDelay(DateTime time, DateTime realtime) {
    var compare = realtime.difference(time);

    print(compare.inMinutes);

    if (compare.inMinutes >= 5)
      return ListTile(
        title: new Text(
            "Verspätung".toUpperCase(),
            style: new TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: ColorThemeEngine.titleColor
            )
        ),
        subtitle: new GradientText(
          "Dieses Verkehrsmittel hat " + compare.inMinutes.toString() + " Minuten Verspätung. Weichen Sie lieber auf eine Alternative aus.",
          style: new TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Colors.grey
          ),
          gradient: Gradients.blush,
        ),
        trailing: Icon(
          Icons.warning,
          color: Colors.red,
          size: 30,
        ),
      );
    else
      return Container();
  }
}