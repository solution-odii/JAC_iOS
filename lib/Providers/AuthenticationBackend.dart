import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jac/Screens/homePage.dart';
import 'package:jac/Screens/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthenticateBackend with ChangeNotifier {
  //String _userId;

    String userEmail;
    String firstName;
    int userID;

    SharedPreferences sharedPreferences;

  Future<void> signUpFetch(
      BuildContext context,
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String vehicleModel,
      String plateNumber,
      String password) async {
    const url = 'http://10.2.2.47:7080/api/customer/signup';

    try {
      final response = await http.post(
      url,
       headers: {
        HttpHeaders.contentTypeHeader: 'application/json'
      },
      body: json.encode(
        {
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'phoneNumber': phoneNumber,
          'vehicleModel': vehicleModel,
          'plateNumber': plateNumber,
          'password': password,
        },
      ),
    );
    print(json.decode(response.body));

      final responseData = json.decode(response.body);
      if(responseData['error'] != null){
        throw HttpException(responseData['error']['message']);
      }

      if(response.statusCode==200){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      }

    } catch (error) {
      throw error;
    }

    
      }






  Future<void> signInFetch(BuildContext context, String email, String password, bool fingerprint) async{

    userEmail = email;

    var resBody;
    const url_test = 'http://10.2.2.47:7080/api/customer/login';
    //const url_sly ='http://192.168.137.52:7070/api/customer/login';
    //const url_live = 'http://jacautoshop.3lineng.com:7080';

      try {

        final response = await http.post(
        url_test,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: json.encode({'email' : email, 'password' : password, 'fingerprint': false},),
      );
        print(json.decode(response.body));
        print(json.decode(response.statusCode.toString()));

        if(response.statusCode==200){
         saveEmail();
         resBody = jsonDecode(response.body.toString());
        firstName = resBody['firstName'];
        userID = resBody['id'];
        print(userID);
        print(firstName);
        saveUserDetails();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
        }

      final responseData = json.decode(response.body);
      if(responseData['message'] != null){
          throw HttpException(responseData['message']);
      }
      } catch (error) {

        throw error;
      }
  }





  Future<void> signInBioFetch(BuildContext context, String email, bool fingerprint) async{
    const url = 'http://10.2.2.47:7080/api/customer/login';

    try {
      final response = await http.post(
        url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode({'email' : email, 'fingerprint': fingerprint},),
      );
      print(json.decode(response.body));
      print(json.decode(response.statusCode.toString()));

      if(response.statusCode==200){

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
      }


      final responseData = json.decode(response.body);

      if(responseData['error']!=null){
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }

  }




  saveEmail()async{
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("Email", userEmail);

  }

    saveUserDetails()async{
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("FirstName", firstName);
      sharedPreferences.setInt('id', userID);

    }


}
