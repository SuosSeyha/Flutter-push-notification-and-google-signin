//=========== FOR NOTIVICATION Main() ================
/*
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_notivication/push_notivication/API/firebase_api.dart';
import 'package:test_notivication/push_notivication/page/notivication_page.dart';
import 'push_notivication/page/home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}
final navigatorkey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const Homepage(),
      navigatorKey: navigatorkey,
      routes: {
        '/notivication_screen':(context) => const NotivicationPage()
      },
    );
  }
}
*/


//=========== FOR Google Signin Main() ================
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:test_notivication/facebook_signin/page/facebook_page.dart';
import 'package:test_notivication/google_singin/page/login_page.dart';
import 'package:test_notivication/phone_number_login/page/phoneNumber_login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
final navigatorkey = GlobalKey<NavigatorState>();// This statment use for push notivication
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
     // home:  const GoogleSignInScreen(),
   // home:  FacebookPage(),
    home:  PhoneNumberLogin(),
    );
  }
}



