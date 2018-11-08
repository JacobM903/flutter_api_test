import 'package:flutter/material.dart';

class ChampList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('champs').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text("Error Retreiving champion list: ${snapshot.error}");
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return CircularProgressIndicator();
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  title: new Text(document['name']),
                  subtitle: new Text(document['title'])
                );
              }).toList(),
            );
        }
      }
    );
  }
}