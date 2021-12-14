import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  MapController mapController = new MapController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          minZoom: 8.5,
          maxZoom: 17.0,
          interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
        ),
        layers: <LayerOptions>[
          TileLayerOptions(
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/madji/ckrn1yjx82bos19o1y805hvbf/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWFkamkiLCJhIjoiY2tybWc4NWYwMHZvejJwbDdibjd2NXBqZCJ9.uJ_fye7QXBKBjBznsmIe1g",
              additionalOptions: {
                'accessToken':
                    'pk.eyJ1IjoibWFkamkiLCJhIjoiY2tybWc4NWYwMHZvejJwbDdibjd2NXBqZCJ9.uJ_fye7QXBKBjBznsmIe1g',
                'id': 'mapbox.mapbox-streets-v8'
              }),
        ],
      ),
    ));
  }
}
