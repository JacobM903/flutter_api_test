import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = new TextEditingController();
  List<MatchListData> _matchList = [];

  fetchAccountID(String summonerName) async {
    final response =
    await http.get(
        'https://oc1.api.riotgames.com/lol/summoner/v3/summoners/by-name/$summonerName?api_key=RGAPI-36a67753-2cff-452d-b5fc-77fceb96bfcc');
    if (response.statusCode == 200) {
      return json.decode(response.body)['accountId'];
    } else {
      throw Exception('Couldn\'t find user $summonerName');
    }
  }

  fetchMatchList(int accountID) async {
    final response =
    await http.get(
        'https://oc1.api.riotgames.com/lol/match/v3/matchlists/by-account/$accountID?api_key=RGAPI-36a67753-2cff-452d-b5fc-77fceb96bfcc');
    var matches_list = await json.decode(response.body)["matches"];
    List<MatchListData> digested_list = [];
    for(var i=0;i<matches_list.length;i++){
      digested_list.add(
        MatchListData.fromJson(matches_list[i])
      );
    }
    //setState must be called to trigger elements to rebuild
    setState(() {
      _matchList = digested_list;
    });
  }

  clearMatchList() {
    setState(() {
      _matchList = [];
    });
  }

  void _performSearch() async {
    try {
      var accountID = await fetchAccountID(myController.text);
      fetchMatchList(accountID);
    } catch (Exception) {
      print("$Exception");
      clearMatchList();
    }
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
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[300],
                border: InputBorder.none,
                hintText: "Enter a Search Term",
              ),
              textAlign: TextAlign.center,
              controller: myController,
            ),
            FlatButton(
              child: Column(
                children: <Widget>[
                  Icon(Icons.search),
                  Text("Search")
                ],
              ),
              padding: EdgeInsets.all(2.0),
              onPressed: _performSearch,
              color: Colors.blue,
              textColor: Colors.white,
            ),
            Expanded(
              child: ListView(
                  children: _getMatchDataTiles(),
                ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: clearMatchList,
        child: new Icon(Icons.highlight_off),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  //buildRow will return ListTiles which is a title with a trailing icon
  List<Widget> _getMatchDataTiles() {
    List<Widget> ret = [];
    if(_matchList.length > 0) {
      for (var i = 0; i < _matchList.length; i++) {
        Widget tile = new ListTile(
          title: new Text(
            _matchList[i].lane,
          ),
          subtitle: new Text(
              "Role:${_matchList[i].role}, Champion:${_matchList[i].champion}"
          ),
        );
        ret.add(tile);
      }
    } else {
      ret.add(
        new ListTile()
      );
    }
    return ret;
  }
}


class MatchListData {
  final String lane;
  final String role;
  final int champion;
  final int gameId;

  MatchListData({this.lane, this.role, this.champion, this.gameId});

  factory MatchListData.fromJson(Map<String, dynamic> json) {
    return MatchListData(
      lane: json["lane"],
      role: json["role"],
      champion: json["champion"],
      gameId: json["gameId"],
    );
  }
}

