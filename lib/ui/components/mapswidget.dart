import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapsWidget extends StatefulWidget {
  @override
  State createState() => MapsWidgetState();
}

class MapsWidgetState extends State<MapsWidget> {

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(50.1287204, 8.6295871),
    zoom:17.0,
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
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() { _controller.complete(controller); });
  }
}