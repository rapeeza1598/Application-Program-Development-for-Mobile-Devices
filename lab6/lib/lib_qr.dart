import 'dart:io';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class LabQR extends StatefulWidget {
  const LabQR({super.key});

  @override
  State<LabQR> createState() => _LabQRState();
}

class _LabQRState extends State<LabQR> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  var result = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'QR Code and Image',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  filePicker();
                },
                child: Text("123 Caprure")),
            SizedBox(
              height: 20,
            ),
            image == null
                ? Text("image here")
                : Image.file(File(image!.path), width: 250)
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          scanQR();
        },
        label: Text("Scan $result"),
        icon: Icon(Icons.qr_code),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void filePicker() async {
    final XFile? selectImage =
        await _picker.pickImage(source: ImageSource.camera);
    // await _picker.pickImage(source: ImageSource.gallery);
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
}
