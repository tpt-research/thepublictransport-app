import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/base/tptfabscaffold.dart';
import 'package:desiredrive_api_flutter/models/rmv/rmv_query.dart';
import 'package:desiredrive_api_flutter/models/rmv/rmv_trip.dart';
import 'package:desiredrive_api_flutter/service/rmv/rmv_trip_search_request.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:thepublictransport_app/ui/colors/color_theme_engine.dart';
import 'package:thepublictransport_app/pages/search/search_result_trip.dart';
import 'package:thepublictransport_app/ui/animations/showup.dart';

class SearchResultPage extends StatefulWidget {
  SearchResultPage({@required this.from, @required this.to, @required this.time, @required this.date, this.saveDrive});

  final RMVQueryModel from;
  final RMVQueryModel to;
  final String time;
  final String date;
  final bool saveDrive;

  @override
  _SearchResultPageState createState() => _SearchResultPageState(this.from, this.to, this.time, this.date, this.saveDrive);
}

class _SearchResultPageState extends State<SearchResultPage> {
  _SearchResultPageState(this.from, this.to, this.time, this.date, this.saveDrive);

  final RMVQueryModel from;
  final RMVQueryModel to;
  final String time;
  final String date;
  final bool saveDrive;

  Widget build(BuildContext context) {
    return new TPTScaffold(
      title: "Suchergebnisse",
      body: new Container(
        padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 200,
        child: new FutureBuilder<List<RMVTripModel>>(
          future: RMVTripRequest.getTrips(from.extID, to.extID, time, date, saveDrive, from.name, to.name),
          builder: (BuildContext context,
              AsyncSnapshot<List<RMVTripModel>> snapshot) {
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
                      child: new CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(ColorThemeEngine.iconColor))
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }

                return ShowUp(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, position) {
                      return getOverwiewCard(snapshot.data[position]);
                    },
                    itemCount: snapshot.data.length,
                  ),
                );
            }
            return null; // unreachable
          },
        ),
      ),
    );
  }

  Widget getOverwiewCard(RMVTripModel model) {
    DateTime start = model.leg.first.origin.time;
    DateTime end = model.leg.last.destination.time;

    String starttime_string = start.hour.toString().padLeft(2, '0') + ":" + start.minute.toString().padLeft(2, '0');
    String endtime_string = end.hour.toString().padLeft(2, '0') + ":" + end.minute.toString().padLeft(2, '0');
    Duration difference = end.difference(start);

    return new Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
          side: ColorThemeEngine.decideBorderSide()
      ),
      color: ColorThemeEngine.cardColor,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchResultTripPage(result: model.leg)));
        },
        child: new Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 10)),
              ListTile(
                title: new Text(
                    "Von".toUpperCase(),
                    style: new TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: ColorThemeEngine.titleColor
                    )
                ),
                subtitle: new GradientText(
                  model.from,
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
                    "Nach".toUpperCase(),
                    style: new TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: ColorThemeEngine.titleColor
                    )
                ),
                subtitle: new GradientText(
                  model.to,
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
                    "Abfahrt".toUpperCase(),
                    style: new TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: ColorThemeEngine.titleColor
                    )
                ),
                subtitle: new GradientText(
                  starttime_string,
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
                  endtime_string,
                  style: new TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      color: Colors.grey
                  ),
                  gradient: ColorThemeEngine.tptgradient,
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Text(
                        "Dauer".toUpperCase(),
                        style: new TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: ColorThemeEngine.titleColor
                        )
                    ),
                    new GradientText(
                      difference.inMinutes.toString() + " Minuten",
                      style: new TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                          color: Colors.grey
                      ),
                      gradient: ColorThemeEngine.tptgradient,
                    )
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
            ],
          ),
        ),
      ),
    );
  }
}