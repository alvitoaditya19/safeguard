import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _subscribeToTopic(); // Subscribe to topic to receive notifications
  }

  void _subscribeToTopic() {
    _firebaseMessaging.subscribeToTopic('new_posts'); // Subscribe to topic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Real-time Notifications'),
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Column(children: [Text("data")]),
      )),
      // body: StreamBuilder<QuerySnapshot>(
      //   stream: _firestore.collection('posts').snapshots(),
      //   builder: (context, snapshot) {
      //     if (!snapshot.hasData) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     final documents = snapshot.data!.docs;

      //     return ListView.builder(
      //       itemCount: documents.length,
      //       itemBuilder: (context, index) {
      //         final document = documents[index];
      //         final title = document['title'] ?? 'No title';
      //         return ListTile(
      //           title: Text(title),
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }
}
