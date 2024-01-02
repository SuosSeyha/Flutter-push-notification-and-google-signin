import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';
class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: const Text("Hompage"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Tap icon"),
          onPressed: () async{
           await FlutterAppBadger.updateBadgeCount(5);
          },
        ),
      ),
    );
  }
}