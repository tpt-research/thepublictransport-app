import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thepublictransport_app/backend/models/main/SuggestedLocation.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';

class MapsStops extends StatefulWidget {
  final List<SuggestedLocation> location;

  MapsStops({Key key, this.location}) : super(key: key);

  @override
  State createState() => MapsStopsState(location);
}

class MapsStopsState extends State<MapsStops> {
  final List<SuggestedLocation> location;

  Completer<GoogleMapController> _controller = Completer();
  Geolocator geolocator = Geolocator();
  Set<Marker> markers = Set();

  var theme = ThemeEngine.getCurrentTheme();

  MapsStopsState(this.location) {
    for (var i in location) {
      markers.add(Marker(
        markerId: MarkerId(i.location.id),
        infoWindow: InfoWindow(
            title: i.location.name,
        ),
        position: LatLng(i.location.latAsDouble, i.location.lonAsDouble),
      ));
    }
  }

  static final CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(37.422, -122.084),
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
      mapType: theme.status == "light" ? MapType.normal : MapType.hybrid,
      markers: markers,
    );
  }

  void _onMapCreated(GoogleMapController controller) async {

    // Avoid race conditions
    await Future.delayed(Duration(milliseconds: 500));

    setState(() {
      _controller.complete(controller);
    });

    var coordinates = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best, locationPermissionLevel: GeolocationPermission.location);

    controller.moveCamera(CameraUpdate.newLatLngZoom(
        LatLng(coordinates.latitude, coordinates.longitude), 15
    ));
  }
}
