import 'package:flutter/material.dart';
import 'package:flutter_api_test/components/home/classes.dart';
import 'package:flutter_api_test/config/application.dart';

List<Widget> getMatchDataTiles(BuildContext context, List<MatchListData> _matchList) {
  List<Widget> ret = [];
  if(_matchList.length > 0) {
    for (var i = 0; i < _matchList.length; i++) {
      MatchListData match = _matchList[i];
      Widget tile = new ListTile(
        title: new Text(
          _matchList[i].lane,
        ),
        subtitle: new Text(
            "Role:${match.role}, Champion:${match.champion}"
        ),
        onTap: () => Application.router.navigateTo(context, "/match_detail?matchId=${match.gameId}"),
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

Widget searchButton(Function searchFunction) {
  return FlatButton(
    child: Column(
      children: <Widget>[
        Icon(Icons.search),
        Text("Search")
      ],
    ),
    padding: EdgeInsets.all(2.0),
    onPressed: searchFunction,
    color: Colors.blue,
    textColor: Colors.white,
  );
}

Widget textInput(TextEditingController controller) {
  return TextField(
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.grey[300],
      border: InputBorder.none,
      hintText: "Enter a Search Term",
    ),
    textAlign: TextAlign.center,
    controller: controller,
  );
}

Widget matchDataList(BuildContext context, List<MatchListData> _matchList) {
  return Expanded(
    child: ListView(
      children: getMatchDataTiles(context, _matchList),
    ),
  );
}