import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';
import 'package:thepublictransport_app/backend/models/core/DepartureModel.dart';
import 'package:thepublictransport_app/backend/service/core/CoreService.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';

class StationDeparture extends StatefulWidget {
  final String stationId;

  StationDeparture(this.stationId);

  @override
  _StationDepartureState createState() => _StationDepartureState(stationId);
}

class _StationDepartureState extends State<StationDeparture> {
  final String stationId;

  var theme = ThemeEngine.getCurrentTheme();

  _StationDepartureState(this.stationId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchDeparture(),
        builder: (BuildContext context, AsyncSnapshot<DepartureModel> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
            case ConnectionState.none:
              return SizedBox(
                width: 500,
                height: 500,
                child: FlareActor(
                  'anim/cloud_loading.flr',
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  animation: 'Sync',
                ),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text(snapshot.error);
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.stationDepartures.first.departures.length,
                    itemBuilder: (BuildContext context, int index) {
                      DateTime dateTime = DateTime.parse(
                          snapshot.data.stationDepartures.first.departures[index].time
                      );
                      return ListTile(
                        title: Text(
                            snapshot.data.stationDepartures.first.departures[index].line.name,
                            style: TextStyle(
                                color: theme.titleColor
                            ),
                        ),
                        subtitle: Text(
                            snapshot.data.stationDepartures.first.departures[index].destination.name,
                            style: TextStyle(
                                color: theme.subtitleColor
                            ),
                        ),
                        trailing: Text(
                            dateTime.hour.toString() + ":" + dateTime.minute.toString().padLeft(2, '0'),
                            style: TextStyle(
                                color: theme.textColor
                            ),
                        ),
                      );
                    }
                );
              }
          }

          return null;
        }
    );
  }

  Future<DepartureModel> fetchDeparture() async {
    final response = await CoreService.getDeparture(
      stationId, PrefService.getString('public_transport_data')
    );

    return response;
  }
}
