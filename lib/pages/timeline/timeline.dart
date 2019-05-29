import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/base/tptfabscaffold.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:desiredrive_api_flutter/service/rmv/rmv_journeys_request.dart';
import 'package:desiredrive_api_flutter/models/rmv/rmv_journeys.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:thepublictransport_app/ui/colors/color_theme_engine.dart';
import 'package:thepublictransport_app/pages/timeline/timeline_result.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TimelinePage extends StatefulWidget {
  TimelinePage(this.journeyID);

  final String journeyID;

  @override
  _TimelinePage createState() => _TimelinePage(this.journeyID);
}

class _TimelinePage extends State<TimelinePage> {
  _TimelinePage(this.journeyID);

  final String journeyID;

  Future<List<TimelineModel>> getTimeline() async {
    List<RMVJourneysModel> models = await RMVJourneysRequest.getJourneys(this.journeyID);
    List<TimelineModel> timeline = [];

    for (var i in models) {
      var object = TimelineModel(
          Container(
            child: Card(
              color: ColorThemeEngine.cardColor,
              margin: EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: ColorThemeEngine.decideBorderSide()
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => TimelineResultPage(i.extID, i.name)));
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: new Text(
                            "Haltestelle".toUpperCase(),
                            style: new TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: ColorThemeEngine.titleColor
                            )
                        ),
                        subtitle: new GradientText(
                          i.name,
                          style: new TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                              color: Colors.grey
                          ),
                          gradient: ColorThemeEngine.tptgradient,
                        ),
                      ),
                      ListTile(
                        title: new Text(
                            "Ankunft".toUpperCase(),
                            style: new TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: ColorThemeEngine.titleColor
                            )
                        ),
                        subtitle: new GradientText(
                          i.time.hour.toString().padLeft(2, '0') + ":" + i.time.minute.toString().padLeft(2, '0'),
                          style: new TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                              color: Colors.grey
                          ),
                          gradient: ColorThemeEngine.tptgradient,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          position: TimelineItemPosition.left,
          iconBackground: ColorThemeEngine.iconColor,
          icon: Icon(Icons.location_on, color: ColorThemeEngine.backgroundColor)
      );
      timeline.add(object);
    }

    return timeline;
  }

  Widget build(BuildContext context) {
    return new TPTScaffold(
      title: "Timeline",
      body: new FutureBuilder<List<TimelineModel>>(
        future: getTimeline(),
        builder: (BuildContext context,
            AsyncSnapshot<List<TimelineModel>> snapshot) {
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
                    child: new SpinKitChasingDots(
                      size: 50,
                      color: ColorThemeEngine.iconColor,
                    )
                ),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                print(snapshot.error);
                return Container();
              }

              return SizedBox(
                height: MediaQuery.of(context).size.height - 200,
                width: MediaQuery.of(context).size.width,
                child: Timeline(children: snapshot.data, position: TimelinePosition.Left),
              );
          }
          return null; // unreachable
        },
      ),
    );
  }
}