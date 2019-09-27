import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:thepublictransport_app/backend/models/flixbus/QueryResult.dart';
import 'package:thepublictransport_app/framework/scale/Scaler.dart';
import 'package:thepublictransport_app/framework/theme/PredefinedColors.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/pages/Flixbus/FlixbusQuery.dart';
import 'package:thepublictransport_app/pages/Flixbus/FlixbusResult.dart';
import 'package:thepublictransport_app/ui/animations/ShowUp.dart';
import 'package:thepublictransport_app/ui/components/Searchbar.dart';

class FlixbusSearch extends StatefulWidget {
  @override
  _FlixbusSearchState createState() => _FlixbusSearchState();
}

class _FlixbusSearchState extends State<FlixbusSearch> {
  var theme = ThemeEngine.getCurrentTheme();

  TimeOfDay setup_time = new TimeOfDay.now();
  DateTime setup_date = new DateTime.now();

  bool accessibility = false;

  QueryResult from_search;
  QueryResult to_search;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      floatingActionButton: FloatingActionButton(
        heroTag: "HEROOOO",
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: theme.floatingActionButtonColor,
        child: Icon(Icons.arrow_back, color: theme.floatingActionButtonIconColor),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.20,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        "Flixbus",
                        style: TextStyle(
                            color: theme.titleColor,
                            fontSize: 30,
                            fontFamily: 'NunitoSansBold'
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                child: GradientCard(
                  gradient: PredefinedColors.getFlixbusGradient(),
                  shadowColor: PredefinedColors.getFlixbusGradient().colors.last.withOpacity(0.25),
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
                            text: from_search != null ? from_search.name : "Start",
                            onTap: () async {
                              var result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => FlixbusQuery()));

                              if (result != null) {
                                setState(() {
                                  from_search = result;
                                });
                              }
                            },
                          ),
                          Searchbar(
                            text: to_search != null ? to_search.name : "Ziel",
                            onTap: () async {
                              var result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => FlixbusQuery()));

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
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              FloatingActionButton(
                                onPressed: () {
                                  if (from_search == null) return;
                                  if (to_search == null) return;
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => FlixbusResult(
                                    from_search: from_search,
                                    to_search: to_search,
                                    time: setup_time,
                                    date: setup_date,
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
            ),
            SizedBox(
              height: Scaler.heightDeScalingCustom(context, 0.05, 0.03),
            ),
            Card(
              color: theme.cardColor,
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0)
              ),
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
                        Icon(Icons.add_alert, color: theme.titleColor, size: 30),
                        SizedBox(width: 5),
                        Text(
                          "Unsere Tipps",
                          style: TextStyle(
                              color: theme.titleColor,
                              fontSize: 30,
                              fontFamily: 'NunitoSansBold',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.10,
                      child: Swiper(
                        autoplay: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                              child: Text(
                                  showSuggestions()[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: theme.textColor,
                                    fontFamily: 'NunitoSansBold',
                                  ),
                              )
                          );
                        },
                        itemCount: 4,
                        viewportFraction: 1.0,
                        scale: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<String> showSuggestions() {
    return [
      "Buchen sie so frühzeitig wie möglich Ihre Fahrt !",
      "Planen sie von Haustür zur Haustür, ist der Fernbus da wirklich günstiger ?",
      "Die Umstiege können den Preis beeinflussen.",
      "Planen sie Staus und Verspätungen mit ein."
    ];
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
      lastDate: new DateTime(2021),
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
