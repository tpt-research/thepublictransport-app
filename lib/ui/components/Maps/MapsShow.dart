import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thepublictransport_app/backend/models/main/Location.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';

class MapsShow extends StatefulWidget {
  final Location location;

  MapsShow({Key key, this.location}) : super(key: key);

  @override
  State createState() => MapsShowState(location);
}

class MapsShowState extends State<MapsShow> {
  final Location location;

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = Set();

  var theme = ThemeEngine.getCurrentTheme();

  MapsShowState(this.location) {
    markers.add(Marker(
      markerId: MarkerId(location.id),
      infoWindow: InfoWindow(
        title: location.name,
      ),
      position: LatLng(location.latAsDouble, location.lonAsDouble),
    ));
  }

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
      trafficEnabled: true,
      mapType: theme.status == "light" ? MapType.normal : MapType.hybrid,
      markers: markers,
    );
  }

  void _onMapCreated(GoogleMapController controller) async {

    // Avoid race conditions
    await Future.delayed(Duration(milliseconds: 1000));

    setState(() {
      _controller.complete(controller);
    });

    controller.moveCamera(CameraUpdate.newLatLng(
        LatLng(location.latAsDouble, location.lonAsDouble)
    ));
  }
}
