import 'package:flutter/material.dart';
import 'package:flutter_api_test/components/match_detail/utils.dart';


class MatchDetailPage extends StatelessWidget {
  MatchDetailPage({@required this.matchId});
  final String matchId;

  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: fetchMatchDataFull(matchId),
      initialData: "Loading match..",
      builder: (BuildContext context, AsyncSnapshot<String> text) {
        return new SingleChildScrollView(
            padding: new EdgeInsets.all(8.0),
            child: new Text(
              text.data,
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19.0,
              ),
            ));
      });
  }
}