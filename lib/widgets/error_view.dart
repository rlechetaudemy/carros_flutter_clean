import 'package:app/imports.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String msg;
  final Color color;

  ErrorView(this.msg, {this.color = Colors.red});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        msg,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: this.color,
          fontSize: 22,
        ),
      ),
    );
  }
}
