import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:safeguardclient/bloc/blocs.dart';
import 'package:safeguardclient/bloc/local.dart';
import 'package:safeguardclient/pages/home_page.dart';
import 'package:safeguardclient/pages/main_page.dart';
import 'package:safeguardclient/pages/sign_in_page.dart';
import 'package:safeguardclient/pages/splash_page.dart';
import 'package:safeguardclient/pages/wrapper.dart';
import 'package:safeguardclient/services/message_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
 final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: 0,
      value: null,
      child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => PageBloc()),
            BlocProvider(create: (_) => ThemeBloc()),
            BlocProvider(
        create: (_) => NotificationBloc(flutterLocalNotificationsPlugin),
      ),
          ],
          child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (_, themeState) => MaterialApp(
                  theme: themeState.themeData,
                  debugShowCheckedModeBanner: false,
                  home: Wrapper()))),
    );
  }
}
