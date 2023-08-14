import 'package:flutter/material.dart';
import 'package:safeguardclient/bloc/blocs.dart';
import 'package:safeguardclient/pages/home_page.dart';
import 'package:safeguardclient/pages/main_page.dart';
import 'package:safeguardclient/pages/sign_in_page.dart';
import 'package:safeguardclient/pages/splash_page.dart';
import 'package:safeguardclient/services/data_realtime.dart';
import 'package:safeguardclient/shared/theme.dart';
import 'package:safeguardclient/widgets/buttons.dart';
import 'package:safeguardclient/widgets/forms.dart';
import 'package:safeguardclient/services/message_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wrapper extends StatefulWidget {
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => (pageState is OnSplashPage)
            ? SplashPage()
            : (pageState is OnSignIn)
                ? SignInPage()
                : (pageState is OnMainPage)
                    ? MainPage()
                    : SplashPage());
  }
}
