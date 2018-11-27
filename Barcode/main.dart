import 'package:flutter/material.dart';
// import 'package:barcode_flutter/barcode_flutter.dart';
import 'barcode_flutter.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:async';
import 'dart:typed_data';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String phoneNo;
  bool isLoading = true;
  String base64;
  @override
  void initState() {
    super.initState();
    isLoading = true;
  }

  toBarcode() {
    setState(() {
      print('toBarcode set loading is false ........................');
      print('toBarcode set loading is false ........................');

      var bytes = utf8.encode(this.phoneNo);
      // base64 = CryptoUtils.bytesToBase64(bytes);
      // FS230300490511
      // RlMyMzAzMDA0OTA1MTE=
      base64 = base64Encode(bytes);
      this.isLoading = false;      
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return new MaterialApp(
  //     title: 'Flutter Demo',
  //     theme: new ThemeData(
  //       primarySwatch: Colors.blue,
  //     ),
  //     home: new MyHomePage(codeList: [
  //       new BarCodeItem(type: BarCodeType.Code128, codeStr: "FS23030049MDUxMQ==", description: "Code128", hasText: true),
  //       new BarCodeItem(type: BarCodeType.Code128, codeStr: "123456MDUxMQ==", description: "Code128", hasText: true),
  //     ],)
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    final phonenumber = TextField(
      
      decoration: InputDecoration(hintText: 'Enter text ...'),
      onChanged: (value) {
        this.phoneNo = value;
      },
    );
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            this.isLoading = false;
            toBarcode();
          },
          color: Colors.lightBlueAccent,
          child: Text(
            'Pressed to Barcode...',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
    print('**************************isLogin=' + this.isLoading.toString());
    print('**************************isLogin=' + this.isLoading.toString());
    final content = Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 48.0),
            phonenumber,
            SizedBox(height: 24.0),
            loginButton,
            this.isLoading
                ? new Text('')
                : new BarCodeImage(
                  // data: this.base64,
                  data: this.phoneNo,
                  codeType: BarCodeType.Code128,
                  lineWidth: 2,
                  barHeight: 100.0,
                  hasText: true,
                  onError: (error) {
                    print("Generate barcode failed. error msg: $error");
                  },
                ),
          ],
        ),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: content,
    );
  }

}



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.codeList}) : super(key: key);
  final List<BarCodeItem> codeList;
  final String title = "BarCode Flutter";

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: new ListView(
            children: widget.codeList.map((element) {
          return new Padding(
            padding: const EdgeInsets.all(1.0),
            child: new Card(
                child: new Column(children: <Widget>[
              new Align(
                alignment: Alignment.centerLeft,
                child: new Text(
                  element.description,
                  textAlign: TextAlign.left,
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.black45),
                ),
              ),
              new Center(
                  child: new Container(
                padding: const EdgeInsets.all(10.0),
                child: new BarCodeImage(
                  data: element.codeStr,
                  codeType: element.type,
                  lineWidth: 2,
                  barHeight: 100.0,
                  hasText: element.hasText,
                  onError: (error) {
                    print("Generate barcode failed. error msg: $error");
                  },
                ),
              )),
              new Divider(),
              new Divider(),
              new Divider(),
              new Divider(),
              new Divider(),
            ])),
          );
        }).toList()));
  }
}

class BarCodeItem {
  BarCodeType type;
  String codeStr;
  String description;
  bool hasText;
  BarCodeItem({this.type, this.codeStr, this.description, this.hasText});
}
