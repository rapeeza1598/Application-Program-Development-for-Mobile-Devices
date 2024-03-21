import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab10/home.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class MyBio extends StatefulWidget {
  const MyBio({super.key});

  @override
  State<MyBio> createState() => _MyBioState();
}

class _MyBioState extends State<MyBio> {
  late final LocalAuthentication _localAuth;
  bool _supportState = false;

  @override
  void initState() {
    super.initState();
    _localAuth = LocalAuthentication();
    _localAuth.isDeviceSupported().then((bool isSupported) {
      setState(() {
        _supportState = isSupported;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Bio', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.green[700],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_supportState)
              const Text('Biometric Supported')
            else
              const Text('Biometric Not Supported'),
            const Divider(
              height: 100,
            ),
            ElevatedButton(
                onPressed: () {
                  _getBio();
                },
                child: const Text('Get Device Supported')),
            const Divider(
              height: 100,
            ),
            ElevatedButton(
                onPressed: () {
                  _authenticate();
                },
                child: const Text('Authenticate')),
          ],
        ));
  }

  void _getBio() async {
    List<BiometricType> availableBiometics =
        await _localAuth.getAvailableBiometrics();
    print("List of available biometrics: $availableBiometics");
    if (!mounted) return;
  }

  void _authenticate() async {
    try {
      final bool authenticated = await _localAuth.authenticate(
          localizedReason: 'Authenticate to access your device',
          options: const AuthenticationOptions(
            stickyAuth: true,
            // biometricOnly: false,
            biometricOnly: true,
          ));
      if (authenticated) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyHome()),
            (route) => false);
      }
    } on PlatformException catch (e) {
      if (e.code == auth_error.lockedOut) {
        _errorAuthenticatLimit();
      } else
        print(e);
    }
  }

  void _errorAuthenticatLimit() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('You have reached the limit of attempts'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'))
            ],
          );
        });
  }
}
