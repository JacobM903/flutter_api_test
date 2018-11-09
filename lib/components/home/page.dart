import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:flutter_api_test/components/home/classes.dart';
import 'package:flutter_api_test/components/home/utils.dart';
import 'package:flutter_api_test/components/home/widgets.dart';
import 'package:flutter_api_test/config/application.dart';
import 'package:flutter_api_test/config/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MyHomePage extends StatefulWidget {
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
    context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: new GestureDetector(
        onTap: () {
          // call this method here to hide soft keyboard
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text("Search Here", textScaleFactor: 3.0,),
              textInput(myController),
              searchButton(_performSearch),
              matchDataList(context, _matchList),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _clearMatchList,
        child: new Icon(Icons.highlight_off),
      ), //// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
