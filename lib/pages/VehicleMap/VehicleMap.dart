import 'dart:async';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:preferences/preference_service.dart';
import 'package:sliding_panel/sliding_panel.dart';
import 'package:thepublictransport_app/backend/models/circ/CircModel.dart';
import 'package:thepublictransport_app/backend/models/main/SuggestedLocation.dart';
import 'package:thepublictransport_app/backend/models/nextbike/NextbikeModel.dart';
import 'package:thepublictransport_app/backend/models/tier/TierModel.dart';
import 'package:thepublictransport_app/backend/models/voi/VoiModel.dart';
import 'package:thepublictransport_app/backend/service/circ/CircService.dart';
import 'package:thepublictransport_app/backend/service/core/CoreService.dart';
import 'package:thepublictransport_app/backend/service/nextbike/NextbikeService.dart';
import 'package:thepublictransport_app/backend/service/tier/TierService.dart';
import 'package:thepublictransport_app/backend/service/voi/VoiService.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/ui/components/OptionSwitch.dart';
import 'package:thepublictransport_app/ui/components/OptionSwitchImage.dart';
import 'package:url_launcher/url_launcher.dart';

class VehicleMap extends StatefulWidget {
  @override
  _VehicleMapState createState() => _VehicleMapState();
}

class _VehicleMapState extends State<VehicleMap> {

  Completer<GoogleMapController> _controller = Completer();
  Geolocator geolocator = Geolocator();
  Set<Marker> markers = Set();
  Set<Marker> bikeMarkers = Set();
  Set<Marker> voiMarkers = Set();
  int limiter = 0;
  int incrementalWipe = 0;
  CameraPosition position = _kInitialPosition;
  List<VoiModel> voiCache = [];
  PanelController pc;

  @override
  void initState() {
    pc = PanelController();
    super.initState();
  }

  var theme = ThemeEngine.getCurrentTheme();

