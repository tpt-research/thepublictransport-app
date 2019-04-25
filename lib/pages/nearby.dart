import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/components/tripdetail.dart';
import 'package:thepublictransport_app/ui/base/tptscaffold.dart';
import 'package:desiredrive_api_flutter/service/deutschebahn/db_departure_request.dart';
import 'package:desiredrive_api_flutter/service/deutschebahn/db_stations_request.dart';

class NearbyWidget extends StatefulWidget {
  @override
  NearbyWidgetState createState() => NearbyWidgetState();
}

class NearbyWidgetState extends State<NearbyWidget> {
  Widget build(BuildContext context) {
    return TPTScaffold(
      title: "In der Nähe",
      body: Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Flex(
                children: <Widget>[
                  new Expanded(
                    child: new FutureBuilder<SizedBox>(
                      future: getTrips(context),
                      builder: (BuildContext context,
                          AsyncSnapshot<SizedBox> snapshot) {
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
                                height: MediaQuery.of(context).size.height - 156,
                                width: MediaQuery.of(context).size.width,
                                child: new Center(
                                    child: new Text(
                                        "Wir haben gerade Probleme mit den externen Servern der Deutschen Bahn. Wir bitten um Entschuldigung. \n Error: ${snapshot.error}",
                                        textAlign: TextAlign.center,
                                    )
                                )
                              );
                            }

                            return snapshot.data;
                        }
                        return null; // unreachable
                      },
                    ),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                direction: Axis.horizontal,
              ),
            ],
          )
      ),
    );
  }

  Future<SizedBox> getTrips(BuildContext context) {
    var stations = new DeutscheBahnStationsRequest(http_id: "TPT");
    var departure = new DeutscheBahnDepartureRequest(http_id: "TPT");

    return stations.getMostRelevantStation('Mainz').then((res) {
      return departure.getDepartures(res.id.toString()).then((dep) {
        return new SizedBox(
          height: MediaQuery.of(context).size.height- 156,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, position) {
              return TripDetails(result: dep[position]);
            },
            itemCount: dep.length,
          ),
        );
      });
    });
  }
}