import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String label;
  final String hint;
  final bool password;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final Stream<String?>? stream;

  AppText(
    this.label,
    this.hint, {
    this.stream,
    this.password = false,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.nextFocus,
    this.onSaved,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
        stream: stream,
        builder: (context, snapshot) {
          return TextFormField(
            controller: controller,
            obscureText: password,
            validator: validator,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            focusNode: focusNode,
            onSaved: onSaved,
            onChanged: onChanged,
            style: TextStyle(
              fontSize: 22,
              color: Colors.blue,
            ),
            decoration: InputDecoration(
              errorText: snapshot.data,
              labelText: label,
              labelStyle: TextStyle(
                fontSize: 22,
                color: Colors.grey,
              ),
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: 16,
              ),
            ),
          );
        });
  }
}
