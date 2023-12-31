import 'package:flutter/material.dart';

class Utils {

  var messengerKey = GlobalKey<ScaffoldMessengerState>();

  showSnackBar(String? text){
    if (text == null) return;

    final snackBar = SnackBar(content: Text(text));

    messengerKey.currentState!..removeCurrentSnackBar()..showSnackBar(snackBar);

    
  }
}