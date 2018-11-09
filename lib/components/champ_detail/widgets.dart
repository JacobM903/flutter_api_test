import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<Map<String, dynamic>> getChampData(champId) async {
  var response =
    await http.get(
        'http://ddragon.leagueoflegends.com/cdn/8.22.1/data/en_US/champion/${champId}.json'
    );
  return jsonDecode(response.body);
}

Widget abilityDetails(champId){
  return new FutureBuilder(
      future: getChampData(champId),
      initialData: null,
      builder: (BuildContext context, response) {
        return new Expanded(
          child: response.data == null ?
            CircularProgressIndicator() :
            ListView(children: getSpellTiles(response.data["data"][champId]["spells"])),
        );
      });
}

List<ListTile> getSpellTiles(List<dynamic> spells) {
  List<ListTile> tiles = [];
  if(spells.length > 0) {
    for (var i = 0; i < spells.length; i++) {
      Map<String, dynamic> spell = spells[i];
      Widget tile = new ListTile(
        title: new Text(
          "${spell['id']} - ${spell['cooldown']}",
        ),
        subtitle: new Text(
            spell["description"]
        ),
      );
      tiles.add(tile);
    }
  }
  return tiles;
}