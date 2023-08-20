import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safeguardclient/bloc/blocs.dart';
import 'package:safeguardclient/services/message_service.dart';
import 'package:safeguardclient/shared/theme.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('data');
  final DatabaseReference _databaseReferenceAdmin =
      FirebaseDatabase.instance.reference().child('dataAdmin');
  List<Map<String, dynamic>> _dataList = [];
  bool _isFirstCheck = true;
  String _data = "Data belum ada";
  String _name = "Nama belum ada";
  String _address = "https://goo.gl/maps/vWv3AmSWaGbaCJyV7";
  String _education = "Pendidikan belum ada";
  double _longitude = 0;
  double _latitude = 0;
  String _position = "Karawang";
  String _noHPPat = "081382739430";

  String _status = "yes";
  WebViewController? _controller;
  bool _firstDataLoad = true;

  double _x = 0.0;
  double _y = 0.0;
  double _z = 0.0;
  double a = 0.0;
  String pesan = "Patient Safe";
  String _applicationStatus = "Application Active";

  String? _currentAddress;
  Position? _currentPosition;

  bool _isAccelerometerActive = false;
  Future<void> _showStatusAlertDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Patient Fallen!!!!',
              style: redTextStyle.copyWith(
                fontSize: 14,
                fontWeight: medium,
              )),
          content: Text('Do you want to go to the patient location directly??',
              style: blackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: medium,
              )),
          actions: <Widget>[
            TextButton(
              child: Text(
                'No',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Yes',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
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

 void _launchURL(url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  void initState() {
    super.initState();

    _databaseReferenceAdmin.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> data =
            event.snapshot.value as Map<dynamic, dynamic>;
        if (data.containsKey('noHPPat')) {
          setState(() {
            _noHPPat = data['noHPPat'];
          });
        }
      }
    });
    _databaseReference.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> data =
            event.snapshot.value as Map<dynamic, dynamic>;
        if (data.containsKey('status')) {
          setState(() {
            _status = data['status'];
          });
        }
        if (data.containsKey('latitude')) {
          setState(() {
            _latitude = data['latitude'];
          });
        }
        if (data.containsKey('longitude')) {
          setState(() {
            _longitude = data['longitude'];
          });
        }
        if (data.containsKey('position')) {
          setState(() {
            _position = data['position'];
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

        if (!_firstDataLoad && _status != "no") {
          NotificationService().showNotification(
              title: '$_name Fallen!!',
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

  void _toggleAccelerometer() {
    setState(() {
      _status = "no";
    });
    Map<String, dynamic> updatedData = {
      'status': 'no',
    };
    _databaseReference.update(updatedData).then((_) {
      print("Data updated successfully");
    }).catchError((error) {
      print("Failed to update data: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: greenColor,
          title: Text(
            "Safeguard Admin",
            style: whiteTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            ),
          )),
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Data Location',
                      style: blackTextStyle.copyWith(
                        fontSize: 22,
                        fontWeight: semiBold,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      _status == "yes"
                          ? 'Latitude: ${_latitude}'
                          : "Latitude: 0",
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      _status == "yes"
                          ? 'Longitude: ${_longitude}'
                          : "Longitude: 0",
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      _status == "yes" ? 'Address: ${_position}' : "Address: 0",
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Data Patient',
                      style: blackTextStyle.copyWith(
                        fontSize: 22,
                        fontWeight: semiBold,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      _status == "yes"
                          ? 'Message: Patient Fallen'
                          : "Message: $pesan",
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    _status == "yes"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  'Have you treated\nyour patient?',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 22,
                                    fontWeight: semiBold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: _toggleAccelerometer,
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        primary: redColor),
                                    child: Text(
                                      'Yes',
                                      style: whiteTextStyle.copyWith(
                                        fontSize: 20,
                                        fontWeight: semiBold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  ElevatedButton(
                                   onPressed: () =>  _launchURL(_address),
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      primary:
                                          greenColor, // Set your desired background color here
                                    ),
                                    child: Text(
                                      'Open Maps',
                                      style: whiteTextStyle.copyWith(
                                        fontSize: 20,
                                        fontWeight: semiBold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: () => _launchURL("tel://$_noHPPat"),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  primary:
                                      blueColor, // Set your desired background color here
                                ),
                                child: Text(
                                  'Call Patient',
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 20,
                                    fontWeight: semiBold,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : SizedBox()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
