import 'package:flutter/material.dart';


class InputDecorations {
 
  static InputDecoration authInputDecoration({
    
    required String hintText,
    required String labelText,
    
    IconData? prefixIcon,
    IconData? sufixIcon
  }) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(2, 82, 116, 1)
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(34, 162, 191, 1),
            width: 2
          )
        ),
        hintText: hintText,
      
        hintStyle: TextStyle(color: Colors.black),
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.grey
        ),
        prefixIcon: prefixIcon != null 
          ? Icon( prefixIcon, color: Color.fromRGBO(34, 162, 191, 1) )
          : null,
      );
  }  

}