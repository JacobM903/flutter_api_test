import 'package:flutter/material.dart';
import 'package:flutter_api_test/home/classes.dart';
import 'package:flutter_api_test/home/utils.dart';
import 'package:flutter_api_test/home/widgets.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = new TextEditingController();
  List<MatchListData> _matchList = [];

  setMatchListState(List<MatchListData> matchList) {
    setState(() {
      _matchList = matchList;
    });
  }

  void _performSearch() async {
    var matchList = await fetchMatchListFromSummonerName(myController.text);
    setMatchListState(matchList);
  }

  void _clearMatchList() {
    setMatchListState([]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text("Search Here", textScaleFactor: 3.0,),
            textInput(myController),
            searchButton(_performSearch),
            matchDataList(_matchList)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _clearMatchList,
        child: new Icon(Icons.highlight_off),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
