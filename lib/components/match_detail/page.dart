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
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0, // this will be set when a new tab is tapped
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('General'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.mail),
                title: Text('Stats'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('Timeline')
              )
            ],
          ),
        );
      });
  }
}