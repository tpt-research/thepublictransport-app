
import 'package:desiredrive_api_flutter/models/core/base/desire_journeys.dart';
import 'package:desiredrive_api_flutter/models/rmv/rmv_query.dart';
import 'package:desiredrive_api_flutter/service/desirecore/desire_nearby_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:thepublictransport_app/ui/base/tptscaffold.dart';
import 'package:thepublictransport_app/ui/colors/color_theme_engine.dart';
import 'package:thepublictransport_app/ui/components/tripdetail.dart';

class NearbySearchResultPage extends StatefulWidget {
  NearbySearchResultPage(this.rmv);

  final RMVQueryModel rmv;

  @override
  _NearbySearchResultPage createState() => _NearbySearchResultPage(this.rmv);
}

class _NearbySearchResultPage extends State<NearbySearchResultPage> {
  _NearbySearchResultPage(this.rmv);

  final RMVQueryModel rmv;

  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  Widget build(BuildContext context) {
    return new TPTScaffold(
      title: rmv.name,
      keyboardFocusRemove: false,
      bodyIsExpanded: true,
      hasFab: true,
      body: new SizedBox(
        height: MediaQuery.of(context).size.height - 300,
        width: MediaQuery.of(context).size.width,
        child: new Container(
          padding: EdgeInsets.fromLTRB(
              15, 0, 15, MediaQuery.of(context).size.height * 0.10),
          child: new FutureBuilder<ListView>(
            future: getTrips(context, rmv),
            builder: (BuildContext context, AsyncSnapshot<ListView> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return new SpinKitChasingDots(
                    size: 50,
                    color: ColorThemeEngine.iconColor,
                  );
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Container();
                  }

                  return Card(
                      elevation: 5,
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36.0),
                          side: ColorThemeEngine.decideBorderSide()),
                      child: snapshot.data);
              }
              return null; // unreachable
            },
          ),
        ),
      ),
    );
  }

  Future<ListView> getTrips(BuildContext context, RMVQueryModel query) async {
    DesireNearbyLib nearby = new DesireNearbyLib();
    var dep = await nearby.getSingleNearby(query);
    return new ListView(
      controller: _controller,
      children: <Widget>[
        getList(dep),
      ],
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
    );
  }

  Widget getList(List<DesireJourneyModel> model) {
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
      return Container();
  }
}
