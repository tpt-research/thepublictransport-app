import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thepublictransport_app/backend/models/core/ICEPortalModel.dart';
import 'package:thepublictransport_app/backend/service/iceportal/ICEPortalService.dart';
import 'package:thepublictransport_app/framework/language/GlobalTranslations.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/framework/time/UnixTimeParser.dart';


// Coming SoonTM
class ICEPortal extends StatefulWidget {
  @override
  _ICEPortalState createState() => _ICEPortalState();
}

class _ICEPortalState extends State<ICEPortal> {
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(36.0),
    topRight: Radius.circular(36.0),
  );

  var theme = ThemeEngine.getCurrentTheme();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: theme.backgroundColor,
      statusBarColor: Colors.transparent, // status bar color
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.status == "light" ? Colors.black : theme.cardColor,
      floatingActionButton: FloatingActionButton(
        heroTag: "HEROOOO",
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: theme.floatingActionButtonColor,
        child: Icon(Icons.arrow_back, color: theme.floatingActionButtonIconColor),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: FutureBuilder(
          future: getICEPortal(),
          builder: (BuildContext context, AsyncSnapshot<IcePortalModel> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Container(
                  color: theme.backgroundColor,
                  height: double.infinity,
                  child: Center(
                    child: SizedBox(
                      width: 500,
                      height: 500,
                      child: FlareActor(
                        'anim/cloud_loading.flr',
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                        animation: 'Sync',
                      ),
                    ),
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Container(
                    color: theme.backgroundColor,
                    height: double.infinity,
                    child: Text(snapshot.error),
                  );
                } else {
                  if (snapshot.data == null) {
                    return Container(
                      color: theme.backgroundColor,
                      height: double.infinity,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(allTranslations.text('ICEPORTAL.FAILED'), style: TextStyle(color: theme.subtitleColor)),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.80,
                              child: Text(allTranslations.text('ICEPORTAL.FAILED_MESSAGE'),
                                  style: TextStyle(color: theme.textColor),
                                  textAlign: TextAlign.center
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: theme.status == "light" ? Colors.black : theme.cardColor,
                      ),
                      height: MediaQuery.of(context).padding.top + MediaQuery.of(context).size.height * 0.34,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              allTranslations.text('ICEPORTAL.TITLE'),
                              style: TextStyle(
                                  fontFamily: 'NunitoSansBold',
                                  fontSize: 40,
                                  color: Colors.white
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data.trip.trainType + " " + snapshot.data.trip.vzn,
                                        style: TextStyle(
                                            color: Colors.white
                                        ),
                                      ),
                                      Text(
                                        snapshot.data.trip.tripDate.day.toString().padLeft(2, '0') + "." + snapshot.data.trip.tripDate.month.toString().padLeft(2, '0') + "." + snapshot.data.trip.tripDate.year.toString().padLeft(4, '0'),
                                        style: TextStyle(
                                            color: Colors.white
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: ClipRRect(
                        borderRadius: radius,
                        child: Container(
                          color: theme.backgroundColor,
                          height: double.infinity,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.trip.stops.length,
                              itemBuilder: (BuildContext context, int index) {
                                DateTime arrival;
                                String delay = "";
                                if (snapshot.data.trip.stops[index].timetable.scheduledArrivalTime != null) {
                                  arrival = UnixTimeParser.parse(
                                      snapshot.data.trip.stops[index].timetable.scheduledArrivalTime
                                  );

                                  delay = snapshot.data.trip.stops[index].timetable.arrivalDelay;
                                } else {
                                  arrival = UnixTimeParser.parse(
                                      snapshot.data.trip.stops[index].timetable.scheduledDepartureTime
                                  );

                                  delay = snapshot.data.trip.stops[index].timetable.departureDelay;
                                }

                                return ListTile(
                                  leading: Icon(
                                    Icons.train,
                                    color: theme.iconColor,
                                  ),
                                  title: Text(
                                    snapshot.data.trip.stops[index].station.name,
                                    style: TextStyle(
                                        color: theme.titleColor,
                                        fontFamily: 'NunitoSansBold'
                                    ),
                                  ),
                                  subtitle: Text(
                                      (snapshot.data.trip.stops[index].info.distance / 1000).toString() + "km",
                                    style: TextStyle(
                                        color: theme.subtitleColor
                                    ),
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        arrival.hour.toString() + ":" + arrival.minute.toString().padLeft(2, '0'),
                                        style: TextStyle(
                                            color: theme.textColor,
                                            fontFamily: 'NunitoSansBold'
                                        ),
                                      ),
                                      Text(
                                        delay,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: 'NunitoSansBold'
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                          ),
                        ),
                      ),
                    ),
                  ],
                );
            }
            return null;
          }
      ),
    );
  }

  Future<IcePortalModel> getICEPortal() async {
    return ICEPortalService.getICEPortal();
  }
}
