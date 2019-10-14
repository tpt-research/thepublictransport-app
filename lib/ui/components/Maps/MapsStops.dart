import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:preferences/preference_service.dart';
import 'package:thepublictransport_app/backend/models/main/Location.dart';
import 'package:thepublictransport_app/backend/service/core/CoreService.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/pages/Station/Station.dart';

class MapsStops extends StatefulWidget {

  MapsStops({Key key}) : super(key: key);

  @override
  State createState() => MapsStopsState();
}

class MapsStopsState extends State<MapsStops> {

  Completer<GoogleMapController> _controller = Completer();
  Geolocator geolocator = Geolocator();
  Set<Marker> markers = Set();

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
      zoomGesturesEnabled: false,
      tiltGesturesEnabled: false,
      trafficEnabled: true,
      mapType: theme.status == "light" ? MapType.normal : MapType.hybrid,
      markers: markers,
    );
  }

  void _onCameraMove(CameraPosition position) async {
    Set<Marker> newMarkers = Set();
    List<Location> locations = await _fetchNearby(position.target.latitude, position.target.longitude);
    BitmapDescriptor marker = await _createMarkerImageFromAsset();

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
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Station(i)));
          },
        ),
      ));
    }

    setState(() {
      markers = newMarkers;
    });
  }

  void _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _controller.complete(controller);
    });

    var coordinates = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best, locationPermissionLevel: GeolocationPermission.location);

    controller.moveCamera(CameraUpdate.newLatLngZoom(
        LatLng(coordinates.latitude, coordinates.longitude), 15
    ));

    getLocations();
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

  getLocations() async {
    var coordinates = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
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
              systemNavigationBarColor: theme.iconColor,
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
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Station(i)));
          },
        ),
      ));
    }

    setState(() {
      markers = newMarkers;
    });
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
}
