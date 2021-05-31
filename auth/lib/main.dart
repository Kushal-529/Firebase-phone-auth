import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Language.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      home: SelectLanguage(),
      theme: ThemeData(
        accentColor: Colors.indigoAccent,
      ),
    );
  }
}
