import 'dart:ui';
import 'package:rflutter_alert/rflutter_alert.dart' show Alert;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = new QuizBrain();

void main() => runApp(Quizzy());

class Quizzy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            backgroundColor: Colors.black,
            title: Center(
              child: Text(
                  'Quizzy',
                      style: TextStyle(
                        fontFamily: 'AmaticSC',
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                        decorationThickness: 0.7,
                        letterSpacing: 1,
                        height: 1,
                        color:Colors.white70
                      ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Quizpage(),
          ),
        ),
      ),
    );
  }
}

class Quizpage extends StatefulWidget {
  @override
  _QuizpageState createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  List<Icon> scoreKeeper = [];

  void checkAnswers(bool userPickedAnswers) {
    bool correctAnswers = quizBrain.getCorrectAnswers();
    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();
        quizBrain.reset();
        scoreKeeper=[];

      }
      else {
        if (userPickedAnswers == correctAnswers) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,

          ));
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
      }
      quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white70,
                    fontFamily: 'AmaticSC',
                    fontWeight: FontWeight.w900,
                    fontSize: 35,
                ),

              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                "True",
                style: TextStyle(
                    fontFamily: 'AmaticSC',
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Colors.black),
              ),
              onPressed: () {
                checkAnswers(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
                color: Colors.red,
                child: Text(
                  "False",
                  style: TextStyle(
                      fontFamily: 'AmaticSC',
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: Colors.black),
                ),
                onPressed: () {
                  checkAnswers(false);
                }),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
