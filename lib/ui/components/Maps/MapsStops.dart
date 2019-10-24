import 'dart:async';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:preferences/preference_service.dart';
import 'package:thepublictransport_app/backend/models/circ/CircModel.dart';
import 'package:thepublictransport_app/backend/models/main/Location.dart';
import 'package:thepublictransport_app/backend/models/nextbike/NextbikeModel.dart';
import 'package:thepublictransport_app/backend/models/tier/TierModel.dart';
import 'package:thepublictransport_app/backend/models/voi/VoiModel.dart';
import 'package:thepublictransport_app/backend/service/circ/CircService.dart';
import 'package:thepublictransport_app/backend/service/core/CoreService.dart';
import 'package:thepublictransport_app/backend/service/nextbike/NextbikeService.dart';
import 'package:thepublictransport_app/backend/service/tier/TierService.dart';
import 'package:thepublictransport_app/backend/service/voi/VoiService.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/pages/Station/Station.dart';
import 'package:url_launcher/url_launcher.dart';

class MapsStops extends StatefulWidget {

  MapsStops({Key key}) : super(key: key);

  @override
  State createState() => MapsStopsState();
}

class MapsStopsState extends State<MapsStops> {

  Completer<GoogleMapController> _controller = Completer();
  Geolocator geolocator = Geolocator();
  Set<Marker> markers = Set();
  int limiter = 0;

  var theme = ThemeEngine.getCurrentTheme();

  static final CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(37.422, -122.084),
    zoom: 17.0,
  );

  @override
  Widget build(BuildContext context) {
    return new GoogleMap(
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      compassEnabled: false,
      mapToolbarEnabled: false,
      initialCameraPosition: _kInitialPosition,
      onMapCreated: _onMapCreated,
      onCameraMove: _onCameraMove,
      rotateGesturesEnabled: false,
      scrollGesturesEnabled: true,
      zoomGesturesEnabled: true,
      tiltGesturesEnabled: false,
      trafficEnabled: true,
      mapType: theme.status == "light" ? MapType.normal : MapType.hybrid,
      markers: markers,
    );
  }

  void _onCameraMove(CameraPosition position) async {
    if (!(limiter > 5)) {
      limiter++;
      return;
    } else {
      limiter = 0;
    }

    List<Location> locations = await _fetchNearby(position.target.latitude, position.target.longitude);
    BitmapDescriptor marker = await _createMarkerImageFromAsset();

    for(var i in locations) {
      markers.add(Marker(
        icon: marker,
        markerId: MarkerId(i.id),
        position: LatLng(
          i.latAsDouble,
          i.lonAsDouble,
        ),

        infoWindow: InfoWindow(
          title: i.name,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Station(i)));
          },
        ),
      ));
    }

    setState(() {});
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

  Future <BitmapDescriptor> _createMarkerImageFromAsset() async {
    ImageConfiguration configuration = ImageConfiguration(
        size: Size(170, 170),
        devicePixelRatio: MediaQuery.of(context).devicePixelRatio
    );
    var bitmapImage = await BitmapDescriptor.fromAssetImage(
        configuration,'icons/marker.png');
    return bitmapImage;
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
    BitmapDescriptor marker = await _createMarkerImageFromAsset();
    List<Location> locations = await _fetchNearby(coordinates.latitude, coordinates.longitude);
    Set<Marker> newMarkers = Set();

    for(var i in locations) {
      newMarkers.add(Marker(
        icon: marker,
        markerId: MarkerId(i.id),
        position: LatLng(
          i.latAsDouble,
          i.lonAsDouble,
        ),

        infoWindow: InfoWindow(
          title: i.name,
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Station(i)));
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.blueAccent,
              statusBarColor: Colors.transparent, // status bar color
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light,
            ));
          },
        ),
      ));
    }

    setState(() {
      markers = newMarkers;
    });

    try {
      List<Location> fuzzyLocations = await _fetchFuzzy(coordinates.latitude, coordinates.longitude);

      for(var i in fuzzyLocations) {
        newMarkers.add(Marker(
          icon: marker,
          markerId: MarkerId(i.id),
          position: LatLng(
            i.latAsDouble,
            i.lonAsDouble,
          ),
          infoWindow: InfoWindow(
            title: i.name,
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Station(i)));
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                systemNavigationBarColor: Colors.blueAccent,
                statusBarColor: Colors.transparent, // status bar color
                statusBarBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.light,
              ));
            },
          ),
        ));
      }

      setState(() {
        markers = newMarkers;
      });
    } catch (e) {
      // Do nothing
    }

    if (PrefService.getBool('scooter_mode')) {
      var tier_logo = await _createMarkerImageFromAssetTier();
      var tier = await _fetchTier(coordinates.latitude, coordinates.longitude);

      for(var i in tier.data) {
        newMarkers.add(Marker(
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

      setState(() {
        markers = newMarkers;
      });

      var circ_logo = await _createMarkerImageFromAssetCirc();
      var circ = await _fetchCirc(coordinates.latitude, coordinates.longitude);

      for(var i in circ.data.scooters) {
        newMarkers.add(Marker(
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

      setState(() {
        markers = newMarkers;
      });

      var voi_logo = await _createMarkerImageFromAssetVoi();
      var voi = await _fetchVoi(coordinates.latitude, coordinates.longitude);

      for(var i in voi) {
        newMarkers.add(Marker(
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

      setState(() {
        markers = newMarkers;
      });

      var nextbike_logo = await _createMarkerImageFromAssetNextbike();
      var nextbike = await _fetchNextbike();

      for(var i in nextbike.data.bikes) {
        newMarkers.add(Marker(
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

      setState(() {
        markers = newMarkers;
      });
    }
  }

  Future<List<Location>> _fetchFuzzy(lat, lon) async {
    List<Location> locations = [];

    final fuzzyResponse = await CoreService.getLocationNearbyAlternativeCoord(
        lat,
        lon,
        5.toString(),
        PrefService.getString('public_transport_data')
    );

    if (fuzzyResponse.locations != null) {
      for (var i in fuzzyResponse.locations) {
        locations.add(i);
      }
    }

    return locations;
  }

  Future<List<Location>> _fetchNearby(lat, lon) async {
    List<Location> locations = [];

    await Future.delayed(Duration(milliseconds: 500));

    final response = await CoreService.getLocationNearbyCoord(
        lat,
        lon,
        5.toString(),
        PrefService.getString('public_transport_data')
    );

    if (response.locations != null) {
      for (var i in response.locations) {
        locations.add(i);
      }
    }

    return locations;
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
}
