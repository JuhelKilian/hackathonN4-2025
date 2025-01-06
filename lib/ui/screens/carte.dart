import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tous_au_sport/data/marker.dart';

class Carte extends StatefulWidget {
  const Carte({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Carte> createState() => _CarteState();
}


class _CarteState extends State<Carte> {
  double latitudeAngers = 47.4698;
  double longitudeAngers = -0.5593;

  final List<LatLng> coordinnesMarkers = [
    LatLng(47.4798, -0.5493),
    LatLng(47.4698, -0.5593),
  ];



  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(latitudeAngers, longitudeAngers), // Center the map over London
        initialZoom: 13,
      ),
      children: [
        TileLayer( // Display map tiles from any source
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
          userAgentPackageName: 'com.example.app',
          // And many more recommended properties!
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: coordinnesMarkers[0],
              child: Icon(
                  Icons.location_pin,
                  color: Colors.red
              ),
            ),
            Marker(
              point: coordinnesMarkers[1],
              child: Icon(
                  Icons.location_pin,
                  color: Colors.red
              ),
            ),
          ],
        ),
      ],
    );


  }
}
