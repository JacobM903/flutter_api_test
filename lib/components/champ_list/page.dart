import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_api_test/components/champ_list/widgets.dart';


class ChampListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('champions').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text("Error Retreiving champion list: ${snapshot.error}");
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return CircularProgressIndicator();
          default:
            return new Scaffold(
              appBar: AppBar(
                title: new Text("Champion List"),
              ),
              body: ListView(
                padding: EdgeInsets.all(3.0),
                children: snapshot.data.documents.map((DocumentSnapshot document) {
                  return champTile(context, document);
                }).toList(),
              ),
            );
        }
      }
    );
  }
}