import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messages/screens/home.dart';
import 'package:messages/screens/login.dart';
import 'package:messages/screens/register.dart';
import 'package:messages/screens/welcome.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Color.fromRGBO(250, 185, 3, 0.9),
            ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: _auth.currentUser != null ? '/home' : '/welcome',
      routes: {
        "/welcome": (context) => Welcome(),
        "/login": (context) => Login(),
        "/register": (context) => Register(),
        "/home": (context) => Home()
      },
    );
  }
}
