import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:preferences/preferences.dart';
import 'package:thepublictransport_app/backend/models/flixbus/QueryResult.dart';
import 'package:thepublictransport_app/backend/service/flixbus/FlixbusService.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/ui/animations/ShowUp.dart';

import 'FlixbusResult.dart';

class FlixbusSearch extends StatefulWidget {
  @override
  _FlixbusSearchState createState() => _FlixbusSearchState();
}

class _FlixbusSearchState extends State<FlixbusSearch> {
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(36.0),
    topRight: Radius.circular(36.0),
  );

  var theme = ThemeEngine.getCurrentTheme();

  TimeOfDay setup_time = new TimeOfDay.now();
  DateTime setup_date = new DateTime.now();

  TextEditingController _typeAheadControllerStart = TextEditingController();
  TextEditingController _typeAheadControllerEnd = TextEditingController();

  Completer<GoogleMapController> _controller = Completer();
  Geolocator geolocator = Geolocator();
  Set<Marker> markers = Set();

  QueryResult from_search;
  QueryResult to_search;

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

  static final CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(37.422, -122.084),
    zoom: 17.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightGreen,
        floatingActionButton: FloatingActionButton(
          heroTag: "HEROOOO",
          onPressed: () {
            Navigator.of(context).pop();
          },
          backgroundColor: theme.floatingActionButtonColor,
          child: Icon(Icons.arrow_back, color: theme.floatingActionButtonIconColor),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.lightGreen,
                  ),
                  height: MediaQuery.of(context).padding.top + MediaQuery.of(context).size.height * 0.34,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(5, MediaQuery.of(context).padding.top + 10, 5, 0),
                        child: Card(
                          color: theme.backgroundColor,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)
                          ),
                          child: TypeAheadFormField(
                            suggestionsBoxDecoration: SuggestionsBoxDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)
                              ),
                            ),
                            textFieldConfiguration: TextFieldConfiguration(
                                controller: _typeAheadControllerStart,
                                autofocus: false,
                                autocorrect: true,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: theme.textColor
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Start',
                                  hintStyle: TextStyle(
                                      color: theme.textColor
                                  ),
                                  alignLabelWithHint: true,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: theme.iconColor,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                  border: InputBorder.none,
                                  fillColor: Colors.transparent,
                                )
                            ),
                            suggestionsCallback: (pattern) async {
                              return await getResults(pattern);
                            },
                            itemBuilder: (context, suggestion) {
                              return Container(
                                color: theme.foregroundColor,
                                child: ListTile(
                                  leading: Icon(Icons.directions_bus, color: theme.iconColor),
                                  title: Text(
                                    suggestion.name,
                                    style: TextStyle(
                                        color: theme.textColor
                                    ),
                                  ),
                                ),
                              );
                            },
                            onSuggestionSelected: (QueryResult suggestion) async {
                              from_search = suggestion;
                              _typeAheadControllerStart.text = suggestion.name;
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        child: Card(
                          color: theme.backgroundColor,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)
                          ),
                          child: TypeAheadFormField(
                            suggestionsBoxDecoration: SuggestionsBoxDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)
                              ),
                            ),
                            textFieldConfiguration: TextFieldConfiguration(
                                controller: _typeAheadControllerEnd,
                                autofocus: false,
                                autocorrect: true,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: theme.textColor
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Ziel',
                                  hintStyle: TextStyle(
                                      color: theme.textColor
                                  ),
                                  alignLabelWithHint: true,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: theme.iconColor,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                  border: InputBorder.none,
                                  fillColor: Colors.transparent,
                                )
                            ),
                            suggestionsCallback: (pattern) async {
                              return await getResults(pattern);
                            },
                            itemBuilder: (context, suggestion) {
                              return Container(
                                color: theme.foregroundColor,
                                child: ListTile(
                                  leading: Icon(Icons.directions_bus, color: theme.iconColor),
                                  title: Text(
                                    suggestion.name,
                                    style: TextStyle(
                                        color: theme.textColor
                                    ),
                                  ),
                                ),
                              );
                            },
                            onSuggestionSelected: (QueryResult suggestion) async {
                              to_search = suggestion;
                              _typeAheadControllerEnd.text = suggestion.name;
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(7, 10, 7, 0),
                        child: Row(
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
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: ClipRRect(
                    borderRadius: radius,
                    child: GoogleMap(
                      myLocationEnabled: false,
                      initialCameraPosition: _kInitialPosition,
                      onMapCreated: _onMapCreated,
                      rotateGesturesEnabled: false,
                      scrollGesturesEnabled: true,
                      tiltGesturesEnabled: false,
                      zoomGesturesEnabled: true,
                      trafficEnabled: false,
                      mapType: theme.status == "light" ? MapType.normal : MapType.hybrid,
                      markers: markers,
                    ),
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top + MediaQuery.of(context).size.height * 0.305, 25, 0),
              child: FloatingActionButton(
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
            )
          ],
        )
    );
  }

  void _onMapCreated(GoogleMapController controller) async {

    // Avoid race conditions
    await Future.delayed(Duration(milliseconds: 1000));

    setState(() {
      _controller.complete(controller);
    });

    var coordinates = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        locationPermissionLevel: GeolocationPermission.location
    );

    controller.moveCamera(CameraUpdate.newLatLngZoom(
        LatLng(coordinates.latitude, coordinates.longitude), 15
    ));
  }

  Future<List<QueryResult>> getResults(String query) async {
    var result = await FlixbusService.getQuery(query, PrefService.getBool("datasave_mode") == false ? 8 : 4);

    return result.queryResult;
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
