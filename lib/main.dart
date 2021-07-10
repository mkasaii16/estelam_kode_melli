import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'myhomepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue[900],
    ));
    return MaterialApp(
      title: 'استعلام کد ملی',
      home: MyHomePage(),
    );
  }
}
