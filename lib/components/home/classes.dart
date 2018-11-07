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
