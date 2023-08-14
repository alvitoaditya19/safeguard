import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  late DatabaseReference _databaseReference;

  FirebaseService() {
    _databaseReference = FirebaseDatabase.instance.reference().child('path');
  }

  void startRealtimeUpdates() {
    _databaseReference.onValue.listen((DatabaseEvent event) { // Change 'Event' to 'EventSnapshot'
      if (event.snapshot.value != null) {
        var data = event.snapshot.value;
        print(data);
      }
    });
  }

    Stream<DatabaseEvent> getDataStream() {
    return _databaseReference.onValue;
  }

}
