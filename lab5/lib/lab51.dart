import 'dart:math';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
/// The above class is the root of a Flutter application that uses the MaterialApp widget and sets the
/// theme and home page.

class Lab51 extends StatefulWidget {
  const Lab51({super.key});

  @override
  State<Lab51> createState() => _Lab51State();
}

class _Lab51State extends State<Lab51> {
  // int n = 0;
  var n = [0, 0, 0, 0];
  int otp = 0;
  var otp1 = [0, 0, 0, 0];

  gen_number() {
    // otp = Random().nextInt(5000) + 2500;
    for (var i = 0; i < otp1.length; i++) {
      otp1[i] = Random().nextInt(10);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      gen_number();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.graphic_eq_outlined, color: Colors.white),
          title: const Text(
            "Random OTP",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: double.infinity,
              height: 150,
              child: Container(
                  color: Colors.amber,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "OTP Number",
                        style: TextStyle(fontSize: 32),
                      ),
                      Text(
                        "${otp1[0]} ${otp1[1]} ${otp1[2]} ${otp1[3]}",
                        style: TextStyle(
                            fontSize: 48,
                            color: Colors.cyan,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.white),
                      )
                    ],
                  )),
            ),
            SizedBox(
              width: double.infinity,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image(image: AssetImage('assets/image/maxresdefault.jpg')),
                  Image(
                      image: AssetImage(
                          'assets/image/mid_1464595080574bf2880d109.jpg')),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 100,
              child: Container(
                  color: Colors.blueAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      for (int i = 0; i < 4; i++)
                        SizedBox(
                          width: 80,
                          height: 60,
                          child: Container(
                            color: Colors.white,
                            child: NumberPicker(
                                selectedTextStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 48),
                                textStyle: TextStyle(
                                    fontSize: 32, color: Colors.greenAccent),
                                itemCount: 2,
                                minValue: 0,
                                maxValue: 9,
                                infiniteLoop: true,
                                value: n[i],
                                onChanged: (int value) {
                                  setState(() {
                                    n[i] = value;
                                  });
                                }),
                          ),
                        )
                    ],
                  )),
            ),
            SizedBox(
              width: double.infinity,
              height: 80,
              child: Container(
                color: Colors.deepOrangeAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          gen_number();
                        });
                      },
                      child: Text("Gen OTP")),
                  ElevatedButton(
                      onPressed: () {
                        int counter = 0;
                        for (var i = 0; i < n.length; i++) {
                          if (n[i] == otp1[i]) {
                            counter++;
                          }
                        }
                        print(counter);
                        if (counter < n.length) {
                          checkNumber("Incorrect Number");
                        } else {
                          checkNumber("Correct Number");
                        }
                      },
                      child: Text("Check OTP"))
                ]),
              ),
            )
          ],
        ));
  }

  void checkNumber(String text) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Your number"),
              content: Text("Answer is $text"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"))
              ],
            ));
  }
}
