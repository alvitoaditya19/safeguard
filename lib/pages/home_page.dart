import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safeguardclient/bloc/blocs.dart';
import 'package:safeguardclient/services/message_service.dart';
import 'package:safeguardclient/shared/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('data');
  List<Map<String, dynamic>> _dataList = [];
  bool _isFirstCheck = true;
  String _data = "Data belum ada";
  String _name = "Nama belum ada";
  String _address = "https://goo.gl/maps/vWv3AmSWaGbaCJyV7";
  String _education = "Pendidikan belum ada";
  String _status = "yes";
  WebViewController? _controller;
  bool _firstDataLoad = true;
  Future<void> _showStatusAlertDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Status'),
          content: Text('Apakah Anda ingin mengubah status menjadi "No"?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                _updateStatus("no");

                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                context.read<PageBloc>().add(GoToMainPage());
                Navigator.of(context).pop();

              },
            ),
          ],
        );
      },
    );
  }

  void _updateStatus(String newStatus) {
    _databaseReference.update({'status': newStatus});
  }

  @override
  void initState() {
    super.initState();
    _databaseReference.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> data =
            event.snapshot.value as Map<dynamic, dynamic>;
        if (data.containsKey('status')) {
          setState(() {
            _status = data['status'];
          });
        }
        if (data.containsKey('address')) {
          setState(() {
            _address = data['address'];
          });
          _controller?.loadUrl(_address);
        }
        if (data.containsKey('status')) {
          setState(() {
            _status = data['status'];
          });
          if (_status == "yes") {
            _showStatusAlertDialog();
          }
        }

        // Hanya tampilkan notifikasi saat bukan kali pertama memuat data
        if (!_firstDataLoad && _status != "no") {
          NotificationService().showNotification(
              title: 'Name $_name',
              body: 'Location $_address',
              payLoad: _address);
        }

        if (_firstDataLoad) {
          _firstDataLoad =
              false; // Set variabel _firstDataLoad menjadi false setelah memuat data pertama kali
        }

        print("Data telah berubah: Nama: $_name, Alamat: $_status");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [Text("hai")],
      ),
    );
  }
}
