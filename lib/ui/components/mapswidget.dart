import 'dart:async';

import 'package:desiredrive_api_flutter/service/geocode/geocode.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thepublictransport_app/ui/colors/color_theme_engine.dart';

class MapsWidget extends StatefulWidget {
  MapsWidget({Key key}) : super(key: key);

  @override
  State createState() => MapsWidgetState();
}

class MapsWidgetState extends State<MapsWidget> {
  Completer<GoogleMapController> _controller = Completer();
  DesireDriveGeocode geocode = new DesireDriveGeocode();

  static final CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(50.1287204, 8.6295871),
    zoom: 17.0,
  );

  @override
  Widget build(BuildContext context) {
    return new GoogleMap(
      myLocationEnabled: true,
      initialCameraPosition: _kInitialPosition,
      onMapCreated: _onMapCreated,
      rotateGesturesEnabled: false,
      scrollGesturesEnabled: false,
      tiltGesturesEnabled: false,
      mapType:
          ColorThemeEngine.theme == "dark" ? MapType.hybrid : MapType.normal,
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
