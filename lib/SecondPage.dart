import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: Text(
          "Hello World!!",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
