
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';
import 'package:test_notivication/main.dart';

class FirebaseApi{
  // create an instance of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // function to initailize notification
  Future<void> initNotifications() async{
    // request permission from user (will prompt user)
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: false,
    );

    //fetch the FCM token for this device
    final fCMToken = await _firebaseMessaging.getToken();
    print("Token: $fCMToken");

    //initailize further setting of notivication
    initPushNotivications();
    initPlatformState();
    // initPlatformState();
    // FlutterAppBadger.updateBadgeCount(1);
    //FlutterDynamicIcon.setApplicationIconBadgeNumber(5);
  }
  // function to handle received messages
  void handleMessage(RemoteMessage? message){
    //if the message is null, do nothing

    if(message == null ) return;

    //navigator to new screen when message is received and user tap notivication
    navigatorkey.currentState?.pushNamed(
      '/notivication_screen',
      arguments: message
    );
  }

  // function to initailize foreground and backgroud settings
  Future initPushNotivications() async{
    //handle notivication if the app was terminated and now open
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    //attach event listeners for when a notivication opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
  String _appBadgeSupported = 'Unknown';
  initPlatformState() async {
    String appBadgeSupported;
    try {
      bool res = await FlutterAppBadger.isAppBadgeSupported();
      if (res) {
        appBadgeSupported = 'Supported';
      } else {
        appBadgeSupported = 'Not supported';
      }
    } on PlatformException {
      appBadgeSupported = 'Failed to get badge support.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) return;
    _appBadgeSupported = appBadgeSupported;
    FlutterAppBadger.updateBadgeCount(5);
    print("======My work");
  }
}