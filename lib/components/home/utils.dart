import 'dart:convert';

import 'package:flutter_api_test/components/home/classes.dart';
import 'package:http/http.dart' as http;


Future<int> fetchAccountID(String summonerName) async {
  final response =
  await http.get(
      'https://oc1.api.riotgames.com/lol/summoner/v3/summoners/by-name/$summonerName?api_key=RGAPI-36a67753-2cff-452d-b5fc-77fceb96bfcc');
  if (response.statusCode == 200) {
    return json.decode(response.body)['accountId'];
  } else {
    throw Exception('Couldn\'t find user $summonerName');
  }
}

Future<List<MatchListData>> fetchMatchList(int accountId) async {
  final response =
  await http.get(
      'https://oc1.api.riotgames.com/lol/match/v3/matchlists/by-account/$accountId?api_key=RGAPI-36a67753-2cff-452d-b5fc-77fceb96bfcc');
  var matchList = await json.decode(response.body)["matches"];
  List<MatchListData> digestedList = [];
  for(var i=0;i<matchList.length;i++){
    digestedList.add(
        MatchListData.fromJson(matchList[i])
    );
  }
  return digestedList;
}

Future<List<MatchListData>> fetchMatchListFromSummonerName(String summonerName) async {
  List<MatchListData> ret = [];
  try {
    int accountId = await fetchAccountID(summonerName);
    List<MatchListData> matchList = await fetchMatchList(accountId);
    ret = matchList;
  } catch(Exception) {
    print(Exception);
  }
  return ret;
}