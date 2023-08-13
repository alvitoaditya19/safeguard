import 'dart:async';

import 'package:flutter/material.dart';
import 'package:safeguardclient/pages/sign_in_page.dart';

import '../../shared/theme.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 3),
        () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      "/sign-in",
                      (route) => false,
                    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 160,
              width: 160,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img-shiled.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
