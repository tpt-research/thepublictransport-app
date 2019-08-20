import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:thepublictransport_app/backend/models/core/DepartureModel.dart';
import 'package:thepublictransport_app/backend/service/core/CoreService.dart';

class StationDeparture extends StatefulWidget {
  final String stationId;

  StationDeparture(this.stationId);

  @override
  _StationDepartureState createState() => _StationDepartureState(stationId);
}

class _StationDepartureState extends State<StationDeparture> {
  final String stationId;

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
              return SpinKitRotatingCircle(
                color: Colors.black,
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
                        title: Text(snapshot.data.stationDepartures.first.departures[index].line.name),
                        subtitle: Text(snapshot.data.stationDepartures.first.departures[index].destination.name),
                        trailing: Text(dateTime.hour.toString() + ":" + dateTime.minute.toString().padLeft(2, '0')),
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
      stationId,
      "DB"
    );

    return response;
  }
}
