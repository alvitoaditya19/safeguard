import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:safeguardclient/services/message_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('path');
       int _previousDataCount = 0;
           void _checkAndShowNotification() async {
    final snapshot = await _databaseReference.once();
    final newDataCount = snapshot.snapshot.children.length; // Menghitung jumlah data saat ini
      print("jumlah $newDataCount");


    if (newDataCount > _previousDataCount) {
      print("Berhasil");
      NotificationService()
          .showNotification(title: 'Sample title', body: 'It works!');
    }

    _previousDataCount = newDataCount; // Memperbarui jumlah data sebelumnya
  }
  @override
  void initState() {
    super.initState();
    // getDataStream();
      WidgetsBinding.instance.addPostFrameCallback((_) {
    // _databaseReference.onChildAdded.listen((event) {
    //   print("Berhasil");
    //   NotificationService()
    //       .showNotification(title: 'Sample title', body: 'It works!');
    // });

     _databaseReference.once().then((snapshot) {
      _previousDataCount = snapshot.hashCode; // Menghitung jumlah data awal
      
      _databaseReference.onChildAdded.listen((event) {
        _checkAndShowNotification();
      });
    });
  });

    // _databaseReference.onChildAdded.listen((event) {
    //   print("Berhasil");
    //   NotificationService()
    //       .showNotification(title: 'Sample title', body: 'It works!');
    // });
    // _databaseReference.onValue.listen((DatabaseEvent event) {
    //   // Change 'Event' to 'EventSnapshot'
    //   if (event.snapshot.value == "14") {
    //     var data = event.snapshot.value;
    //     print(data);
    //     print("Berhasil");
    //     NotificationService()
    //         .showNotification(title: 'Sample title', body: 'It works!');
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification example'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              child: Text('show notification'),
              onPressed: () async {
                showNotification();
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              child: Text('show notification'),
              onPressed: () async {
                NotificationService()
                    .showNotification(title: 'Sample title', body: 'It works!');
              },
            ),
          ),
        ],
      ),
    );
  }

  showNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high channel',
      'Very important notification!!',
      description: 'the first notification',
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin.show(
      1,
      'my first notification',
      'a very long message for the user of app',
      NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
            channelDescription: channel.description),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:safeguardclient/pages/home_page.dart';
// import 'package:safeguardclient/services/data_realtime.dart';
// import 'package:safeguardclient/shared/theme.dart';
// import 'package:safeguardclient/widgets/buttons.dart';
// import 'package:safeguardclient/widgets/forms.dart';
// import 'package:safeguardclient/services/message_service.dart';
// import 'package:firebase_database/firebase_database.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   FirebaseService firebaseService = FirebaseService();
//   String dataDariFirebase = '';

//   @override
//   void initState() {
//     super.initState();
//     firebaseService.getDataStream();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: whiteColor,
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Container(
//             margin: EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   // height: 20,
//                 ),
//                 Center(
//                   child: Text(
//                     'Gula Darah',
//                     style: blackTextStyle.copyWith(
//                       fontSize: 32,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 50,
//                 ),
//                 Container(
//                   width: double.infinity,
//                   height: 280,
//                   margin: EdgeInsets.symmetric(horizontal: 24),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: Color(0xffF40808).withOpacity(0.21),
//                       width: 10,
//                     ),
//                   ),
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       SizedBox(
//                         child: StreamBuilder<DatabaseEvent>(
//                           stream: firebaseService.getDataStream(),
//                           builder: (BuildContext context,
//                               AsyncSnapshot<DatabaseEvent> snapshot) {
//                             if (snapshot.hasData && snapshot.data != null) {
//                               // Process the data
//                               dataDariFirebase =
//                                   snapshot.data!.snapshot.value.toString();
//                             }
//                             return Text(
//                               '$dataDariFirebase mg/dL',
//                               style: blackTextStyle.copyWith(
//                                 fontSize: 30,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),

//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
