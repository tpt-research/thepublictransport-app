import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:desiredrive_api_flutter/service/geocode.dart';
import 'package:thepublictransport_app/framework/permission/permission.dart';
import 'package:thepublictransport_app/framework/permission/permissionconstants.dart';


class MapsWidget extends StatefulWidget {
  @override
  State createState() => MapsWidgetState();
}

class MapsWidgetState extends State<MapsWidget> {
  DesireDriveGeocode geocode = new DesireDriveGeocode();
  PermissionFramework permission = new PermissionFramework();

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
    
    permission.checkPermission(PermissionConstants.LocationPermission).then((res) {
      if (permission.resolvePermission(res)) {
        StreamSubscription periodicSub;

        try {
          periodicSub = new Stream.periodic(const Duration(milliseconds: 5000))
              .listen((_) => _mapUpdate(geocode));

          if (periodicSub == null)
            throw NullThrownError();
        } catch (exception) {
          periodicSub.cancel();
          print(exception);
        }
      }
    });
  }

  Future<void> _mapUpdate(DesireDriveGeocode geocode) async {
    geocode.location().then((res) {
      try {
        CameraPosition position = CameraPosition(
            target: LatLng(res['latitude'], res['longitude']),
            zoom: 17.0
        );
        mapController.moveCamera(CameraUpdate.newCameraPosition(position));
      } catch (exception) {
        print(exception);
      }
    });
  }
}