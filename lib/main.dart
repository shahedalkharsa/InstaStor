import './views/splash.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import './config/palette.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import './routes.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LitAuthInit(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          theme: ThemeData(
            fontFamily: 'Avenir',
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.muliTextTheme(),
            accentColor: Palette.darkPink,
            appBarTheme: const AppBarTheme(
              brightness: Brightness.dark,
              color: Palette.darkPink,
            ),
          ),
          home: AnimatedSplashScreen(
            splashIconSize: 250,
            splash: Image.asset('assets/images/logo.png'),
            nextScreen: SplashScreen(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.white,
            duration: 2500,
          ),
          routes: routes,
          initialRoute: '/'),
    );
  }
}
