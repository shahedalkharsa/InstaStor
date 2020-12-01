import 'package:flutter/material.dart';

class QuestionList extends StatelessWidget {
  final String question;
  final String answer;
  const QuestionList({
    Key key,
    @required this.question,
    @required this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.centerRight,
                colors: [Colors.pink[50], Colors.pink[100]]),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Column(
          children: <Widget>[
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                question,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )),
            Center(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 30, right: 10, left: 10),
              child: Text(
                answer,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 17.1),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
