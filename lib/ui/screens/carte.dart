import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tous_au_sport/data/marker.dart';
import 'package:tous_au_sport/utils/fonctionRequetes.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  List<LatLng> coordinnesMarkers = [
    /*LatLng(47.4698, -0.5593),
    LatLng(47.4688, -0.5583),*/
  ];
  List<LatLng> coordinnesActivites = [
    /*LatLng(47.4678, -0.5593),
    LatLng(47.4668, -0.5583),*/
  ];

  List<String> infosActivites = ["Toutes les activités"];
  String nomChange = "Toutes les activités";

  @override
  void initState() {
    super.initState();
    recupererInfoParkings();
    recupererInfoActivites();
  }

// List<LatLng> coordinnesMarkers = await recupererInfoParkings();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Angers sport'),

    ),

    body:
      Center(
        child: Container(
          child: Column(
            children: [
              Container(
                child:
                  DropdownButton(
value: nomChange,
                      items:
                      infosActivites.map((String valeur) {
                        return DropdownMenuItem<String>(
                        value: valeur,
                        child: Text(valeur),
                        );
                        }
                      ).toList(),

                      onChanged: (String? newValue) {
                        setState(() {
                          nomChange = newValue!;
                        });
                      })
              ),
              Stack(
                children: [
                Container(
                  child: FlutterMap(
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
                          markers: afficherMarkers()
                      ),
                    ],
                  ),
                  height: 848,
                ),

                // Ajouter le reste ici dans le stack.
                Positioned(
                    top: 20,
                    left: 30,
                    child: Container(
                        width: 200,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                    Icons.location_on,
                                    color: Colors.red
                                ),
                                SizedBox(width: 15),
                                Text('Parking à vélo',
                                  style: TextStyle(
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 2.0,
                                        color: Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 2.0,
                                        color: Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 2.0,
                                        color: Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 2.0,
                                        color: Color.fromARGB(255, 255, 255, 255),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                    Icons.location_on,
                                    color: Colors.brown
                                ),
                                SizedBox(width: 15),
                                Text('Activités à Angers',
                                  style: TextStyle(
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 2.0,
                                        color: Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 2.0,
                                        color: Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 2.0,
                                        color: Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 2.0,
                                        color: Color.fromARGB(255, 255, 255, 255),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                    )
                ),
              ],)

            ],

          ),
        ),
      )
    );
  }

  void changerDropDown() {

  }
  List<Marker> afficherMarkers() {
    List<Marker> listeR = [];

    for(int i = 0; i < coordinnesMarkers.length; i++) {
      listeR.add(
        Marker(
          point: coordinnesMarkers[i],
          child: Icon(
              Icons.location_pin,
              color: Colors.red
          ),
        ),
      );
    }

    for(int i = 0; i < coordinnesActivites.length; i++) {
      listeR.add(
        Marker(
          point: coordinnesActivites[i],
          child: Icon(
              Icons.location_pin,
              color: Colors.brown
          ),
        ),
      );
    }
    return listeR;
  }

  Future<void> recupererInfoParkings() async {
    List<LatLng> infoParkins = await recupererParkings();
    coordinnesMarkers = infoParkins;
  }

  Future<void> recupererInfoActivites() async {
    List liste = await recupererActivites();
    List<LatLng> infoParkins = liste[0];
    List<Map<dynamic, dynamic>> listeInfos = liste[1];


    coordinnesActivites = infoParkins;
    for (int i = 0; i < listeInfos.length; i++) {
      infosActivites.add(listeInfos[i]["categorie"] + " - " + listeInfos[i]["nom_instal"]);
    }
    print(infosActivites);
  }
}