  static final CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(37.422, -122.084),
    zoom: 17.0,
  );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "HEROOOO2",
            onPressed: () {
              Navigator.of(context).pop();
            },
            backgroundColor: theme.floatingActionButtonColor,
            child: Icon(Icons.arrow_back, color: theme.floatingActionButtonIconColor),
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: "NOHERO",
            onPressed: () async {
             await pc.expand();
            },
            backgroundColor: theme.floatingActionButtonColor,
            child: Icon(Icons.settings, color: theme.floatingActionButtonIconColor),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                'Optionen',
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
              GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                compassEnabled: false,
                mapToolbarEnabled: false,
                initialCameraPosition: _kInitialPosition,
                onMapCreated: _onMapCreated,
                onCameraMove: _onMapMoved,
                onCameraIdle: onRefresh,
                rotateGesturesEnabled: false,
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                tiltGesturesEnabled: false,
                trafficEnabled: true,
                mapType: theme.status == "light" ? MapType.normal : MapType.hybrid,
                markers: generateMarkers(),
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
                          hintText: 'Suche nach Ort...',
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
                                color: Colors.blue, // button color
                                child: InkWell(
                                  splashColor: theme.iconColor, // inkwell color
                                  child: SizedBox(width: 20, height: 20, child: Icon(MaterialCommunityIcons.bike, color: theme.backgroundColor)),
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
                      markers = Set();
                      var controller = await _controller.future;

                      controller.animateCamera(CameraUpdate.newLatLng(LatLng(
                        suggestion.location.latAsDouble,
                        suggestion.location.lonAsDouble,
                      )));
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
        ),
      ),
    );
  }

  void _onMapMoved(CameraPosition pos) {
    setState(() {
      position = pos;
    });
  }

  void onRefresh() async {
    if (position == _kInitialPosition) {
      return;
    }

    Position generated = Position(
      latitude: position.target.latitude,
      longitude: position.target.longitude
    );

    markers = Set();

    getLocations(generated);
    getVoi(generated);
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
    getNextbikes(coordinates);
    getVoi(coordinates);
  }

  Future <BitmapDescriptor> _createMarkerImageFromAssetTier() async {
    ImageConfiguration configuration = ImageConfiguration(
        size: Size(170, 170),
        devicePixelRatio: MediaQuery.of(context).devicePixelRatio
    );
    var bitmapImage = await BitmapDescriptor.fromAssetImage(
        configuration,'icons/marker_tier.png');
    return bitmapImage;
  }

  Future <BitmapDescriptor> _createMarkerImageFromAssetVoi() async {
    ImageConfiguration configuration = ImageConfiguration(
        size: Size(170, 170),
        devicePixelRatio: MediaQuery.of(context).devicePixelRatio
    );
    var bitmapImage = await BitmapDescriptor.fromAssetImage(
        configuration,'icons/marker_voi.png');
    return bitmapImage;
  }

  Future <BitmapDescriptor> _createMarkerImageFromAssetCirc() async {
    ImageConfiguration configuration = ImageConfiguration(
        size: Size(170, 170),
        devicePixelRatio: MediaQuery.of(context).devicePixelRatio
    );
    var bitmapImage = await BitmapDescriptor.fromAssetImage(
        configuration,'icons/marker_circ.png');
    return bitmapImage;
  }

  Future <BitmapDescriptor> _createMarkerImageFromAssetNextbike() async {
    ImageConfiguration configuration = ImageConfiguration(
        size: Size(170, 170),
        devicePixelRatio: MediaQuery.of(context).devicePixelRatio
    );
    var bitmapImage = await BitmapDescriptor.fromAssetImage(
        configuration,'icons/marker_nextbike.png');
    return bitmapImage;
  }

  getLocations(coordinates) async {
    if (PrefService.getBool("tier_mode") == null
        || PrefService.getBool("tier_mode") == true) {

      var tier_logo = await _createMarkerImageFromAssetTier();
      var tier = await _fetchTier(coordinates.latitude, coordinates.longitude);

      for(var i in tier.data) {
        markers.add(Marker(
          icon: tier_logo,
          markerId: MarkerId(i.id),
          position: LatLng(
              i.lat,
              i.lng
          ),
          infoWindow: InfoWindow(
            title: "TIER Scooter",
            snippet: "Battery: " + i.batteryLevel.toString() + "%",
            onTap: () {
              launchApp('com.tier.app');
            },
          ),
        ));
      }

      setState((){});
    }

    if (PrefService.getBool("circ_mode") == null
        || PrefService.getBool("circ_mode") == true) {

      var circ_logo = await _createMarkerImageFromAssetCirc();
      var circ = await _fetchCirc(coordinates.latitude, coordinates.longitude);

      for(var i in circ.data.scooters) {
        markers.add(Marker(
          icon: circ_logo,
          markerId: MarkerId(i.idScooter.toString()),
          position: LatLng(
              i.location.latitude,
              i.location.longitude
          ),
          infoWindow: InfoWindow(
            title: "CIRC Scooter",
            snippet: "Battery: " + i.powerPercentInt.toString() + "%",
            onTap: () {
              launchApp('com.goflash.consumer');
            },
          ),
        ));
      }

      setState((){});
    }
  }

  getNextbikes(coordinates) async {
    if (PrefService.getBool("nextbike_mode") == null
        || PrefService.getBool("nextbike_mode") == true) {

      var nextbike_logo = await _createMarkerImageFromAssetNextbike();
      var nextbike = await _fetchNextbike();

      for(var i in nextbike.data.bikes) {
        bikeMarkers.add(Marker(
          icon: nextbike_logo,
          markerId: MarkerId(i.bikeId),
          position: LatLng(
              i.lat,
              i.lon
          ),
          infoWindow: InfoWindow(
            title: "Nextbike Fahrrad",
            onTap: () {
              launchApp('de.nextbike');
            },
          ),
        ));
      }

      setState(() {});
    }
  }

  getVoi(coordinates) async {
    if (PrefService.getBool("voi_mode") == null
        || PrefService.getBool("voi_mode") == true) {

      var voi_logo = await _createMarkerImageFromAssetVoi();
      var voi = await _fetchVoi(coordinates.latitude, coordinates.longitude);

      if (voi == voiCache) {
        return;
      } else {
        voiCache = voi;
      }

      for(var i in voi) {
        voiMarkers.add(Marker(
          icon: voi_logo,
          markerId: MarkerId(i.id),
          position: LatLng(
              i.location[0],
              i.location[1]
          ),
          infoWindow: InfoWindow(
            title: "VOI Scooter",
            snippet: "Battery: " + i.battery.toString() + "%",
            onTap: () {
              launchApp('io.voiapp.voi');
            },
          ),
        ));
      }

      setState(() {});
    }
  }

  Set<Marker> generateMarkers() {
    return Set<Marker>.from(bikeMarkers)..addAll(markers)..addAll(voiMarkers);
  }

  Future<NextbikeModel> _fetchNextbike() async {
    final nextbike = await NextbikeService.getNextbike();

    return nextbike;
  }

  Future<TierModel> _fetchTier(lat, lon) async {
    final tier = await TierService.getTierScooter(lat, lon, 500);

    return tier;
  }

  Future<List<VoiModel>> _fetchVoi(lat, lon) async {
    final voi = await VoiService.getVoiScooter(lat, lon);

    return voi;
  }

  Future<CircModel> _fetchCirc(lat, lon) async {
    final circ = await CircService.getCircScooter(lat, lon);

    return circ;
  }

  launchApp(String appID) async {
    bool isInstalled = await DeviceApps.isAppInstalled(appID);

    if (isInstalled) {
      DeviceApps.openApp(appID);
    } else {
      var url = 'https://play.google.com/store/apps/details?id=' + appID;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $appID';
      }
    }
  }

  Future<List<SuggestedLocation>> getResults(String query) async {
    var result = await CoreService.getLocationQuery(query, "STATION", PrefService.getBool("datasave_mode") == false ? 10.toString() : 5.toString(), 'DB');

    return result.suggestedLocations;
  }

  Widget showOptionsModal(BuildContext context, ScrollController controller) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: ListView(
        controller: controller,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          new OptionSwitchImage(
            title: "TIER Scooter",
            icon: 'icons/marker_tier.png',
            id: "tier_mode",
            default_bool: true,
          ),
          SizedBox(
            height: 5,
          ),
          new OptionSwitchImage(
            title: "Voi Scooter",
            icon: 'icons/marker_voi.png',
            id: "voi_mode",
            default_bool: true,
          ),
          SizedBox(
            height: 5,
          ),
          new OptionSwitchImage(
            title: "Circ Scooter",
            icon: 'icons/marker_circ.png',
            id: "circ_mode",
            default_bool: true,
          ),
          SizedBox(
            height: 5,
          ),
          new OptionSwitchImage(
            title: "Nextbike Fahrräder",
            icon: 'icons/marker_nextbike.png',
            id: "nextbike_mode",
            default_bool: true,
          ),
        ],
      ),
    );
  }
}
