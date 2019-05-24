import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/base/tpttimelineresultscaffold.dart';
import 'package:thepublictransport_app/ui/components/tripdetail.dart';
import 'package:desiredrive_api_flutter/models/core/desire_nearby.dart';
import 'package:desiredrive_api_flutter/service/desirecore/desire_nearby_lib.dart';

class TimelineResultPage extends StatefulWidget {
  TimelineResultPage(this.id, this.name);
  final String id;
  final String name;

  @override
  _TimelineResultPage createState() => _TimelineResultPage(this.id, this.name);
}

class _TimelineResultPage extends State<TimelineResultPage> {
  _TimelineResultPage(this.id, this.name);
  final String id;
  final String name;

  Widget build(BuildContext context) {
    return new TPTScaffold(
      title: name,
      body: new SizedBox(
        height: MediaQuery.of(context).size.height - 300,
        width: MediaQuery.of(context).size.width,
        child: new Container(
          padding: EdgeInsets.fromLTRB(0, 10, 15, 0),
          child: new FutureBuilder<ListView>(
            future: getTrips(context, id),
            builder: (BuildContext context,
                AsyncSnapshot<ListView> snapshot) {
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
        ),
      ),
    );
  }

  Future<ListView> getTrips(BuildContext context, String id) async {
    DesireNearbyLib nearby = new DesireNearbyLib();
    var dep = await nearby.getSingleNearbyWithID(id);
    return new ListView(
      children: <Widget>[
        getList(dep)
      ],
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
    );
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
        ),
      );
    else
      return Container();
  }
}