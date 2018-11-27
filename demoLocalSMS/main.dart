import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(new MaterialApp(
    title: "Rotation Demo",
    home: new SendSms(),
  ));
}


class SendSms extends StatefulWidget {
  @override
  _SendSmsState createState() => new _SendSmsState();
}

class _SendSmsState extends State<SendSms> {
  static const platform = const MethodChannel('sendSms');

  Future<Null> sendSms()async {
    print("SendSMS");
    try {
      final String result = await platform.invokeMethod('send',<String,dynamic>{"phone":"+8860928501581","msg":"Hello! 333555"}); //Replace a 'X' with 10 digit phone number
      print(result);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Container(
        alignment: Alignment.center,
        child: new FlatButton(onPressed: () => sendSms(), child: const Text("Send SMS")),
      ),
    );
  }
}