import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScoreBoardState();
  }
}

class _ScoreBoardState extends State<ScoreBoard> {
  String _haveStarted3Times = 'Hello ';

  @override
  void initState() {
    super.initState();
    _incrementStartup();
  }

  Future<int> _getIntFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final score = prefs.getInt('score');
    setState(() => _haveStarted3Times = 'Your Score is $score');
    if (score == null) {
      return 0;
    }
    return score;
  }

  Future<void> _incrementStartup() async {
    final prefs = await SharedPreferences.getInstance();

    int score = await _getIntFromSharedPref();
    setState(() => _haveStarted3Times = '$score is Your Score');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          _haveStarted3Times,
          style: TextStyle(fontSize: 32),
        ),
      ),
    );
  }
}
