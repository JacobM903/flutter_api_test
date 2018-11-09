import 'package:flutter/material.dart';
import 'package:flutter_api_test/components/champ_detail/widgets.dart';


class ChampDetailPage extends StatelessWidget {
  ChampDetailPage({@required this.champId});
  final String champId;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(champId),
      ),
      body: Column(
        children: <Widget>[
          new Image.network("http://ddragon.leagueoflegends.com/cdn/img/champion/splash/${champId}_0.jpg"),
          abilityDetails(champId),
        ],
      )
    );
  }
}