import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> fetchMatchDataFull(String matchId) async {
  final response =
  await http.get(
      'https://oc1.api.riotgames.com/lol/match/v3/matches/$matchId?api_key=RGAPI-5caa7ab4-d993-4c3b-b2c0-9f9b23e7d461'
  );
  if (response.statusCode == 200) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String prettyprint = encoder.convert(response.body);
    Firestore.instance.collection("matches").add(jsonDecode(response.body));
    return prettyprint;
  } else {
    return 'Couldn\'t find user $matchId';
  }
}