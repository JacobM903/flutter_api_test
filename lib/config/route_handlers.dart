import 'package:flutter_api_test/components/match_detail/page.dart';

import '../components/home/page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

var rootHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new MyHomePage();
    });

var matchDetailHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String matchId = params["matchId"]?.first;
      return new MatchDetailPage(matchId: matchId);
    });
