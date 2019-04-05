import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:desiredrive_api_flutter/service/geocode.dart';

class MapsWidget extends StatefulWidget {
  @override
  State createState() => MapsWidgetState();
}

class MapsWidgetState extends State<MapsWidget> {
  DesireDriveGeocode geocode = new DesireDriveGeocode();

  GoogleMapController mapController;

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
    setState(() { mapController = controller; });
    _mapUpdate(geocode);

    StreamSubscription periodicSub;

    periodicSub = new Stream.periodic(const Duration(milliseconds: 500))
        .listen((_) => _mapUpdate(geocode));
  }

  Future<void> _mapUpdate(DesireDriveGeocode geocode) async {
    geocode.location().then((res) {
      CameraPosition position = CameraPosition(
          target: LatLng(res['latitude'], res['longitude']),
          zoom: 17.0
      );
      mapController.moveCamera(CameraUpdate.newCameraPosition(position));
    });
  }
}