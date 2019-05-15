import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/components/tripdetail.dart';
import 'package:thepublictransport_app/ui/base/tptnearbyscaffold.dart';
import 'package:desiredrive_api_flutter/service/desirecore/desire_nearby_lib.dart';
import 'package:desiredrive_api_flutter/models/core/desire_nearby.dart';
import 'package:thepublictransport_app/ui/animations/showup.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:thepublictransport_app/ui/colors/colorconstants.dart';

class NearbyWidget extends StatefulWidget {
  @override
  NearbyWidgetState createState() => NearbyWidgetState();
}

class NearbyWidgetState extends State<NearbyWidget> {
  Widget build(BuildContext context) {
    return TPTNearbyScaffold(
      title: "In der Nähe",
      body: new SizedBox(
        height: MediaQuery.of(context).size.height - 200,
        width: MediaQuery.of(context).size.width,
        child: new FutureBuilder<ListView>(
          future: getTrips(context),
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
                      child: new CircularProgressIndicator()
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

  Future<ListView> getTrips(BuildContext context) async {
    var nearby = new DesireNearbyLib();
    var dep = await nearby.getNearby(0);
    var altdep = await nearby.getNearby(1);
    var newdep = await nearby.getNearby(2);
    print(dep);
    return new ListView(
      children: <Widget>[
        ShowUp(
          child: getContainer(dep),
          delay: 50,
        ),
        ShowUp(
            child: getList(dep),
            delay: 100,
        ),
        ShowUp(
            child: getContainer(altdep),
            delay: 150,
        ),
        ShowUp(
            child: getList(altdep),
            delay: 200,
        ),
        ShowUp(
            child: getContainer(newdep),
            delay: 250,
        ),
        ShowUp(
            child: getList(newdep),
            delay: 300,
        )
      ],
    );
  }
  
  Future<Column> getExtraTrips(BuildContext context, List<DesireNearbyModel> model) async {
    return Column(
      children: <Widget>[
        getContainer(model),
        getList(model)
      ],
    );
  }
  
  Container getContainer(List<DesireNearbyModel> model) {
    if (model[0].name != "ERROR")
      return Container(
        padding: EdgeInsets.fromLTRB(15, 30, 0, 10),
        child: Row(
          children: <Widget>[
            Container(
              child: new GradientText(
                model[0].stop,
                style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: Colors.grey
                ),
                gradient: ColorConstants.tptgradient,
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
    if (model[0].name != "ERROR")
      return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, position) {
          return TripDetails(result: model[position]);
        },
        physics: NeverScrollableScrollPhysics(),
      );
    else
      return Container();
  } 
}