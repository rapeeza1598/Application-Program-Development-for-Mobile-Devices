import 'dart:io';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  var result = 'Image here';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cemera Option",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image == null
                ? Text(result)
                : Image.file(File(image!.path), width: 250),
            ElevatedButton.icon(
              onPressed: () {
                cemaraCap();
                menuCounter(1);
              },
              icon: Icon(
                Icons.camera,
                color: Colors.redAccent,
              ),
              label: Text("Camera Capture"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                filePicker();
                menuCounter(2);
              },
              icon: Icon(
                Icons.image,
                color: Colors.yellowAccent,
              ),
              label: Text("Select Image for Gallery"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                scanQR();
                menuCounter(3);
              },
              icon: Icon(Icons.qr_code, color: Colors.cyanAccent),
              label: Text("QR Code Scaner"),
            )
          ],
        ),
      ),
    );
  }

  void cemaraCap() async {
    final XFile? captureImage =
        await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      image = captureImage;
    });
  }

  void filePicker() async {
    final XFile? selectImage =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = selectImage;
    });
  }

  void scanQR() async {
    try {
      ScanResult qrCode = await BarcodeScanner.scan();
      setState(() {
        result = qrCode.rawContent;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result = "Camera Access Denied";
        });
      } else {
        setState(() {
          result = "Unklown an Access Denied";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before the scan";
      });
    } catch (e) {
      setState(() {
        result = "Unklown error $e";
      });
    }
  }

  void menuCounter(int menu) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (menu == 1) {
      int _counter = (prefs.getInt('m1') ?? 0) + 1;
      prefs.setInt('m1', _counter);
    }
    if (menu == 2) {
      int _counter = (prefs.getInt('m2') ?? 0) + 1;
      prefs.setInt('m2', _counter);
    }
    if (menu == 3) {
      int _counter = (prefs.getInt('m3') ?? 0) + 1;
      prefs.setInt('m3', _counter);
    }
  }
}
