import 'package:chat/utils/routes.dart';
import 'package:chat/views/Home_View.dart';
import 'package:chat/views/Login_View.dart';
import 'package:chat/views/Profile_View.dart';
import 'package:chat/views/SignUp_View.dart';
import 'package:chat/views/verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.brown,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: Colors.black,
              ),
        ),
      ),
      initialRoute:
          FirebaseAuth.instance.currentUser != null ? '/home' : '/signup',
      routes: {
        MyRoutes.SignUpRoute: ((context) => Signup_View()),
        MyRoutes.HomeRoute: ((context) => Home_view()),
        MyRoutes.LoginRoute: ((context) => Login_view()),
        MyRoutes.VerifyRoute: ((context) => OTP()),
        MyRoutes.ProfileRoute: ((context) => Profile_view()),
      },
    );
  }
}
