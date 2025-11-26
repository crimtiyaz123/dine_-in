import 'package:flutter/material.dart';

class AppWidget{
  static TextStyle HeadlineTextFieldStyle(){
    return TextStyle(
      color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold
    );
  }


    static TextStyle boldlineTextFieldStyle(){
    return TextStyle(
      color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold
    );
  }

    static TextStyle SimplelineTextFieldStyle(){
    return TextStyle(
      color: Colors.black, fontSize: 20.0, 
    );
  }
 static TextStyle WhiteTextFieldStyle(){
    return TextStyle(
      color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold
    );
  }

  static TextStyle? boldTextFieldStyle() {}
}