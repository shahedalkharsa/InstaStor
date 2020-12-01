import 'package:flutter/material.dart';
import './question-list.dart';

class QAScreen extends StatelessWidget {
  static String routeName = "/QA";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Q&A",
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, QAScreen.routeName);
        },
        child: Icon(Icons.arrow_back),
        backgroundColor: Colors.pink,
        elevation: 6,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              QuestionList(
                  question: "How do I change my personal information?",
                  answer:
                      "•	Log in to your account \n•	Click on My Profile at the top left of the page \n•	Click on Edit \n•	Edit the info you would like to modify \n•	Press the Save button. "),
              QuestionList(
                  question: "How do I reset my password?",
                  answer:
                      "•	Log in to your account \n•	Click on My Profile at the top left of the page \n•	Click on Account Information \n•	Click on the Change Password check box \n•	Fill in the required fields \n•	Press the Save button."),
              QuestionList(
                  question: "How can I pay for my order?",
                  answer:
                      "You can pay for your order using credit card, or in cash on delivery."),
              QuestionList(
                  question: "Which Currency is accepted?",
                  answer: "We accept Saudi Riyal only."),
              QuestionList(
                  question:
                      "Will I get discount when ordering large quantities?",
                  answer:
                      "There will be no additional discounts for larger quantities. However, always keep an eye out for different offers, bundles, and sales that are often available on our application"),
              QuestionList(
                  question: "Can I cancel or modify my orders?",
                  answer:
                      "As long as the order is not confirmed, you can contact us to cancel the order."),
              SizedBox(
                child: Image.asset('assets/images/logo.png'),
                height: 60,
                width: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
