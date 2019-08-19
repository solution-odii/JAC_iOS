import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpAuth with ChangeNotifier {
  //String _userId;

  Future<void> signup(
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

    } catch (error) {
      throw error;
    }

    
      }

  Future<void> signin(String email, String password) async{
      const url = 'http://10.2.2.47:7080/api/customer/login';

      try {
        
        
        final response = await http.post(
        url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: json.encode({'email' : email, 'password' : password},),
      );
        print(json.decode(response.body));
      final responseData = json.decode(response.body);
      if(responseData['error'] != null){
          throw HttpException(responseData['error']['message']);
      }
      } catch (error) {

        throw error;
      }
  }

  Future<void> signinBio(String email, bool fingerprint) async{
    const url = 'http://10.2.2.47:7080/api/customer/login';

    try {
      final response = await http.post(
        url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode({'email' : email, 'fingerprint': fingerprint},),
      );
      print(json.decode(response.body));
      final responseData = json.decode(response.body);
      if(responseData['error']!=null){
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }
}
