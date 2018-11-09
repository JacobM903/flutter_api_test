import 'package:flutter/material.dart';
import 'package:flutter_api_test/config/application.dart';


Widget champTile (context, document) {
  return new ListTile(
    leading: Image.network('http://ddragon.leagueoflegends.com/cdn/8.22.1/img/champion/${document["image"]["full"]}', scale: 2.5,),
    title: new Text(document['name']),
    subtitle: new Text(document['title']),
    trailing: new Text('${document["tags"]}'),
    onTap: () => Application.router.navigateTo(context, "/champ_detail?champId=${document['id']}"),
  );
}