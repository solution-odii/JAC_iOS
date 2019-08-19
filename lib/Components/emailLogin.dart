import 'package:flutter/material.dart';

class EmailLogin extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    
    return EmailLoginState();
  }
}

class EmailLoginState extends State<EmailLogin>{


 final emailField =  TextField(
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.black,
      //controller: TextEditingController(),
      // obscureText: false,
      // style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "name@example.com",
        labelText: 'Email',
        labelStyle: TextStyle(color: Colors.black),
        hintStyle: TextStyle(color: Colors.black),
        
        border: InputBorder.none
        // fillColor: Colors.black,
        // focusColor: Colors.black,
        // focusedBorder: OutlineInputBorder(
        //     //borderSide: BorderSide(color: Colors.white, width: 5.0),
        //     // borderRadius: BorderRadius.circular(32.0)
        //     ),
      ),
 );
    
  @override
  Widget build(BuildContext context) {
   
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Colors.black)
      ),
     child: emailField);
     
  }


}

