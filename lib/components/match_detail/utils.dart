import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> fetchMatchDataFull(String matchId) async {
  var stored_match = await Firestore.
    instance.collection('matches').where('gameId', isEqualTo: int.parse(matchId)).snapshots().first;

  var matchJson = 'Match Not Found';
  if(stored_match.documents.length > 0){
    matchJson = jsonEncode(stored_match.documents[0].data);
    print('Retreived match $matchId from Firestore');
    return matchJson;
  } else {
    var response =
      await http.get(
          'https://oc1.api.riotgames.com/lol/match/v3/matches/$matchId?api_key=RGAPI-5caa7ab4-d993-4c3b-b2c0-9f9b23e7d461'
      );
    if(response.statusCode == 200) {
      Firestore.instance.collection("matches").add(jsonDecode(response.body));
      var matchJson = response.body;
      print('Retrieved match $matchId from API and saved to firestore');
      print(matchJson);
      return matchJson;
    }
  }
}