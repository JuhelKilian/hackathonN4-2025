import 'dart:convert'; // Nécessaire pour la conversion JSON
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<List<List>> recupererActivites() async {
  /*
    * fonction recupererParkings utilise les api pubilques pour
    * recuperer les parkings à vélos
    *
    * Renvoie une Future<List<LatLng>> avec les coordonnées
   */

  int plus = 1;
  List<LatLng> listeCoord = [];
  List<Map> listeInfos = [];

  // Création de la requete
  var headers = {
    'Accept': 'application/json'
  };

  String url = 'https://angersloiremetropole.opendatasoft.com'
      '/api/explore/v2.1/catalog/datasets/equipements-sportifs-angers'
      '/records?limit=100&order_by=categorie&select=geo_point_2d, categorie, nom_instal';

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
      listeCoord.add(LatLng(reponse2[i]['geo_point_2d']["lat"],
          reponse2[i]['geo_point_2d']["lon"]));

      listeInfos.add({"categorie" : reponse2[i]['categorie'],
        "nom_instal": reponse2[i]['nom_instal']});
    }

    List<List> retour = [listeCoord, listeInfos];

    return retour;

  } else {
    throw Exception('Erreur serveur: ${response.reasonPhrase}');
  }
}

Future<List<LatLng>> recupererParkings() async {
  /*
    * fonction recupererParkings utilise les api pubilques pour
    * recuperer les parkings à vélos
    *
    * Renvoie une Future<List<LatLng>> avec les coordonnées
   */


  List<LatLng> listeCoord = [];

  int maxI = 125;

  int max = 100;
  // Création de la requete


  int index = 0;

  //do {
    String url = 'https://angersloiremetropole.opendatasoft.com'
        '//api/explore/v2.1/catalog/datasets/parking-velo-angers/'
        'records?limit=$max&offset=$index';
    var headers = {
      'Accept': 'application/json',
    };
    var request = http.Request('GET', Uri.parse(url));
    request.body = '''''';
    request.headers.addAll(headers);

    int plus = 0;
    // Envoi de la requete
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // Décoder la réponse JSON

      String responseData = await response.stream.bytesToString();

      Map<String, dynamic> reponse = jsonDecode(responseData);
      dynamic reponse2 = reponse["results"];

      for(int i = 0; i < reponse2.length; i++) {

        listeCoord.add(LatLng(reponse2[i]['geo_point_2d']["lat"],
            reponse2[i]['geo_point_2d']["lon"]));
      }

    } else {
      throw Exception('Erreur serveur: ${response.reasonPhrase}');
    }

    index += max;

  /*}
  while(index < 1);*/

  return listeCoord;
}

Future<List<List>> actualiser(LatLng coordonnees, nbKilometres) async {

  List<LatLng> resultats = await recupererParkingsDansZone(coordonnees, nbKilometres);
  return [resultats];
}

Future<List<LatLng>> recupererParkingsDansZone(LatLng coords, double nbKm) async {
  /*
    * fonction recupererParkings utilise les api pubilques pour
    * recuperer les parkings à vélos
    *
    * Renvoie une Future<List<LatLng>> avec les coordonnées
   */


  List<LatLng> listeCoord = [];

  int maxI = 125;

  int max = 100;
  // Création de la requete


  int index = 0;

  //do {
  String url = 'https://angersloiremetropole.opendatasoft.com/'
      'api/explore/v2.1/catalog/datasets/parking-velo-angers/'
      'records?where=within_distance(geo_point_2d,'
      'geom\'POINT(${coords.longitude} ${coords.latitude})\''
      ',${nbKm}km)&limit=100';

  print(url);

  var headers = {
    'Accept': 'application/json',
  };
  var request = http.Request('GET', Uri.parse(url));
  request.body = '''''';
  request.headers.addAll(headers);

  int plus = 0;
  // Envoi de la requete
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    // Décoder la réponse JSON

    String responseData = await response.stream.bytesToString();

    Map<String, dynamic> reponse = jsonDecode(responseData);
    dynamic reponse2 = reponse["results"];

    for(int i = 0; i < reponse2.length; i++) {

      listeCoord.add(LatLng(reponse2[i]['geo_point_2d']["lat"],
          reponse2[i]['geo_point_2d']["lon"]));
    }

  } else {
    throw Exception('Erreur serveur: ${response.reasonPhrase}');
  }

  index += max;

  /*}
  while(index < 1);*/

  return listeCoord;
}

