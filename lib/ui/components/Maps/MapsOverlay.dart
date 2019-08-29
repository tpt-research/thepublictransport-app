import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';

class MapsOverlay extends StatefulWidget {

  MapsOverlay({Key key}) : super(key: key);

  @override
  State createState() => MapsOverlayState();
}

class MapsOverlayState extends State<MapsOverlay> {

  Completer<GoogleMapController> _controller = Completer();
  Geolocator geolocator = Geolocator();

  var theme = ThemeEngine.getCurrentTheme();

  static final CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(37.422, -122.084),
    zoom: 17.0,
  );

  @override
  Widget build(BuildContext context) {
    return new GoogleMap(
      myLocationEnabled: false,
      initialCameraPosition: _kInitialPosition,
      onMapCreated: _onMapCreated,
      rotateGesturesEnabled: false,
      scrollGesturesEnabled: false,
      tiltGesturesEnabled: false,
      zoomGesturesEnabled: false,
      mapType: theme.status == "light" ? MapType.normal : MapType.hybrid,
    );
  }

  void _onMapCreated(GoogleMapController controller) async {

    bool firstRun = false;

    // Avoid race conditions
    await Future.delayed(Duration(milliseconds: 1000));

    setState(() {
      _controller.complete(controller);
    });

    geolocator
        .getPositionStream(LocationOptions(
        accuracy: LocationAccuracy.medium, timeInterval: 10000))
        .listen((position) {
      if (firstRun == false) {
        controller.moveCamera(CameraUpdate.newLatLngZoom(
            LatLng(position.latitude, position.longitude), 15
        ));
        firstRun = true;
      } else {
        controller.animateCamera(CameraUpdate.newLatLngZoom(
            LatLng(position.latitude, position.longitude), 15
        ));
      }
    });
  }
}
