import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:preferences/preferences.dart';
import 'package:sliding_panel/sliding_panel.dart';
import 'package:thepublictransport_app/backend/models/main/SuggestedLocation.dart';
import 'package:thepublictransport_app/backend/service/core/CoreService.dart';
import 'package:thepublictransport_app/framework/language/GlobalTranslations.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/pages/Result/Result.dart';
import 'package:thepublictransport_app/ui/animations/ShowUp.dart';
import 'package:thepublictransport_app/ui/components/OptionSwitch.dart';

class SearchTrip extends StatefulWidget {
  @override
  _SearchTripState createState() => _SearchTripState();
}

class _SearchTripState extends State<SearchTrip> {
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
  Set<Polyline> polyline = Set();
  PanelController pc;

  bool accessibility = false;

  SuggestedLocation from_search;
  SuggestedLocation to_search;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light
    ));
    pc = PanelController();
    super.initState();
  }

  static final CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(37.422, -122.084),
    zoom: 17.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.status == "light" ? Colors.black : theme.cardColor,
      body: SlidingPanel(
        panelController: pc,
        isTwoStatePanel: true,
        snapPanel: true,
        parallaxSlideAmount: 0,
        curve: Curves.easeOutExpo,
        initialState: InitialPanelState.closed,
        size: PanelSize(
            expandedHeight: 0.6,
            closedHeight: 0.0
        ),
        content: PanelContent(
          headerWidget: PanelHeaderWidget(
            headerContent: Container(
              padding: const EdgeInsets.all(16.0),
              color: theme.backgroundColor,
              child: Text(
                allTranslations.text('SEARCH.OPTIONS'),
                style: TextStyle(
                  color: theme.titleColor,
                  fontFamily: "NunitoSansBold",
                  fontSize: Theme.of(context).textTheme.title.fontSize
                ),
              ),
            ),
          ),
          panelContent: (context, scrollController) {
            return showOptionsModal(context, scrollController);
          },
          bodyContent: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: theme.status == "light" ? Colors.black : theme.cardColor,
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
                                    hintText: allTranslations.text('SEARCH.START'),
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
                                    leading: Icon(Icons.location_on, color: theme.iconColor),
                                    title: Text(
                                      suggestion.location.name + (suggestion.location.place != null ? ", " + suggestion.location.place : ""),
                                      style: TextStyle(
                                          color: theme.textColor
                                      ),
                                    ),
                                  ),
                                );
                              },
                              onSuggestionSelected: (SuggestedLocation suggestion) async {
                                BitmapDescriptor pic = await _createMarkerImageFromAsset();
                                from_search = suggestion;
                                _typeAheadControllerStart.text = suggestion.location.name + (suggestion.location.place != null ? ", " + suggestion.location.place : "");

                                var controller = await _controller.future;

                                markers.add(Marker(
                                  icon: pic,
                                  markerId: MarkerId(suggestion.location.id),
                                  position: LatLng(
                                    suggestion.location.latAsDouble,
                                    suggestion.location.lonAsDouble,
                                  ),

                                  infoWindow: InfoWindow(
                                    title: suggestion.location.name,
                                  ),
                                ));

                                if (to_search != null) {
                                  polyline = Set();
                                  polyline.add(Polyline(
                                    polylineId: PolylineId('Line'),
                                    visible: true,
                                    //latlng is List<LatLng>
                                    points: [
                                      LatLng(from_search.location.latAsDouble, from_search.location.lonAsDouble),
                                      LatLng(to_search.location.latAsDouble, to_search.location.lonAsDouble),
                                    ],
                                    width: 2,
                                    color: Colors.red,
                                  ));
                                  controller.moveCamera(CameraUpdate.newLatLngZoom(
                                      LatLng(suggestion.location.latAsDouble, suggestion.location.lonAsDouble), 10
                                  ));
                                } else {
                                  controller.moveCamera(CameraUpdate.newLatLngZoom(
                                      LatLng(suggestion.location.latAsDouble, suggestion.location.lonAsDouble), 15
                                  ));
                                }
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
                                    hintText: allTranslations.text('SEARCH.END'),
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
                                    leading: Icon(Icons.location_on, color: theme.iconColor),
                                    title: Text(
                                      suggestion.location.name + (suggestion.location.place != null ? ", " + suggestion.location.place : ""),
                                      style: TextStyle(
                                          color: theme.textColor
                                      ),
                                    ),
                                  ),
                                );
                              },
                              onSuggestionSelected: (SuggestedLocation suggestion) async {
                                BitmapDescriptor pic = await _createMarkerImageFromAsset();
                                to_search = suggestion;
                                _typeAheadControllerEnd.text = suggestion.location.name + (suggestion.location.place != null ? ", " + suggestion.location.place : "");

                                var controller = await _controller.future;

                                markers.add(Marker(
                                  icon: pic,
                                  markerId: MarkerId(suggestion.location.id),
                                  position: LatLng(
                                    suggestion.location.latAsDouble,
                                    suggestion.location.lonAsDouble,
                                  ),

                                  infoWindow: InfoWindow(
                                    title: suggestion.location.name,
                                  ),
                                ));

                                if (from_search != null) {
                                  polyline = Set();
                                  polyline.add(Polyline(
                                    polylineId: PolylineId('Line'),
                                    visible: true,
                                    //latlng is List<LatLng>
                                    points: [
                                      LatLng(from_search.location.latAsDouble, from_search.location.lonAsDouble),
                                      LatLng(to_search.location.latAsDouble, to_search.location.lonAsDouble),
                                    ],
                                    width: 2,
                                    color: Colors.red,
                                  ));

                                  controller.moveCamera(CameraUpdate.newLatLngZoom(
                                      LatLng(suggestion.location.latAsDouble, suggestion.location.lonAsDouble), 10
                                  ));
                                } else {
                                  controller.moveCamera(CameraUpdate.newLatLngZoom(
                                      LatLng(suggestion.location.latAsDouble, suggestion.location.lonAsDouble), 15
                                  ));
                                }


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
                        Container(
                          padding: EdgeInsets.fromLTRB(7, 10, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              OutlineButton(
                                onPressed: () {
                                  pc.expand();
                                },
                                borderSide: BorderSide(color: Colors.white, width: 1.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Colors.transparent,
                                child: Text(
                                  allTranslations.text('SEARCH.OPTIONS'),
                                  style: TextStyle(
                                      color: Colors.white
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
                        polylines: polyline,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top + MediaQuery.of(context).size.height * 0.305, 25, 0),
                child: FloatingActionButton(
                  onPressed: () async {
                    if (from_search == null) return;
                    if (to_search == null) return;
                    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Result(
                      from_search: from_search,
                      to_search: to_search,
                      time: setup_time,
                      date: setup_date,
                      barrier: PrefService.getBool("wheelchair_mode") ?? false,
                      fastroute: PrefService.getBool("fast_mode") ?? false,
                      slowwalk: PrefService.getBool("walk_mode") ?? false,
                      products: generateLimterString(),
                    )));

                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                      systemNavigationBarColor: Colors.blueAccent,
                      statusBarColor: Colors.transparent, // status bar color
                      statusBarBrightness: Brightness.light,
                      statusBarIconBrightness: Brightness.light,
                    ));
                  },
                  heroTag: "HEROOOO",
                  backgroundColor: theme.foregroundColor,
                  child: Icon(Icons.search, color: theme.iconColor),
                ),
              )
            ],
          ),
        ),
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

  Future <BitmapDescriptor> _createMarkerImageFromAsset() async {
    ImageConfiguration configuration = ImageConfiguration(
        size: Size(170, 170),
        devicePixelRatio: MediaQuery.of(context).devicePixelRatio
    );
    var bitmapImage = await BitmapDescriptor.fromAssetImage(
        configuration,'icons/marker.png');
    return bitmapImage;
  }

  Future<List<SuggestedLocation>> getResults(String query) async {
    var result = await CoreService.getLocationQuery(query, "STATION", PrefService.getBool("datasave_mode") == false ? 10.toString() : 5.toString(), PrefService.getString('public_transport_data'));

    return result.suggestedLocations;
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

  Widget showOptionsModal(BuildContext context, ScrollController controller) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: ListView(
        controller: controller,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          new OptionSwitch(
            title: allTranslations.text('SEARCH.SETTINGS.ACCESSIBILITY'),
            icon: Icons.accessible,
            id: "wheelchair_mode",
            default_bool: false,
          ),
          new OptionSwitch(
            title: allTranslations.text('SEARCH.SETTINGS.FAST_TRAVEL'),
            icon: Icons.fast_forward,
            id: "fast_mode",
            default_bool: true,
          ),
          new OptionSwitch(
            title: allTranslations.text('SEARCH.SETTINGS.LONG_WALK'),
            icon: Icons.directions_walk,
            id: "walk_mode",
            default_bool: false,
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              allTranslations.text('SEARCH.SETTINGS.VEHICLES.TITLE'),
              style: TextStyle(
                  fontFamily: 'NunitoSansBold',
                  color: Colors.grey
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          new OptionSwitch(
            title: allTranslations.text('SEARCH.SETTINGS.VEHICLES.HIGH_SPEED_TRAIN'),
            icon: MaterialCommunityIcons.train,
            id: "high_speed_train_mode",
            default_bool: true,
          ),
          new OptionSwitch(
            title: allTranslations.text('SEARCH.SETTINGS.VEHICLES.REGIONAL_TRAIN'),
            icon: MaterialCommunityIcons.train_variant,
            id: "regional_train_mode",
            default_bool: true,
          ),
          new OptionSwitch(
            title: allTranslations.text('SEARCH.SETTINGS.VEHICLES.SUBURBAN_TRAIN'),
            icon: MaterialCommunityIcons.subway_variant,
            id: "suburban_train_mode",
            default_bool: true,
          ),
          new OptionSwitch(
            title: allTranslations.text('SEARCH.SETTINGS.VEHICLES.SUBWAY'),
            icon: MaterialCommunityIcons.subway,
            id: "subway_mode",
            default_bool: true,
          ),
          new OptionSwitch(
            title: allTranslations.text('SEARCH.SETTINGS.VEHICLES.BUS'),
            icon: MaterialCommunityIcons.bus,
            id: "bus_mode",
            default_bool: true,
          ),
          new OptionSwitch(
            title: allTranslations.text('SEARCH.SETTINGS.VEHICLES.TRAM'),
            icon: MaterialCommunityIcons.tram,
            id: "tram_mode",
            default_bool: true,
          ),
          new OptionSwitch(
            title: allTranslations.text('SEARCH.SETTINGS.VEHICLES.FERRY'),
            icon: MaterialCommunityIcons.ferry,
            id: "ferry_mode",
            default_bool: true,
          ),
          new OptionSwitch(
            title: allTranslations.text('SEARCH.SETTINGS.VEHICLES.ONDEMAND'),
            icon: MaterialCommunityIcons.train_car,
            id: "ondemand_mode",
            default_bool: true,
          ),
        ],
      ),
    );
  }

  String generateLimterString() {
    String generated = "";

    if (PrefService.getBool("high_speed_train_mode") == null
        || PrefService.getBool("high_speed_train_mode") == true) {

      generated += "HIGH_SPEED_TRAIN,";
    }
    if (PrefService.getBool("regional_train_mode") == null
        || PrefService.getBool("regional_train_mode") == true) {

      generated += "REGIONAL_TRAIN,";
    }
    if (PrefService.getBool("suburban_train_mode") == null
        || PrefService.getBool("suburban_train_mode") == true) {

      generated += "SUBURBAN_TRAIN,";
    }
    if (PrefService.getBool("subway_mode") == null
        || PrefService.getBool("subway_mode") == true) {

      generated += "SUBWAY,";
    }
    if (PrefService.getBool("bus_mode") == null
        || PrefService.getBool("bus_mode") == true) {

      generated += "BUS,";
    }
    if (PrefService.getBool("tram_mode") == null
        || PrefService.getBool("tram_mode") == true) {

      generated += "TRAM,";
    }
    if (PrefService.getBool("ferry_mode") == null
        || PrefService.getBool("ferry_mode") == true) {

      generated += "FERRY,";
    }
    if (PrefService.getBool("ondemand_mode") == null
        || PrefService.getBool("ondemand_mode") == true) {

      generated += "ON_DEMAND";
    }

    if (generated == "") {
      generated += "HIGH_SPEED_TRAIN,";
      generated += "REGIONAL_TRAIN,";
      generated += "SUBURBAN_TRAIN,";
      generated += "SUBWAY,";
      generated += "BUS,";
      generated += "TRAM,";
      generated += "FERRY,";
      generated += "ON_DEMAND";
    }

    return generated;
  }
}