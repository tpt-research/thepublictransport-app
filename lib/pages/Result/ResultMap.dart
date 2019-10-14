import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thepublictransport_app/backend/models/main/From.dart';
import 'package:thepublictransport_app/backend/models/main/Trip.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/pages/Station/Station.dart';

class ResultMap extends StatefulWidget {
  final Trip trip;

  const ResultMap({Key key, this.trip}) : super(key: key);

  @override
  _ResultMapState createState() => _ResultMapState(this.trip);
}

class _ResultMapState extends State<ResultMap> {
  final Trip trip;
  Set<Polyline> polyline = Set();
  Set<Marker> marker = Set();

  var theme = ThemeEngine.getCurrentTheme();

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(37.422, -122.084),
    zoom: 17.0,
  );

  _ResultMapState(this.trip);

  Future <BitmapDescriptor> _createMarkerImageFromAsset() async {
    ImageConfiguration configuration = ImageConfiguration(
        size: Size(170, 170),
        devicePixelRatio: MediaQuery.of(context).devicePixelRatio
    );
    var bitmapImage = await BitmapDescriptor.fromAssetImage(
        configuration,'icons/marker.png');
    return bitmapImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "HEROOOO2",
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: theme.floatingActionButtonColor,
        child: Icon(Icons.arrow_back, color: theme.floatingActionButtonIconColor),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationEnabled: true,
            initialCameraPosition: _kInitialPosition,
            onMapCreated: _onMapCreated,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: false,
            zoomGesturesEnabled: true,
            trafficEnabled: false,
            mapType: theme.status == "light" ? MapType.normal : MapType.hybrid,
            markers: marker,
            polylines: polyline,
          ),
          Container(
            height: MediaQuery.of(context).padding.top,
            color: Colors.black.withAlpha(120),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {

    setState(() {
      _controller.complete(controller);
    });

    controller.moveCamera(CameraUpdate.newLatLngZoom(
        LatLng(trip.from.latAsDouble, trip.from.lonAsDouble), 8
    ));

    renderInfos();
  }

  void renderInfos() async {
    Set<Marker> newMarkers = Set();
    Set<Polyline> newPolyline = Set();
    BitmapDescriptor bitmap = await _createMarkerImageFromAsset();
    List<LatLng> coords = [];

    newMarkers.add(Marker(
      icon: bitmap,
      markerId: MarkerId(trip.from.id),
      position: LatLng(
        trip.from.latAsDouble,
        trip.from.lonAsDouble,
      ),

      infoWindow: InfoWindow(
        title: trip.from.name,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Station(From.toLocation(trip.from)
              )
          ));
        },
      ),
    ));

    for(var i in trip.legs) {
      newMarkers.add(Marker(
        icon: bitmap,
        markerId: MarkerId(i.departure.id),
        position: LatLng(
          i.departure.latAsDouble,
          i.departure.lonAsDouble,
        ),

        infoWindow: InfoWindow(
          title: i.departure.name,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Station(From.toLocation(i.departure)
                )
            ));
          },
        ),
      ));

      coords.add(LatLng(i.departure.latAsDouble, i.departure.lonAsDouble));

      for (var intermediate in i.intermediateStops) {
        newMarkers.add(Marker(
          icon: bitmap,
          markerId: MarkerId(intermediate.location.id),
          position: LatLng(
            intermediate.location.latAsDouble,
            intermediate.location.lonAsDouble,
          ),

          infoWindow: InfoWindow(
            title: intermediate.location.name,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Station(From.toLocation(intermediate.location)
                  )
              ));
            },
          ),
        ));
        coords.add(LatLng(intermediate.location.latAsDouble, intermediate.location.lonAsDouble));
      }

      newMarkers.add(Marker(
        icon: bitmap,
        markerId: MarkerId(i.arrival.id),
        position: LatLng(
          i.arrival.latAsDouble,
          i.arrival.lonAsDouble,
        ),

        infoWindow: InfoWindow(
          title: i.arrival.name,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Station(From.toLocation(i.arrival)
                )
            ));
          },
        ),
      ));

      coords.add(LatLng(i.arrival.latAsDouble, i.arrival.lonAsDouble));
    }

    newPolyline.add(Polyline(
      polylineId: PolylineId('Line'),
      visible: true,
      //latlng is List<LatLng>
      points: coords,
      width: 2,
      color: Colors.red,
    ));

    setState(() {
      marker = newMarkers;
      polyline = newPolyline;
    });
  }
}
