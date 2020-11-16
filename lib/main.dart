import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'masapp',
      home: Scaffold(
        appBar: AppBar(
          title: Text('masapp'),
        ),
        body: Center(
          child: Container(
            child: Text('masapp'),
          ),
        ),
      ),
    );
  }
}
