import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:safeguardclient/bloc/blocs.dart';
import 'package:safeguardclient/pages/webview_page.dart';
import 'package:safeguardclient/services/message_service.dart';
import 'package:safeguardclient/shared/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  String _status = "no";

  String _address = "https://goo.gl/maps/vWv3AmSWaGbaCJyV7";
  String _education = "Pendidikan belum ada";
  bool _firstDataLoad = true;
  late WebView _webView;
  WebViewController? _controller;

  Future<void> _showStatusAlertDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Status'),
          content: Text('Apakah Anda ingin mengubah status menjadi "No"?'),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                // _updateStatus("no");
                _databaseReference.update({'name': 'dfd', 'status': 'vvvv'});

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateStatus(String newStatus) async {
    _databaseReference.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> data =
            event.snapshot.value as Map<dynamic, dynamic>;
        data.containsKey('status').update(key, (value) => null);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _databaseReference.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> data =
            event.snapshot.value as Map<dynamic, dynamic>;
        _showStatusAlertDialog();
        if (data.containsKey('name')) {
          setState(() {
            _name = data['name'];
          });
        }
        if (data.containsKey('address')) {
          setState(() {
            _address = data['address'];
          });
          _controller?.loadUrl(_address);
        }

        // if (data.containsKey('status')) {
        //   setState(() {
        //     _status = data['status'];
        //   });
        //   if (_status == "yes") {
        //     _showStatusAlertDialog();
        //     print("dddddddddddddddddddddddddd");
        //   }
        // }

        // Hanya tampilkan notifikasi saat bukan kali pertama memuat data
        if (!_firstDataLoad) {
          NotificationService().showNotification(
              title: 'Name $_name',
              body: 'Location $_address',
              payLoad: _address);
        }

        if (_firstDataLoad) {
          _firstDataLoad =
              false; // Set variabel _firstDataLoad menjadi false setelah memuat data pertama kali
        }

        print(
            "Data telah berubah: Nama: $_name, Alamattttttttttt: $_address, Status: $_status");
      }
    });
  }

  bool isLoading = true;
  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: whiteColor),
            onPressed: () {
              context.read<PageBloc>().add(GoToHomePage());
            },
          ),
          title: Text(
            "Location",
            style: whiteTextStyle,
          ),
          backgroundColor: blueColor,
        ),
        body: Stack(
          children: [
            Container(
                child: WebView(
              key: _key,
              initialUrl: _address, // Set initialUrl to _address
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController controller) {
                _controller = controller;
              },
              onPageFinished: (finish) {
                // No need to reload the URL here, it's already loaded
                setState(() {
                  isLoading =
                      false; // Set isLoading to false when page finishes loading
                });
              },
            )),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(),
          ],
        ));
  }

  showNotification() async {
    // Same as your existing showNotification() method
  }
}
