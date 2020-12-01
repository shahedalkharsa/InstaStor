import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreRegisterScreen extends StatelessWidget {
  static String routeName = "/storeRegister";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, StoreRegisterScreen.routeName);
        },
        child: Icon(Icons.arrow_back),
        backgroundColor: Colors.pink,
        elevation: 6,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.grey[100]],
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter)),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Image.asset('assets/images/logo.png'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.centerRight,
                        colors: [Colors.pink[50], Colors.pink[100]]),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Center(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "If you want to register your store please",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: Colors.pink,
                        onPressed: _launchURL,
                        child: Text(
                          "Click Here",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Fill up the required information",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_launchURL() async {
  const url = 'https://forms.gle/LMuJVMdLfWeAocdS6';

  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: false);
  } else {
    throw 'Could not launch $url';
  }
}
