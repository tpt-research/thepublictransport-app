import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:preferences/preferences.dart';
import 'package:thepublictransport_app/backend/models/main/SuggestedLocation.dart';
import 'package:thepublictransport_app/framework/scale/Scaler.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/pages/Result/Result.dart';
import 'package:thepublictransport_app/pages/Search/Search.dart';
import 'package:thepublictransport_app/pages/Station/Station.dart';
import 'package:thepublictransport_app/ui/animations/ShowUp.dart';
import 'package:thepublictransport_app/ui/components/OptionSwitch.dart';
import 'package:thepublictransport_app/ui/components/Searchbar.dart';

class HomeSlider extends StatefulWidget {
  @override
  _HomeSliderState createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {

  var theme = ThemeEngine.getCurrentTheme();

  TimeOfDay setup_time = new TimeOfDay.now();
  DateTime setup_date = new DateTime.now();

  bool accessibility = false;

  SuggestedLocation stop_search;

  SuggestedLocation from_search;
  SuggestedLocation to_search;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 80,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(50)
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Text(
            "Menü",
            style: TextStyle(
                color: theme.textColor,
                fontSize: 30,
                fontFamily: 'NunitoSansBold'
            ),
          ),
          Flexible(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  child: GradientCard(
                    gradient: Gradients.cosmicFusion,
                    shadowColor: Gradients.cosmicFusion.colors.last.withOpacity(0.25),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0)
                    ),
                    child: SizedBox(
                      height: Scaler.heightScaling(context, 0.43),
                      width: double.infinity,
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.search, color: theme.titleColorInverted, size: 30),
                                SizedBox(width: 5),
                                Text(
                                  "Suche",
                                  style: TextStyle(
                                      color: theme.titleColorInverted,
                                      fontSize: 30,
                                      fontFamily: 'NunitoSansBold'
                                  ),
                                ),
                              ],
                            ),
                            Searchbar(
                              text: from_search != null ? from_search.location.name : "Start",
                              onTap: () async {
                                var result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Search()));

                                if (result != null) {
                                  setState(() {
                                    from_search = result;
                                  });
                                }
                              },
                            ),
                            Searchbar(
                              text: to_search != null ? to_search.location.name : "Ziel",
                              onTap: () async {
                                var result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Search()));

                                if (result != null) {
                                  setState(() {
                                    to_search = result;
                                  });
                                }
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: _selectTime,
                                  child: Chip(
                                    avatar: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: theme.iconColor,
                                      child: Icon(Icons.access_time, size: 20, color: theme.iconColor),
                                    ),
                                    label: Text(
                                      setup_time.hour.toString() + ":" + setup_time.minute.toString().padLeft(2, '0'),
                                      style: TextStyle(
                                          color: theme.textColor
                                      ),
                                    ),
                                    backgroundColor: theme.backgroundColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                InkWell(
                                  onTap: _selectDate,
                                  child: Chip(
                                    avatar: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: theme.iconColor,
                                      child: Icon(MaterialCommunityIcons.calendar_search, size: 20, color: theme.iconColor),
                                    ),
                                    label: Text(
                                      setup_date.day.toString().padLeft(2, '0') + "." + setup_date.month.toString().padLeft(2, '0') + "." + setup_date.year.toString().padLeft(4, '0'),
                                      style: TextStyle(
                                          color: theme.textColor
                                      ),
                                    ),
                                    backgroundColor: theme.backgroundColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                OutlineButton(
                                  onPressed: () {
                                    showOptionsModal();
                                  },
                                  borderSide: BorderSide(color: theme.foregroundColor, width: 1.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Colors.transparent,
                                  child: Text(
                                    "Optionen",
                                    style: TextStyle(
                                        color: theme.foregroundColor
                                    ),
                                  ),
                                ),
                                FloatingActionButton(
                                  onPressed: () {
                                    if (from_search == null) return;
                                    if (to_search == null) return;
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Result(
                                      from_search: from_search,
                                      to_search: to_search,
                                      time: setup_time,
                                      date: setup_date,
                                      barrier: PrefService.getBool("wheelchair_mode") ?? false,
                                      fastroute: PrefService.getBool("fast_mode") ?? false,
                                      slowwalk: PrefService.getBool("walk_mode") ?? false,
                                    )));
                                  },
                                  heroTag: "HEROOOO2",
                                  backgroundColor: theme.foregroundColor,
                                  child: Icon(Icons.search, color: theme.iconColor),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
                  child: GradientCard(
                    gradient: Gradients.jShine,
                    shadowColor: Gradients.jShine.colors.last.withOpacity(0.25),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0)
                    ),
                    child: SizedBox(
                      height: Scaler.heightScaling(context, 0.30),
                      width: double.infinity,
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.location_on, color: theme.titleColorInverted, size: 30),
                                SizedBox(width: 5),
                                Text(
                                  "Haltestellensuche",
                                  style: TextStyle(
                                      color: theme.titleColorInverted,
                                      fontSize: 30,
                                      fontFamily: 'NunitoSansBold'
                                  ),
                                ),
                              ],
                            ),
                            Searchbar(
                              text: stop_search != null ? stop_search.location.name : "Suche",
                              onTap: () async {
                                var result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Search()));

                                if (result != null) {
                                  setState(() {
                                    stop_search = result;
                                  });
                                }
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                FloatingActionButton(
                                  onPressed: () {
                                    if (stop_search == null) return;
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Station(stop_search.location)));
                                  },
                                  heroTag: "HEROOOO3",
                                  backgroundColor: theme.foregroundColor,
                                  child: Icon(Icons.location_on, color: theme.iconColor),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  showOptionsModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: theme.backgroundColor,
          body: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              new OptionSwitch(
                title: "Barrierefreiheit",
                icon: Icons.accessible,
                id: "wheelchair_mode",
                default_bool: false,
              ),
              new OptionSwitch(
                title: "Schnellste Route",
                icon: Icons.fast_forward,
                id: "fast_mode",
                default_bool: true,
              ),
              new OptionSwitch(
                title: "Längere Laufzeit",
                icon: Icons.directions_walk,
                id: "walk_mode",
                default_bool: false,
              ),
            ],
          ),
        );
      },
    );
  }

  Future _selectTime() async {
    TimeOfDay selectedTime24Hour = await showTimePicker(
      context: context,
      initialTime: setup_time,
      builder: (BuildContext context, Widget child) {
        return ShowUp(
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child,
          ),
        );
      },
    );

    if (selectedTime24Hour != null)
      setState(() {
        setup_time = selectedTime24Hour;
      });
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: setup_date,
      firstDate: new DateTime(2019),
      lastDate: new DateTime(2020),
      builder: (BuildContext context, Widget child) {
        return ShowUp(
          child: MediaQuery(
            data: MediaQuery.of(context),
            child: child,
          ),
        );
      },
    );

    if (picked != null)
      setState(() {
        setup_date = picked;
      });
  }
}

