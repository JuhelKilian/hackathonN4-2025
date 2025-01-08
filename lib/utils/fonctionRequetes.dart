import 'dart:convert'; // Nécessaire pour la conversion JSON
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:fluttertoast/fluttertoast.dart';


Future<List<LatLng>> recupererParkings() async {
  /*
    * fonction recupererParkings utilise les api pubilques pour
    * recuperer les parkings à vélos
    *
    * Renvoie une Future<List<LatLng>> avec les coordonnées
   */


  List<LatLng> listeR = [];

  // Création de la requete
  var headers = {
    'Accept': 'application/json',
  };

  String url = 'https://angersloiremetropole.opendatasoft.com//api/explore/v2.1/catalog/datasets/parking-velo-angers/records?select=geo_point_2d&limit=20';

  var request = http.Request('GET', Uri.parse(url));
  request.body = '''''';
  request.headers.addAll(headers);


  // Envoi de la requete
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    // Décoder la réponse JSON

    String responseData = await response.stream.bytesToString();

    Map<String, dynamic> reponse = jsonDecode(responseData);
    dynamic reponse2 = reponse["results"];

    for(int i = 0; i < reponse2.length; i++) {
      listeR.add(LatLng(reponse2[i]['geo_point_2d']["lat"], reponse2[i]['geo_point_2d']["lon"]));
    }

    return listeR;

  } else {
    throw Exception('Erreur serveur: ${response.reasonPhrase}');
  }
}