import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safeguardclient/bloc/blocs.dart';
import 'package:safeguardclient/pages/home_page.dart';
import 'package:safeguardclient/pages/main_page.dart';
import 'package:safeguardclient/shared/theme.dart';
import 'package:safeguardclient/widgets/buttons.dart';
import 'package:safeguardclient/widgets/forms.dart';
import 'package:safeguardclient/services/message_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:vibration/vibration.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  void _showLocalNotification() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Welcome!',
      'You have successfully signed in.',
      platformChannelSpecifics,
    );
  }

  void _handleSignIn() {
    // Perform your sign-in logic here
    context.read<PageBloc>().add(GoToMainPage());

    // Show a local notification
    // _showLocalNotification();
    // NotificationService()
    //         .showNotification(title: 'Sample title', body: 'It works!');
  }
  void _handleSignInn() {
    context.read<PageBloc>().add(GoToMainPage());
  }
    void _handleHome() {
    context.read<PageBloc>().add(GoToHomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 100,
              bottom: 50,
            ),
            width: 155,
            height: 50,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img-logo.png'),
              ),
            ),
          ),
          Text(
            "Sign In &\nEmergency our health",
            style: blackTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  label: "Email Address",
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  label: "Password",
                  isObscure: true,
                  controller: passwordController,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomFilledButton(
                  title: "Sign In",
                  onPressed: _handleSignIn,
                ),
                // ElevatedButton(
                //   onPressed:
                //       _handleHome, // You can add this directly as onPressed
                //   child: Text('Show Local Notification'),
                // ),
                // ElevatedButton(
                //   onPressed:
                //       _handleSignInn, // You can add this directly as onPressed
                //   child: Text('Show Local Notification'),
                // ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
