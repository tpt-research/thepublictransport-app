import 'dart:async';

import 'package:desiredrive_api_flutter/service/geocode/geocode.dart';
import 'package:desiredrive_api_flutter/service/rmv/rmv_query_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thepublictransport_app/pages/nearby/nearby.dart';
import 'package:thepublictransport_app/ui/base/tptscaffold.dart';
import 'package:thepublictransport_app/ui/colors/color_theme_engine.dart';

class InputScreen extends StatefulWidget {
  InputScreen(
      {@required this.title, @required this.mode, @required this.isNearby});

  final String title;
  final int mode;
  final bool isNearby;

  @override
  _InputScreenState createState() => _InputScreenState(title, mode, isNearby);
}

class _InputScreenState extends State<InputScreen> {
  _InputScreenState(this.title, this.mode, this.isNearby);

  final String title;
  final int mode;
  final bool isNearby;

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(50.1287204, 8.6295871),
    zoom: 17.0,
  );

  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(48.0),
    topRight: Radius.circular(48.0),
  );

  DesireDriveGeocode geocode = new DesireDriveGeocode();

  Set<Marker> markers = {};

  Widget build(BuildContext context) {
    return new TPTScaffold(
      title: title,
      keyboardFocusRemove: true,
      bodyIsExpanded: true,
      hasFab: true,
      body: new Stack(
        children: <Widget>[
          new GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            initialCameraPosition: _kInitialPosition,
            onMapCreated: _onMapCreated,
            rotateGesturesEnabled: false,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            zoomGesturesEnabled: true,
            mapType: ColorThemeEngine.theme == "dark"
                ? MapType.hybrid
                : MapType.normal,
            markers: markers,
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.13,
            alignment: Alignment.topCenter,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: ColorThemeEngine.decideBorderSide()),
              color: ColorThemeEngine.cardColor,
              child: Container(
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                      autofocus: true,
                      autocorrect: true,
                      textInputAction: TextInputAction.search,
                      style: new TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 35,
                        color: ColorThemeEngine.subtitleColor,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24.0)),
                            borderSide: ColorThemeEngine.decideBorderSide()),
                        labelText: "Suche",
                        labelStyle: new TextStyle(
                            color: ColorThemeEngine.textColor,
                            fontFamily: 'NunitoSemiBold'),
                      )),
                  suggestionsCallback: (pattern) async {
                    var models =
                        await RMVQueryRequest.getIntelligentStations(pattern);
                    var firstModel = models[0];
                    var controller = await _controller.future;

                    controller.animateCamera(CameraUpdate.newLatLng(
                        LatLng(firstModel.lat, firstModel.lon)));

                    return models;
                  },
                  itemBuilder: (context, suggestion) {
                    return Container(
                      color: ColorThemeEngine.backgroundColor,
                      child: ListTile(
                        leading: Icon(Icons.place,
                            color: ColorThemeEngine.iconColor),
                        title: Text(
                          suggestion.name,
                          style:
                              new TextStyle(color: ColorThemeEngine.textColor),
                        ),
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    if (suggestion.name != "Keine Ergebnisse") {
                      if (isNearby) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                NearbySearchResultPage(suggestion)));
                      } else {
                        Navigator.of(context).pop(suggestion);
                      }
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _controller.complete(controller);
    });
    controller.moveCamera(CameraUpdate.newLatLng(
        LatLng(await geocode.latitude(), await geocode.longitude())));
  }
}
