import 'package:flutter/material.dart';
import 'package:flutter_api_test/components/home/page.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  final FirebaseApp app = await FirebaseApp.configure(
      name: 'project-91575974677',
      options: const FirebaseOptions(
        googleAppID: '1:91575974677:android:a23918d4aeaa1c75',
        projectID: 'flutter-testing-f5088',
        apiKey: 'AIzaSyB-697eFqCekb12o7pVwCPcEDDrX_Y_uck '
      ),
  );
  final Firestore firestore = Firestore(app: app);
  await firestore.settings(timestampsInSnapshotsEnabled: true);


  runApp(MyApp(firestore: firestore,));
}

class MyApp extends StatelessWidget {
  MyApp({this.firestore});
  final Firestore firestore;
  CollectionReference get messages => firestore.collection('messages');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page', firestore: firestore),
    );
  }
}
