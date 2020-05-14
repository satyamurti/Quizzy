import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quizzy/models/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizPage extends StatefulWidget {
  final List<QuizModel> quizList;

  const QuizPage({Key key, this.quizList}) : super(key: key);
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<String> allAnswers = [];
  int questionNo = 0;
  Timer timer;
  int time = 10;
  int scores = 0;

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        if (time < 1) {
          t.cancel();
          nextQuestion();
        } else {
          time = time - 1;
        }
      });
    });
  }

  nextQuestion([int option]) {
    timer.cancel();
    if (option != null &&
        allAnswers[option] == widget.quizList[questionNo].correct) {
      scores++;
    }

    if (questionNo < widget.quizList.length - 1) {
      questionNo++;
      allAnswers = [];
      allAnswers.add(widget.quizList[questionNo].correct);
      allAnswers.addAll(widget.quizList[questionNo].incorrect);
      allAnswers.shuffle();
      time = 15;
      startTimer();
    } else {
      timer.cancel();
      showResult();
    }
  }

  showResult() async {
    addIntToSF(scores);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('score', scores);
    debugPrint("Current Score is $scores");
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Text(
          "Correct $scores",
          style: Theme.of(context).textTheme.display2,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("CANCEL"),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text("RETRY"),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => QuizPage(
                    quizList: widget.quizList,
                  )));
            },
          )
        ],
      ),
    );


  }
  addIntToSF(int scores) async {

  }

  @override
  void initState() {
    super.initState();
    allAnswers.add(widget.quizList[0].correct);
    allAnswers.addAll(widget.quizList[0].incorrect);
    allAnswers.shuffle();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "${questionNo + 1}",
                  // ignore: deprecated_member_use
                  style: Theme.of(context).textTheme.display1,
                ),
                Text(
                  "$time",
                  style: Theme.of(context).textTheme.display1,
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  widget.quizList[questionNo].name,
                  style: Theme.of(context).textTheme.display2,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        nextQuestion(0);
                      },
                      child: Text(allAnswers[0]),
                    ),
                    FlatButton(
                      onPressed: () {
                        nextQuestion(1);
                      },
                      child: Text(allAnswers[1]),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
