import 'package:flutter/material.dart';
import 'package:flutter_api_test/home/classes.dart';

List<Widget> getMatchDataTiles(List<MatchListData> _matchList) {
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