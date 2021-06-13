import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Stream<bool>? stream;
  final Key? testKey;

  AppButton(this.text, {this.stream, this.onPressed, this.testKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: ElevatedButton(
        key: testKey,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) return Colors.green;
              return Colors.blue;
            },
          ),
        ),
        child: StreamBuilder<bool>(
            stream: stream,
            builder: (context, snapshot) {
              bool loading = snapshot.data ?? false;

              return !loading
                  ? Text(
                      text,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    );
            }),
        onPressed: onPressed,
      ),
    );
  }
}
