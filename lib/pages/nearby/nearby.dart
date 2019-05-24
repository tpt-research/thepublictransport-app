import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/components/tripdetail.dart';
import 'package:thepublictransport_app/ui/base/tptnearbyscaffold.dart';
import 'package:desiredrive_api_flutter/service/desirecore/desire_nearby_lib.dart';
import 'package:desiredrive_api_flutter/models/core/desire_nearby.dart';
import 'package:thepublictransport_app/ui/animations/showup.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:thepublictransport_app/ui/colors/color_theme_engine.dart';
class NearbyWidget extends StatefulWidget {
  @override
  NearbyWidgetState createState() => NearbyWidgetState();
}

class NearbyWidgetState extends State<NearbyWidget> {

  Widget build(BuildContext context) {
    return TPTScaffold(
      title: "In der Nähe",
      body: new SizedBox(
        height: MediaQuery.of(context).size.height - 220,
        width: MediaQuery.of(context).size.width,
        child: new FutureBuilder<ListView>(
          future: getMasterView(context),
          builder: (BuildContext context,
              AsyncSnapshot<ListView> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.waiting:
              case ConnectionState.none:
                return new Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: MediaQuery
                      .of(context)
                      .size
                      .width * 0.10),
                  child: new SizedBox(
                      width: 50,
                      height: 50,
                      child: new CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(ColorThemeEngine.iconColor))
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return new SizedBox(
                      height: MediaQuery.of(context).size.height - 200,
                      width: MediaQuery.of(context).size.width,
                      child: ShowUp(
                        delay: 1,
                        child: new Center(
                            child: new Text(
                              "Wir haben gerade Probleme mit den externen Servern der Deutschen Bahn. Wir bitten um Entschuldigung. \n Error: ${snapshot.error}",
                              textAlign: TextAlign.center,
                            )
                        ),
                      )
                  );
                }

                return new ShowUp(
                    child: snapshot.data
                );
            }
            return null; // unreachable
          },
        ),
      ),
    );
  }

  Future<ListView> getMasterView(BuildContext context) async {
    var nearby = new DesireNearbyLib();
    var query = await nearby.getQuery(3);

    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: <Widget>[
        new FutureBuilder<Card>(
          future: getTrips(context, 0, query, nearby),
          builder: (BuildContext context,
              AsyncSnapshot<Card> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.waiting:
              case ConnectionState.none:
                return new Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: MediaQuery
                      .of(context)
                      .size
                      .width * 0.10),
                  child: new SizedBox(
                      width: 50,
                      height: 50,
                      child: new CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(ColorThemeEngine.iconColor))
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Container();
                }

                return snapshot.data;
            }
            return null; // unreachable
          },
        ),
        Padding(padding: EdgeInsets.only(top: 7)),
        new FutureBuilder<Card>(
          future: getTrips(context, 1, query, nearby),
          builder: (BuildContext context,
              AsyncSnapshot<Card> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.waiting:
              case ConnectionState.none:
                return new Container();
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Container();
                }

                return snapshot.data;
            }
            return null; // unreachable
          },
        ),
        Padding(padding: EdgeInsets.only(top: 7)),
        new FutureBuilder<Card>(
          future: getTrips(context, 2, query, nearby),
          builder: (BuildContext context,
              AsyncSnapshot<Card> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.waiting:
              case ConnectionState.none:
                return new Container();
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Container();
                }

                return snapshot.data;
            }
            return null; // unreachable
          },
        ),
      ],
    );
  }

  Future<Card> getTrips(BuildContext context, int index, List query, DesireNearbyLib nearby) async {
    var dep = await nearby.getNearby(index, query);
    return new Card(
      color: ColorThemeEngine.cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
          side: ColorThemeEngine.decideBorderSide()
      ),
      child: new ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 10)),
          getContainer(dep),
          getList(dep)
        ],
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
      ),
    );
  }

  ListView getNoTripList() {
    return new ListView(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 10)),
        ListTile(
          title: new Text("Keine Fahrten"),
          subtitle: new Text("Keine Fahrten innerhalb der nächsten 60 Minuten"),
        )
      ],
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
    );
  }
  
  Container getContainer(List<DesireNearbyModel> model) {
    if (model != [])
      return Container(
        padding: EdgeInsets.fromLTRB(15, 5, 0, 10),
        child: Row(
          children: <Widget>[
            Container(
              child: new GradientText(
                model[0].stop,
                style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25
                ),
                gradient: ColorThemeEngine.tptgradient,
              ),
              alignment: Alignment.centerLeft,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      );
    else
      return Container();
  }
  
  Widget getList(List<DesireNearbyModel> model) {
    if (model != [])
      return Container(
        padding: EdgeInsets.only(bottom: 20),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, position) {
            return TripDetails(result: model[position]);
          },
          itemCount: model.length,
          physics: NeverScrollableScrollPhysics(),
        ),
      );
    else
      return getNoTripList();
  } 
}