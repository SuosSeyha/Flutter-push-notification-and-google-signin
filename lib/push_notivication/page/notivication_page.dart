import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
class NotivicationPage extends StatelessWidget {
  const NotivicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // get the notivication message and display on screen
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text("NotivicationPage"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(message.notification!.title.toString(),),
          Text(message.notification!.body.toString(),),
          Text(message.data.toString(),),
        ],
      ),
    );
  }
}