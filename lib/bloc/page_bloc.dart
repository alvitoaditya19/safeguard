import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:safeguardclient/pages/main_page.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(OnInitialPage()) {
    on<PageEvent>((event, emit) async {
      if (event is GoToSplashPage) {
        emit(OnSplashPage());
      }else if (event is GoToSignInPage) {
        emit(OnSignIn());
      } else if (event is GoToMainPage) {
        emit(OnMainPage());
      } 
    });
  }
}
