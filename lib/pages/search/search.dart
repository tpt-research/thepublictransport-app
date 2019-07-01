import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:desiredrive_api_flutter/models/rmv/rmv_query.dart';
import 'package:desiredrive_api_flutter/service/geocode/geocode.dart';
import 'package:desiredrive_api_flutter/service/rmv/rmv_query_request.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:preferences/preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:thepublictransport_app/pages/input/input_screen.dart';
import 'package:thepublictransport_app/pages/misc/about.dart';
import 'package:thepublictransport_app/pages/misc/settings.dart';
import 'package:thepublictransport_app/pages/nearby/nearby.dart';
import 'package:thepublictransport_app/pages/search/search_result.dart';
import 'package:thepublictransport_app/ui/animations/showup.dart';
import 'package:thepublictransport_app/ui/colors/color_theme_engine.dart';
import 'package:thepublictransport_app/ui/components/optionswitch.dart';
import 'package:thepublictransport_app/ui/components/searchbar.dart';
import 'package:thepublictransport_app/ui/components/searchbar_dummy.dart';
import 'package:thepublictransport_app/ui/components/shortcut_button.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class SearchWidget extends StatefulWidget {
  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {
  bool showFab = false;
  bool showSearchbar = true;
  bool setStateOnce = false;
  bool searchExpandedDefault = false;
  bool overscrollGestured = false;
  bool isLoaded = true;

  RMVQueryModel from;
  RMVQueryModel to;

  String datestring;
  String datestring_rmv;
  String timestring;
  String timestring_rmv;

  Set<Marker> markers = {};

  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(48.0),
    topRight: Radius.circular(48.0),
  );

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController cachedController;

  DesireDriveGeocode geocode = new DesireDriveGeocode();

  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();
  final PanelController panelController = new PanelController();

  static final CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(50.1287204, 8.6295871),
    zoom: 17.0,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: _innerDrawerKey,
      position: InnerDrawerPosition.end,
      // required
      onTapClose: true,
      // default false
      swipe: false,
      // default true
      offset: 0.6,
      // default 0.4
      colorTransition: Colors.black45,
      // default Color.black54
      animationType: InnerDrawerAnimation.quadratic,
      // default static
      innerDrawerCallback: (a) => print(a),
      child: Scaffold(
        backgroundColor: ColorThemeEngine.backgroundColor,
        body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  InkWell(
                    child: ListTile(
                      leading: new Icon(OMIcons.home,
                          color: ColorThemeEngine.iconColor),
                      title: new Text(
                        "Startseite",
                        style: new TextStyle(
                            color: ColorThemeEngine.textColor,
                            fontFamily: 'Nunito'),
                      ),
                    ),
                    onTap: () {
                      _innerDrawerKey.currentState.close();
                      setState(() {});
                    },
                  ),
                  InkWell(
                    child: ListTile(
                      leading: new Icon(OMIcons.settings,
                          color: ColorThemeEngine.iconColor),
                      title: new Text(
                        "Einstellungen",
                        style: new TextStyle(
                            color: ColorThemeEngine.textColor,
                            fontFamily: 'Nunito'),
                      ),
                    ),
                    onTap: () async {
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SettingsWidget()));
                    },
                  )
                ],
              ),
              ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  InkWell(
                    child: ListTile(
                      leading: new Icon(OMIcons.info,
                          color: ColorThemeEngine.iconColor),
                      title: new Text(
                        "Über die App",
                        style: new TextStyle(
                            color: ColorThemeEngine.textColor,
                            fontFamily: 'Nunito'),
                      ),
                    ),
                    onTap: () async {
                      await Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AboutPage()));
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 20))
                ],
              )
            ],
          ),
        ),
      ),
      scaffold: new Scaffold(
        floatingActionButton: AnimatedOpacity(
            opacity: showFab ? 1.0 : 0.0,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInSine,
            child: CircularGradientButton(
                gradient: ColorThemeEngine.tptgradient,
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                callback: () {
                  if (showFab) _innerDrawerKey.currentState.open();
                })),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: SlidingUpPanel(
          controller: panelController,
          borderRadius: radius,
          parallaxEnabled: true,
          parallaxOffset: .5,
          minHeight: MediaQuery.of(context).size.height * 0.35,
          maxHeight: MediaQuery.of(context).size.height * 0.80,
          backdropEnabled: true,
          onPanelSlide: (value) {
            if (value < 0.5)
              showFab = false;
            else
              showFab = true;
          },
          onPanelClosed: () {
            setState(() {});
          },
          onPanelOpened: () {
            setState(() {});
          },
          collapsed: Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: BoxDecoration(
              color: ColorThemeEngine.backgroundColor,
              borderRadius: radius,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 25,
                ),
                new Text(
                  "Guten Tag!",
                  style: new TextStyle(
                      fontFamily: 'NunitoBold',
                      fontSize: 40,
                      color: ColorThemeEngine.textColor),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
                new SizedBox(
                  height: 45,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new ShortcutButton(
                      title: "Station in der Nähe",
                      icon: Icons.my_location,
                      backgroundColor: Colors.red,
                      onTap: () async {
                        var controller;
                        if (cachedController == null) {
                          controller = await _controller.future;
                          cachedController = controller;
                        } else {
                          controller = cachedController;
                        }

                        if (markers.first != null) {
                          controller.animateCamera(CameraUpdate.newLatLngZoom(
                              LatLng(markers.first.position.latitude,
                                  markers.first.position.longitude),
                              18));
                        }
                      },
                    ),
                    new ShortcutButton(
                      title: "Letzte Suche",
                      icon: Icons.refresh,
                      backgroundColor: Colors.blue,
                    ),
                    new ShortcutButton(
                      title: "Fahrt bewerten",
                      icon: Icons.record_voice_over,
                      backgroundColor: Colors.green,
                    ),
                    new ShortcutButton(
                      title: "Einstellungen",
                      icon: Icons.settings,
                      backgroundColor: Colors.orange,
                      onTap: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SettingsWidget()));
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          panel: Container(
            decoration: BoxDecoration(
              color: ColorThemeEngine.backgroundColor,
              borderRadius: radius,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
                new SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: FadeAnimatedTextKit(
                        duration: Duration(seconds: 20),
                        onTap: () {
                          print("Tap Event");
                        },
                        text: [
                          "Wie kann ich behilflich sein ?",
                          "Wohin zieht es dich ?",
                          "Möchtest du reisen ?"
                        ],
                        textStyle: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.purple,
                            fontFamily: 'NunitoBold'),
                        textAlign: TextAlign.center,
                        alignment:
                            AlignmentDirectional.center // or Alignment.topLeft
                        ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      if (overscroll.leading) {
                        if (overscrollGestured) {
                          panelController.close();
                          overscrollGestured = false;
                        } else {
                          overscrollGestured = true;
                        }
                      }

                      overscroll.disallowGlow();
                    },
                    child: new ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        new Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: new Card(
                            shape: new RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(36.0),
                                side: ColorThemeEngine.decideBorderSide()),
                            elevation: 10,
                            child: new Column(
                              children: <Widget>[
                                ExpandablePanel(
                                  headerAlignment:
                                      ExpandablePanelHeaderAlignment.center,
                                  tapHeaderToExpand: true,
                                  hasIcon: ColorThemeEngine.theme == "light"
                                      ? true
                                      : false,
                                  initialExpanded: true,
                                  header: Container(
                                    alignment: Alignment.centerLeft,
                                    color: ColorThemeEngine.backgroundColor,
                                    padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                                    child: Container(
                                      child: Row(
                                        children: <Widget>[
                                          new Icon(
                                            Icons.search,
                                            size: 40,
                                            color: ColorThemeEngine.iconColor,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          new Text(
                                            "Suche",
                                            style: new TextStyle(
                                                fontSize: 25,
                                                fontFamily: 'NunitoSemiBold',
                                                color:
                                                    ColorThemeEngine.textColor),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  expanded: Container(
                                    color: ColorThemeEngine.backgroundColor,
                                    child: new Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(left: 20),
                                          child: new Timeline(
                                            children: _createSearchbar(),
                                            iconSize: 3,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            position: TimelinePosition.Left,
                                            lineColor:
                                                ColorThemeEngine.iconColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            new Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                new Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      20, 10, 9, 0),
                                                  child: new GradientButton(
                                                      increaseWidthBy: 30,
                                                      gradient: ColorThemeEngine
                                                          .tptfabgradient,
                                                      child: new Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        child: new Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            new Icon(
                                                                Icons
                                                                    .calendar_today,
                                                                size: 20),
                                                            new Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 7),
                                                              child: new Text(
                                                                decideDateString(),
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Roboto'),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      callback: () {
                                                        _selectDate();
                                                      }),
                                                ),
                                                new Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 10, 12, 0),
                                                  child: new GradientButton(
                                                      gradient: ColorThemeEngine
                                                          .tptfabgradient,
                                                      child: new Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        child: new Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            new Icon(Icons
                                                                .access_time),
                                                            new Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 7),
                                                              child: new Text(
                                                                decideTimeString(),
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Roboto'),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      callback: () {
                                                        _selectTime();
                                                      }),
                                                ),
                                              ],
                                            ),
                                            new Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  23, 20, 0, 0),
                                              alignment: Alignment.centerLeft,
                                              child: new OutlineButton(
                                                  highlightElevation: 0,
                                                  borderSide: new BorderSide(
                                                      style: BorderStyle.solid,
                                                      width: 2,
                                                      color: ColorThemeEngine
                                                          .textColor),
                                                  highlightedBorderColor:
                                                      ColorThemeEngine
                                                          .textColor,
                                                  child: Text('Optionen',
                                                      style: new TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 17,
                                                          color:
                                                              ColorThemeEngine
                                                                  .textColor)),
                                                  onPressed: () {
                                                    showOptions();
                                                  }),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            new Container(
                                              alignment: Alignment.bottomRight,
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 5, 27, 10),
                                              child: new CircularGradientButton(
                                                  gradient: ColorThemeEngine
                                                      .tptfabgradient,
                                                  child: new Icon(Icons.search),
                                                  callback: () async {
                                                    super.reassemble();
                                                    if (from == null) return;
                                                    if (to == null) return;
                                                    await Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                            builder: (context) =>
                                                                SearchResultPage(
                                                                  from: from,
                                                                  to: to,
                                                                  time:
                                                                      timestring_rmv,
                                                                  date:
                                                                      datestring_rmv,
                                                                  saveDrive:
                                                                      PrefService.getBool(
                                                                              "good_trips") ??
                                                                          false,
                                                                  wheelchair:
                                                                      PrefService.getBool(
                                                                              "wheelchair_mode") ??
                                                                          false,
                                                                  unsharp: PrefService
                                                                          .getBool(
                                                                              "unsharp_mode") ??
                                                                      false,
                                                                  arrival: PrefService
                                                                          .getBool(
                                                                              "arrival_mode") ??
                                                                      false,
                                                                  past: PrefService
                                                                          .getBool(
                                                                              "past_trips") ??
                                                                      false,
                                                                  bike_carriage:
                                                                      PrefService.getBool(
                                                                              "bike_mode") ??
                                                                          false,
                                                                  bitmask: null,
                                                                )));
                                                    setState(() {});
                                                  }),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                new GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: _kInitialPosition,
                  onMapCreated: _onMapCreated,
                  rotateGesturesEnabled: false,
                  scrollGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                  zoomGesturesEnabled: true,
                  mapType: ColorThemeEngine.theme == "dark"
                      ? MapType.hybrid
                      : MapType.normal,
                  markers: markers,
                  onCameraMove: (position) {
                    showSearchbar = false;
                    if (!setStateOnce) {
                      setState(() {});
                      setStateOnce = true;
                    }
                  },
                  onCameraIdle: () {
                    showSearchbar = true;
                    setStateOnce = false;
                    setState(() {});
                  },
                ),
                AnimatedOpacity(
                  opacity: showSearchbar ? 1.0 : 0.3,
                  duration: Duration(milliseconds: 300),
                  child: Container(
                      alignment: Alignment.topCenter,
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      color: Colors.transparent,
                      padding: EdgeInsets.fromLTRB(
                          0, MediaQuery.of(context).size.height * 0.04, 0, 0),
                      child: SearchbarDummy(
                        text: "Suche nach Haltestellen...",
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => InputScreen(
                                  title: "Haltestellen in der Nähe",
                                  mode: 0,
                                  isNearby: true)));
                        },
                      )),
                ),
                new Visibility(
                    visible: isLoaded,
                    child: new Container(
                        padding: EdgeInsets.only(bottom: 80),
                        color: ColorThemeEngine.iconColor.withAlpha(80),
                        child: new Center(
                            child: new SpinKitChasingDots(
                          size: 80,
                          color: ColorThemeEngine.backgroundColor,
                        ))))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _controller.complete(controller);
    });

    cachedController = controller;

    controller.moveCamera(CameraUpdate.newLatLng(
        LatLng(await geocode.latitude(), await geocode.longitude())));
    _setMarkers(controller);
  }

  _setMarkers(GoogleMapController controller) async {
    List<RMVQueryModel> marks = await RMVQueryRequest.getNearestStations(
        await geocode.latitude(), await geocode.longitude(), 10);

    for (var i in marks) {
      markers.add(Marker(
        markerId: MarkerId(i.extID),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
        position: LatLng(i.lat, i.lon),
        infoWindow: InfoWindow(
            title: i.name,
            snippet: "Haltestelle",
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NearbySearchResultPage(i)));
            }),
      ));
    }

    isLoaded = false;

    setState(() {});
  }

  Future<RMVQueryModel> _getNearestStation() async {
    return await RMVQueryRequest.getMostRelevantAndNearestStation(
        await geocode.latitude(), await geocode.longitude());
  }

  List<TimelineModel> _createSearchbar() {
    return [
      TimelineModel(
          Container(
            padding: EdgeInsets.only(left: 30),
            child: Searchbar(
              text: decideSearchbarString("Start", 1),
              onTap: () {
                _navigateAndDisplaySelection(context, "Start", 1);
              },
              onButtonPressed: () async {
                if (markers.first != null) {
                  from = await RMVQueryRequest.getMostRelevantAndNearestStation(
                      await geocode.latitude(), await geocode.longitude());
                } else {
                  from = await RMVQueryRequest.getMostRelevantAndNearestStation(
                      markers.first.position.latitude,
                      markers.first.position.longitude);
                }
                setState(() {});
              },
            ),
          ),
          position: TimelineItemPosition.left,
          iconBackground: ColorThemeEngine.iconColor,
          icon: Icon(Icons.arrow_drop_down, color: ColorThemeEngine.iconColor)),
      TimelineModel(
          SizedBox(
            height: 15,
          ),
          position: TimelineItemPosition.left,
          iconBackground: Colors.transparent,
          icon: Icon(Icons.arrow_drop_down, color: Colors.transparent)),
      TimelineModel(
          Container(
            padding: EdgeInsets.only(left: 30),
            child: Searchbar(
              text: decideSearchbarString("Ziel", 2),
              onTap: () {
                _navigateAndDisplaySelection(context, "Ziel", 2);
              },
              onButtonPressed: () async {
                if (markers.first != null) {
                  to = await RMVQueryRequest.getMostRelevantAndNearestStation(
                      await geocode.latitude(), await geocode.longitude());
                } else {
                  to = await RMVQueryRequest.getMostRelevantAndNearestStation(
                      markers.first.position.latitude,
                      markers.first.position.longitude);
                }
                setState(() {});
              },
            ),
          ),
          position: TimelineItemPosition.left,
          iconBackground: ColorThemeEngine.iconColor,
          icon: Icon(Icons.arrow_drop_down, color: ColorThemeEngine.iconColor)),
    ];
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
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
        datestring_rmv = picked.year.toString() +
            "-" +
            picked.month.toString().padLeft(2, '0') +
            "-" +
            picked.day.toString().padLeft(2, '0');
        datestring = picked.day.toString().padLeft(2, '0') +
            "." +
            picked.month.toString().padLeft(2, '0') +
            "." +
            picked.year.toString();
      });
  }

  Future _selectTime() async {
    TimeOfDay selectedTime24Hour = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 10, minute: 47),
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
        timestring_rmv = selectedTime24Hour.hour.toString().padLeft(2, '0') +
            ":" +
            selectedTime24Hour.minute.toString().padLeft(2, '0');
        timestring = selectedTime24Hour.hour.toString().padLeft(2, '0') +
            ":" +
            selectedTime24Hour.minute.toString().padLeft(2, '0');
      });
  }

  String decideDateString() {
    var now = DateTime.now();
    if (datestring != null) {
      return datestring;
    } else {
      datestring_rmv = now.year.toString() +
          "-" +
          now.month.toString().padLeft(2, '0') +
          "-" +
          now.day.toString().padLeft(2, '0');
      return now.day.toString().padLeft(2, '0') +
          "." +
          now.month.toString().padLeft(2, '0') +
          "." +
          now.year.toString();
    }
  }

  String decideTimeString() {
    var now = TimeOfDay.now();
    if (timestring != null) {
      return timestring;
    } else {
      timestring_rmv = now.hour.toString().padLeft(2, '0') +
          ":" +
          now.minute.toString().padLeft(2, '0');
      return now.hour.toString().padLeft(2, '0') +
          ":" +
          now.minute.toString().padLeft(2, '0');
    }
  }

  String decideSearchbarString(String previous, int mode) {
    String result;
    try {
      switch (mode) {
        case 1:
          result = from.name;
          break;
        case 2:
          result = to.name;
      }
    } catch (e) {
      result = previous;
    }

    print(result);
    return result;
  }

  showOptions() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          final ThemeData themeData = Theme.of(context);
          return Theme(
            data: themeData.copyWith(
              canvasColor: ColorThemeEngine.backgroundColor,
              backgroundColor: ColorThemeEngine.backgroundColor,
              primaryColor: ColorThemeEngine.textColor,
              accentColor: ColorThemeEngine.textColor,
            ),
            child: DecoratedBox(
              decoration:
                  BoxDecoration(color: ColorThemeEngine.backgroundColor),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22.0),
                    topRight: Radius.circular(22.0)),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                      child: new Text("Allgemein".toUpperCase(),
                          style: new TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: ColorThemeEngine.titleColor)),
                    ),
                    new OptionSwitch(
                      title: "Nach Ankunft suchen",
                      icon: Icons.location_on,
                      id: "arrival_mode",
                      default_bool: false,
                    ),
                    new OptionSwitch(
                      title: "Vorherige Routen anzeigen",
                      icon: Icons.arrow_back,
                      id: "past_trips",
                      default_bool: false,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                      child: new Text("Fahrrad".toUpperCase(),
                          style: new TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: ColorThemeEngine.titleColor)),
                    ),
                    new OptionSwitch(
                      title: "Routen für Fahrradmitnahme",
                      icon: Icons.directions_bike,
                      id: "bike_mode",
                      default_bool: false,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                      child: new Text("Barrierefreiheit".toUpperCase(),
                          style: new TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: ColorThemeEngine.titleColor)),
                    ),
                    new OptionSwitch(
                      title: "Barrierefreie Routen",
                      icon: Icons.accessible,
                      id: "wheelchair_mode",
                      default_bool: false,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                      child: new Text("Suchtools".toUpperCase(),
                          style: new TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: ColorThemeEngine.titleColor)),
                    ),
                    new OptionSwitch(
                      title: "Zuverlässigere Erreichbarkeit",
                      icon: Icons.access_time,
                      id: "good_trips",
                      default_bool: false,
                    ),
                    new OptionSwitch(
                      title: "Unschärfe Modus",
                      icon: Icons.location_searching,
                      id: "unsharp_mode",
                      default_bool: false,
                    ),
                    // SoonTM
                    /*Container(
                      padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                      child: new Text(
                          "Verkehrsmittel".toUpperCase(),
                          style: new TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: ColorThemeEngine.titleColor
                          )
                      ),
                    ),
                    new OptionSwitch(
                        title: "Fernzüge (ICE, IC, EC)",
                        icon: Icons.train,
                        id: "long_distance_trains",
                        default_bool: true,
                    ),
                    new OptionSwitch(
                        title: "Regionale Züge (RE, RB, etc.)",
                        icon: Icons.directions_railway,
                        id: "regional_trains",
                        default_bool: true,
                    ),
                    new OptionSwitch(
                        title: "Lokale Züge (S-Bahn, etc.)",
                        icon: Icons.directions_subway,
                        id: "local_trains",
                        default_bool: true,
                    ),
                    new OptionSwitch(
                        title: "Lokalverkehr (Bus, Straßenbahn, etc.)",
                        icon: Icons.directions_bus,
                        id: "local_vehicles",
                        default_bool: true,
                    ),*/
                  ],
                ),
              ),
            ),
          );
        });
  }

  _navigateAndDisplaySelection(
      BuildContext context, String title, int mode) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => InputScreen(
                title: title,
                mode: mode,
                isNearby: false,
              )),
    );

    if (result != null) {
      setState(() {
        switch (mode) {
          case 1:
            from = result;
            break;
          case 2:
            to = result;
            break;
          default:
            break;
        }
      });
    }
  }
}
