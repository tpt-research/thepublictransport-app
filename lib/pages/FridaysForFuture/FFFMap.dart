import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:morpheus/morpheus.dart';
import 'package:thepublictransport_app/backend/models/fridaysforfuture/FridaysForFutureModel.dart';
import 'package:thepublictransport_app/backend/models/fridaysforfuture/Message.dart';
import 'package:thepublictransport_app/backend/service/core/CoreService.dart';
import 'package:thepublictransport_app/backend/service/fridaysforfuture/FridaysForFutureService.dart';
import 'package:thepublictransport_app/framework/language/GlobalTranslations.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/pages/FridaysForFuture/FFFSearchTrip.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class FFFMap extends StatefulWidget {
  @override
  _FFFMapState createState() => _FFFMapState();
}

class _FFFMapState extends State<FFFMap> {

  Completer<GoogleMapController> _controller = Completer();
  Geolocator geolocator = Geolocator();
  Set<Marker> markers = Set();
  CameraPosition position = _kInitialPosition;

  @override
  void initState() {
    super.initState();
    _showMessage();
  }

  var theme = ThemeEngine.getCurrentTheme();

  static final CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(37.422, -122.084),
    zoom: 17.0,
  );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "HEROOOO2",
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: theme.floatingActionButtonColor,
        child: Icon(Icons.arrow_back, color: theme.floatingActionButtonIconColor),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            compassEnabled: false,
            mapToolbarEnabled: false,
            initialCameraPosition: _kInitialPosition,
            onMapCreated: _onMapCreated,
            rotateGesturesEnabled: false,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            tiltGesturesEnabled: false,
            trafficEnabled: true,
            mapType: theme.status == "light" ? MapType.normal : MapType.hybrid,
            markers: markers,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(5, MediaQuery.of(context).padding.top + 10, 5, 0),
            child: Card(
              color: theme.backgroundColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
              ),
              child: TypeAheadField(
                suggestionsBoxDecoration: SuggestionsBoxDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                  ),
                ),
                textFieldConfiguration: TextFieldConfiguration(
                    autofocus: false,
                    autocorrect: true,
                    style: TextStyle(
                        fontSize: 18,
                        color: theme.textColor
                    ),
                    decoration: InputDecoration(
                      hintText: allTranslations.text('VEHICLEMAP.SEARCH'),
                      hintStyle: TextStyle(
                          color: theme.textColor
                      ),
                      alignLabelWithHint: true,
                      prefixIcon: Icon(
                        Icons.search,
                        color: theme.iconColor,
                      ),
                      suffixIcon: Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                        child: ClipOval(
                          child: Material(
                            color: Colors.green, // button color
                            child: InkWell(
                              splashColor: theme.iconColor, // inkwell color
                              child: SizedBox(width: 20, height: 20, child: Icon(MaterialCommunityIcons.tree, color: theme.backgroundColor)),
                              onTap: () {},
                            ),
                          ),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      border: InputBorder.none,
                      fillColor: Colors.transparent,
                    )
                ),
                suggestionsCallback: (pattern) async {
                  return await getResults(pattern);
                },
                itemBuilder: (context, Message suggestion) {
                  return Container(
                    color: theme.foregroundColor,
                    child: ListTile(
                      leading: Icon(Icons.location_on, color: theme.iconColor),
                      title: Text(
                        suggestion.name + " - " + suggestion.startpunkt,
                        style: TextStyle(
                            color: theme.textColor
                        ),
                      ),
                    ),
                  );
                },
                onSuggestionSelected: (Message suggestion) async {
                  var controller = await _controller.future;

                  controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(
                      double.parse(suggestion.lang),
                      double.parse(suggestion.lat),
                  ), 10));
                },
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).padding.top,
            color: Colors.black.withAlpha(120),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _controller.complete(controller);
    });

    var coordinates = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best, locationPermissionLevel: GeolocationPermission.location);

    controller.moveCamera(CameraUpdate.newLatLngZoom(
        LatLng(coordinates.latitude, coordinates.longitude), 15
    ));

    getLocations(coordinates);
  }

  Future <BitmapDescriptor> _createMarkerImageFromAssetFFF() async {
    ImageConfiguration configuration = ImageConfiguration(
        size: Size(170, 170),
        devicePixelRatio: MediaQuery.of(context).devicePixelRatio
    );
    var bitmapImage = await BitmapDescriptor.fromAssetImage(
        configuration,'icons/marker_fff.png');
    return bitmapImage;
  }

  getLocations(Position coordinates) async {
      FridaysForFutureModel fff = await _fetchFFF();
      var logo = await _createMarkerImageFromAssetFFF();
      print(fff);

      for (var i in fff.message) {
        markers.add(Marker(
          icon: logo,
          markerId: MarkerId(i.name),
          position: LatLng(
              double.parse(i.lang),
              double.parse(i.lat),
          ),
          infoWindow: InfoWindow(
            title: i.startpunkt + " - " + i.uhrzeit,
            snippet: i.name,
            onTap: () async {
              Toast.show("Haben sie kurz Geduld. :)", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
              var location = await CoreService.getLocationNearbyAlternativeCoord(double.parse(i.lang), double.parse(i.lat), 1.toString(), "DB");
              var current = await CoreService.getLocationNearbyAlternativeCoord(coordinates.latitude, coordinates.longitude, 1.toString(), "DB");

              Navigator.of(context).push(MorpheusPageRoute(builder: (context) => FFFSearchTrip(
                  new_search: current.suggestedLocations.first,
                  new_search2: location.suggestedLocations.first
              )));
            },
          ),
        ));
      }
      setState((){});
  }

  Future<FridaysForFutureModel> _fetchFFF() async {
    final fff = await FridaysForFutureService.getFFF();

    return fff;
  }

  Future<List<Message>> getResults(String query) async {
    var result = await FridaysForFutureService.getFFFSearch("Name", query);

    return result.message;
  }

  void _showMessage() async {
    // flutter defined function
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0)
          ),
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.network('https://avatars3.githubusercontent.com/u/44241397')
              ),
              SizedBox(
                  width: 30,
                  child: Text("+",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25
                    ),
                  ),
              ),
              SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.network('https://avatars2.githubusercontent.com/u/4403253')
              ),
            ],
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.90,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Text(
                  "Dies ist durch eine Zusammenarbeit mit ride2Go entstanden.",
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Gemeinsam möchten wir den Demonstranten von Fridays for Future helfen zu ihrem Demonstrationstandort zu kommen.",
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Ride2Go ist ein Fahrgemeinschaften Portal, was euch dabei hilft einerseits CO2 einzusparen durch Mitnahme anderer Personen, aber auch den Geldbeutel schont.",
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Dabei beziehen sich diese Fahrgemeinschaften nicht nur auf Autos, sondern auch auf Züge und andere Verkehrsmittel. Ergo könnt ihr durch Ride2Go auch andere mit auf eure Zugreise mitnehmen.",
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Wir würden uns freuen wenn ihr mal vorbei schaut !",
                  style: TextStyle(
                      color: Colors.black
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                allTranslations.text('GENERAL.CLOSE'),
                style: TextStyle(
                    color: Colors.black
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(
                "Zeig mir mehr!",
                style: TextStyle(
                    color: Colors.black
                ),
              ),
              onPressed: () {
                showRide2Go();
              },
            ),
          ],
        );
      },
    );
  }

  showRide2Go() async {
    var url = 'https://live.ride2go.com/#/embed/fff/de';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
