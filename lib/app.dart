import 'package:flutter/material.dart';
import 'package:quizzy/pages/CategoryPage.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quizzzy",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      home: CategoryPage(),
    );
  }
}
