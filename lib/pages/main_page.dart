import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
  String _address = "https://goo.gl/maps/vWv3AmSWaGbaCJyV7";
  String _education = "Pendidikan belum ada";
  bool _firstDataLoad = true;
  late WebView _webView;
  WebViewController? _controller;
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
          _controller?.loadUrl(_address);
        }

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

        print("Data telah berubah: Nama: $_name, Alamat: $_address");
      }
    });
  }

  bool isLoading = true;
  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Location | $_address",
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
