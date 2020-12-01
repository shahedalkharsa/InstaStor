import 'package:flutter/material.dart';
import 'package:instaStore/views/home/drawer/contact-us.dart';
import 'about-us.dart';
import 'QA.dart';
import '../../../config/palette.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import '../../auth/auth.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Palette.amber, Palette.darkPink])),
              child: Container(
                  child: Column(
                children: <Widget>[
                  Material(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    elevation: 10,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/logo.png",
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "InstaStore",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  )
                ],
              ))),
          ListTile(
            leading: Icon(
              Icons.question_answer,
              color: Colors.black,
            ),
            title: Text(
              "Q&A",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(QAScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Colors.black,
            ),
            title: Text(
              "About Us",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(AboutUsScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.phone,
              color: Colors.black,
            ),
            title: Text(
              "Contact Us",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(ContactUsScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
            title: Text(
              "Log Out",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              context.signOut();
              Navigator.of(context).push(AuthScreen.route);
            },
            focusColor: Colors.amber,
          ),
        ],
      ),
    );
  }
}
