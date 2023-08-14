import 'package:bloc/bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Event
abstract class NotificationEvent {}

class DataAddedEvent extends NotificationEvent {
  final int newDataCount;

  DataAddedEvent(this.newDataCount);
}

// State
class NotificationState {
  final String title;
  final String body;

  NotificationState(this.title, this.body);
}

// BLoC
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final FlutterLocalNotificationsPlugin _notificationPlugin;

  NotificationBloc(this._notificationPlugin) : super(NotificationState('', ''));

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is DataAddedEvent) {
      yield NotificationState('New Data Added', 'Data count: ${event.newDataCount}');
      _showNotification(event.newDataCount);
    }
  }

  void _showNotification(int newDataCount) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your_channel_id', 'your_channel_name',
            importance: Importance.max, priority: Priority.high);

    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await _notificationPlugin.show(
        0, state.title, state.body, platformChannelSpecifics,
        payload: 'item x'); // You can customize the payload if needed
  }
}
