import 'package:flutter/material.dart';

class NotFoundRoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Not Found"),
      ),
      body: body(),
    );
  }

  body() {
    return Container(
      child: Center(
        child: Text(
          "Route not found..",
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
