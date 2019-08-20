import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:thepublictransport_app/backend/models/core/LocationModel.dart';
import 'package:thepublictransport_app/backend/service/core/CoreService.dart';
import 'package:thepublictransport_app/pages/Station/Station.dart';
import 'package:thepublictransport_app/ui/animations/Marquee.dart';
import 'package:thepublictransport_app/ui/animations/ScaleUp.dart';
import 'package:thepublictransport_app/ui/animations/ShowUp.dart';

import 'package:thepublictransport_app/ui/components/Maps/MapsStops.dart';

class LocationShow extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchNearby(),
      builder: (BuildContext context, AsyncSnapshot<LocationModel> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.waiting:
          case ConnectionState.none:
            return ScaleUp(
              duration: Duration(milliseconds: 500),
              delay: 100,
              child: Center(
                child: SpinKitPulse(
                  size: 100,
                  color: Colors.black,
                )
              ),
            );
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text(snapshot.error);
            } else {
              List<Widget> generated = [];
              var counter = 0;

              for (var i in snapshot.data.suggestedLocations) {
                if (counter == 3)
                  break;

                generated.add(InkWell(
                  child: Chip(
                      avatar: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        child: Icon(Icons.directions_bus),
                      ),
                      backgroundColor: Colors.black,
                      label: Text(
                        i.location.name,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      )
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Station(i.location)));
                  },
                ));

                generated.add(SizedBox(width: 6));
                counter++;
              }

              return Column(
                children: <Widget>[
                  ShowUp(
                    duration: Duration(seconds: 1),
                    delay: 100,
                    child: Marquee(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: generated,
                      ),
                    ),
                  ),
                  ShowUp(
                    duration: Duration(seconds: 1),
                    delay: 500,
                    child: Container(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.025),
                        height: MediaQuery.of(context).size.height * 0.22,
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black
                              ),
                            ),
                            child: MapsStops(location: snapshot.data.suggestedLocations)
                        )
                    ),
                  ),
                ],
              );
            }
        }


        return null; // unreachable
      }
    );
  }

  Future<LocationModel> fetchNearby() async {
    final response = await CoreService.getLocationNearby(
        3.toString(),
        'DB'
    );

    return response;
  }
}
