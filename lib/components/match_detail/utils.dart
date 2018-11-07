import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> fetchMatchDataFull(String matchId) async {
  final response =
  await http.get(
      'https://oc1.api.riotgames.com/lol/match/v3/matches/$matchId?api_key=RGAPI-36a67753-2cff-452d-b5fc-77fceb96bfcc'
  );
  if (response.statusCode == 200) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String prettyprint = encoder.convert(response.body);
    return prettyprint;
  } else {
    return 'Couldn\'t find user $matchId';
  }
}