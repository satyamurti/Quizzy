import 'package:flutter/material.dart';
import 'package:quizzy/models/category.dart';
import 'package:quizzy/pages/quiz_page.dart';

class AddQuiz extends StatefulWidget {
  final CategoryModel categoryModel;

  const AddQuiz({Key key, this.categoryModel}) : super(key: key);

  @override
  _AddQuizState createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  int groupValue = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController oneController = TextEditingController();
  TextEditingController twoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ))),
                  ),
                  RadioListTile(
                    groupValue: groupValue,
                    value: 0,
                    title: TextField(
                      controller: oneController,
                    ),
                    onChanged: (t) {
                      setState(() {
                        groupValue = 0;
                      });
                    },
                  ),
                  RadioListTile(
                    groupValue: groupValue,
                    value: 1,
                    title: TextField(
                      controller: twoController,
                    ),
                    onChanged: (t) {
                      setState(() {
                        groupValue = 1;
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      List<String> all = [];
                      all.add(oneController.text);
                      all.add(twoController.text);
                      var correct = all[groupValue];
                      all.removeAt(groupValue);
                      QuizModel quizModel = QuizModel(
                        name: titleController.text,
                        correct: correct,
                        incorrect: all,
                      );
                      print(all);
                      widget.categoryModel.quizList.add(quizModel);
                      oneController.clear();
                      twoController.clear();
                      titleController.clear();
                    },
                    child: Text("ADD"),
                    color: Colors.green.withOpacity(0.2),
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => QuizPage(
                                  quizList: widget.categoryModel.quizList,
                                )));
                      },
                      child: Text("START"),
                      color: Colors.redAccent.withOpacity(0.2)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
