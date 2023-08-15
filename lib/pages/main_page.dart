import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:safeguardclient/pages/webview_page.dart';
import 'package:safeguardclient/services/message_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('data');
  List<Map<String, dynamic>> _dataList = [];
  bool _isFirstCheck = true;
  String _data = "Data belum ada";
  String _name = "Nama belum ada";
  String _address = "Alamat belum ada";
  String _education = "Pendidikan belum ada";
  bool _firstDataLoad = true;

  @override
  void initState() {
    super.initState();
    _databaseReference.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> data =
            event.snapshot.value as Map<dynamic, dynamic>;
        if (data.containsKey('name')) {
          setState(() {
            _name = data['name'];
          });
        }
        if (data.containsKey('address')) {
          setState(() {
            _address = data['address'];
          });
        }

        // Hanya tampilkan notifikasi saat bukan kali pertama memuat data
        if (!_firstDataLoad) {
          NotificationService().showNotification(
            title: 'Name $_name',
            body: 'Location $_address',
          );
        }

        if (_firstDataLoad) {
          _firstDataLoad =
              false; // Set variabel _firstDataLoad menjadi false setelah memuat data pertama kali
        }

        print("Data telah berubah: Nama: $_name, Alamat: $_address");
      }
    });
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
              child: Text('Show Notification'),
              onPressed: () async {
                showNotification();
              },
            ),
          ),
          Text(
            '$_data',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Center(
            child: ElevatedButton(
              child: Text('Show Data Notification'),
              onPressed: () async {
                if (_dataList.isNotEmpty) {
                  NotificationService().showNotification(
                    title: _dataList[0]["name"],
                    body: 'It works!',
                  );
                }
              },
            ),
          ),
          ElevatedButton(
            child: Text('Show Data Notification'),
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyWebViewPage();
              }));
            },
          ),
        ],
      ),
    );
  }

  showNotification() async {
    // Same as your existing showNotification() method
  }
}
