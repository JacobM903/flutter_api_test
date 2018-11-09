import 'package:flutter/material.dart';
import 'package:flutter_api_test/components/match_detail/utils.dart';


class MatchDetailPage extends StatelessWidget {
  MatchDetailPage({@required this.matchId});
  final String matchId;

  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: fetchMatchDataFull(matchId),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot<String> text) {
        return new Scaffold(
          appBar: AppBar(
            title: Text("Match Detail"),
          ),
          body: Center(
            child: text.data == null ? CircularProgressIndicator() : Text(text.data),
          ),
        );
      });
  }
}