import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:flutter_api_test/components/home/classes.dart';
import 'package:flutter_api_test/components/home/utils.dart';
import 'package:flutter_api_test/components/home/widgets.dart';
import 'package:flutter_api_test/config/application.dart';
import 'package:flutter_api_test/config/routes.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

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
    context = context;
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
            matchDataList(context, _matchList)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _clearMatchList,
        child: new Icon(Icons.highlight_off),
      ),//// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
