import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:preferences/preferences.dart';
import 'package:thepublictransport_app/backend/models/main/Location.dart';
import 'package:thepublictransport_app/backend/service/core/CoreService.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/pages/Station/Station.dart';
import 'package:thepublictransport_app/ui/animations/Marquee.dart';
import 'package:thepublictransport_app/ui/animations/ShowUp.dart';
import 'package:thepublictransport_app/ui/components/Maps/MapsStops.dart';
import 'package:toast/toast.dart';

class LocationShow extends StatelessWidget {

  var theme = ThemeEngine.getCurrentTheme();

  bool runAgain = true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchNearby(context),
      builder: (BuildContext context, AsyncSnapshot<List<Location>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.waiting:
          case ConnectionState.none:
            return SizedBox(
              width: 250,
              height: 250,
              child: FlareActor(
                'anim/cloud_loading.flr',
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: 'Sync',
              ),
            );
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Column(
                children: <Widget>[
                  ShowUp(
                    duration: Duration(seconds: 1),
                    delay: 100,
                    child: Text("Keine Haltestellen in der Nähe gefunden."),
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
                            child: MapsStops(location: snapshot.data)
                        )
                    ),
                  ),
                ],
              );
            } else {

              List<Widget> generated = [];
              List<Location> locations = Set<Location>.from(snapshot.data).toList();

              if (snapshot.data == null) {
                if (runAgain) {
                }
                return Column(
                  children: <Widget>[
                    ShowUp(
                      duration: Duration(seconds: 1),
                      delay: 100,
                      child: Text("Keine Haltestellen in der Nähe gefunden."),
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
                              child: MapsStops(location: snapshot.data)
                          )
                      ),
                    ),
                  ],
                );
              }

              for (var i in locations) {
                generated.add(InkWell(
                  child: Chip(
                      avatar: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        foregroundColor: theme.foregroundColor,
                        child: Icon(MaterialCommunityIcons.bus_multiple, color: theme.foregroundColor),
                      ),
                      backgroundColor: theme.textColor,
                      label: Text(
                        i.name,
                        style: TextStyle(
                            color: theme.foregroundColor
                        ),
                      )
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Station(i)));
                  },
                ));

                generated.add(SizedBox(width: 6));
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
                            child: MapsStops(location: snapshot.data)
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

  Future<List<Location>> fetchNearby(BuildContext context) async {
    List<Location> locations = [];

    final response = await CoreService.getLocationNearby(
        PrefService.getBool("datasave_mode") == false ? 2.toString() : 1.toString(),
        'DB'
    );

    if (response.locations != null) {
      for (var i in response.locations) {
        locations.add(i);
      }
    }

    if (PrefService.getString('public_transport_data') == 'DB') {
      final fuzzyResponse = await CoreService.getLocationNearbyAlternative(
          PrefService.getBool("datasave_mode") == false ? 2.toString() : 1
              .toString(),
          PrefService.getString('public_transport_data')
      );

      if (fuzzyResponse.locations != null) {
        for (var i in fuzzyResponse.locations) {
          locations.add(i);
        }
      }
    }

    return locations;
  }
}
