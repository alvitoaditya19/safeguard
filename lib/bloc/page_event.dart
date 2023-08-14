part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GoToSplashPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToSignInPage extends PageEvent {
  @override
  List<Object> get props => [];
}
class GoToMainPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToRecentPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToStartMenu extends PageEvent {
  @override
  List<Object> get props => [];
}

