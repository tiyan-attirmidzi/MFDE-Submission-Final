import 'package:flutter/material.dart';
import 'package:meals_catalogue_final/views/view_home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals Catalogue',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ViewHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

