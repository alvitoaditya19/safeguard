import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:safeguardclient/pages/home_page.dart';
import 'package:safeguardclient/pages/sign_in_page.dart';
import 'package:safeguardclient/pages/splash_page.dart';
import 'package:safeguardclient/services/message_service.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationService().initNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) => SplashPage(),
        "/sign-in": (context) => const SignInPage(),
        "/home": (context) =>  HomePage(),

      },
    );
  }
}
