import 'package:flutter/material.dart';

class PasswordLogin extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    
    return PasswordLoginState();
  }
}

class PasswordLoginState extends State<PasswordLogin>{


  final passwordField = TextField(
      keyboardType: TextInputType.text,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "******",
        labelText: 'Password',
        hintStyle: TextStyle(color: Colors.black),
        labelStyle: TextStyle(color: Colors.black),
        border: InputBorder.none
      ),
    );

  @override
  Widget build(BuildContext context) {
   
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Colors.black)
      ),
     child: passwordField);
  }
}