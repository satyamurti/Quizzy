import 'dart:developer';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:quizzy/models/category.dart';
import 'package:quizzy/pages/score_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'adding_quiz.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: ListView.builder(
        itemBuilder: (context, index) => Card(
          elevation: 0.0,
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddQuiz(
                        categoryModel: categories[index],
                      )));
            },
            title: Text(
              categories[index].name,
              style: Theme.of(context).textTheme.title,
            ),
            trailing: CircleAvatar(
              child: Text("${categories[index].quizList.length}"),
            ),
          ),
        ),
        itemCount: categories.length,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white,
        backgroundColor: Colors.lightBlueAccent,
        buttonBackgroundColor: Colors.orangeAccent,
        height: 55,

        items: <Widget>[
        Icon(Icons.laptop_chromebook,size : 20, color:Colors.black),
        Icon(Icons.score,size : 20, color:Colors.black),
      ],
      animationCurve: Curves.bounceInOut,
      index: 0,
      animationDuration: Duration(milliseconds: 290),
      onTap: (index){
          if(index == 1){
            Navigator.push(context,MaterialPageRoute(
                builder: (context) {
                  return ScoreBoard();
                }));
          }

       // debugPrint("Current Index is $index");
      },),
      floatingActionButton: FloatingActionButton(
        onPressed: showCategory,
        child: Icon(Icons.add),
      ),
    );
  }

  showCategory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Category"),
        content: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: categoryController,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              categoryController.clear();
              Navigator.pop(context);
            },
            child: Text("CANCEL"),
          ),
          FlatButton(
            onPressed: () {
              setState(() {
                categories.add(CategoryModel(
                  name: categoryController.text,
                  quizList: [],
                ));
              });
              categoryController.clear();
              Navigator.pop(context);
            },
            child: Text("ADD"),
          ),
        ],
      ),
    );
  }
}
