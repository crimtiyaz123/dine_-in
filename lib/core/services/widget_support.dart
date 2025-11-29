import 'package:flutter/material.dart';

class AppWidget {
  // ignore: non_constant_identifier_names
  static TextStyle HeadlineTextFieldStyle() {
    return const TextStyle(
      color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold
    );
  }

  static TextStyle boldlineTextFieldStyle() {
    return const TextStyle(
      color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold
    );
  }

  // ignore: non_constant_identifier_names
  static TextStyle SimplelineTextFieldStyle() {
    return const TextStyle(
      color: Colors.black, fontSize: 20.0,
    );
  }

  // ignore: non_constant_identifier_names
  static TextStyle WhiteTextFieldStyle() {
    return const TextStyle(
      color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold
    );
  }

  static TextStyle? boldTextFieldStyle() {
    return null;
  }
}