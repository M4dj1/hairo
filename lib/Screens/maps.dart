import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:hairo/Icon/echair_icons.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  late CenterOnLocationUpdate _centerOnLocationUpdate;
  late StreamController<double> _centerCurrentLocationStreamController;

  @override
  void initState() {
    super.initState();
    _centerOnLocationUpdate = CenterOnLocationUpdate.always;
    _centerCurrentLocationStreamController = StreamController<double>();
  }

  @override
  void dispose() {
    _centerCurrentLocationStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(35.2078434, 3.4318793),
        zoom: 16,
        minZoom: 8.5,
        maxZoom: 17.0,
        // Stop centering the location marker on the map if user interacted with the map.
        onPositionChanged: (MapPosition position, bool hasGesture) {
          if (hasGesture) {
            setState(
                () => _centerOnLocationUpdate = CenterOnLocationUpdate.never);
          }
        },
        interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
      ),
      children: [
        TileLayerWidget(
          options: TileLayerOptions(
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/madji/ckrn1yjx82bos19o1y805hvbf/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWFkamkiLCJhIjoiY2tybWc4NWYwMHZvejJwbDdibjd2NXBqZCJ9.uJ_fye7QXBKBjBznsmIe1g",
              additionalOptions: {
                'accessToken':
                    'pk.eyJ1IjoibWFkamkiLCJhIjoiY2tybWc4NWYwMHZvejJwbDdibjd2NXBqZCJ9.uJ_fye7QXBKBjBznsmIe1g',
                'id': 'mapbox.mapbox-streets-v8'
              }),
        ),
        LocationMarkerLayerWidget(
          plugin: LocationMarkerPlugin(
            centerCurrentLocationStream:
                _centerCurrentLocationStreamController.stream,
            centerOnLocationUpdate: _centerOnLocationUpdate,
          ),
          options: LocationMarkerLayerOptions(
            marker: DefaultLocationMarker(
              color: Color(0xff051821),
              child: Icon(
                Echair.positionmarker,
                color: Colors.orangeAccent,
                size: 25,
              ),
            ),
            markerSize: const Size(30, 30),
            accuracyCircleColor: Color(0xff051821).withOpacity(0.1),
            headingSectorColor: Color(0xff051821).withOpacity(0.8),
            headingSectorRadius: 70,
            markerAnimationDuration: Duration.zero, // disable animation
          ),
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: FloatingActionButton(
            backgroundColor: Color(0xff051821),
            onPressed: () {
              // Automatically center the location marker on the map when location updated until user interact with the map.
              setState(() =>
                  _centerOnLocationUpdate = CenterOnLocationUpdate.always);
              // Center the location marker on the map and zoom the map to level 18.
              _centerCurrentLocationStreamController.add(16.0);
            },
            child: Icon(
              Icons.my_location,
              color: Colors.orangeAccent,
            ),
          ),
        ),
      ],
    );
  }
}
