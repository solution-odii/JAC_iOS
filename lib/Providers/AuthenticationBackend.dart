import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jac/Components/CarRepairsComponents/CarRepairsPageFour.dart';
import 'package:jac/Components/CarRepairsComponents/CarRepairsPageThree.dart';
import 'package:jac/Components/CarServicingComponents/CarServicingPageFour.dart';
import 'package:jac/Components/CarServicingComponents/CarServicingPageOne.dart';
import 'package:jac/Components/CarServicingComponents/CarServicingPageThree.dart';
import 'package:jac/Components/EmergencyServiceComponents/CallEmergencyCenterDialog.dart';
import 'package:jac/Constants/Constants.dart';
import 'package:jac/Screens/HomePage.dart';
import 'package:jac/Screens/LoginScreen.dart';
import 'package:jac/Screens/RegisterScreen.dart';
import 'package:jac/Utils/DialogUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class AuthenticateBackend with ChangeNotifier {
    String userEmail;
    String firstName;
    int userID;
    String responseMessage;
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
    final url = Constants.baseURL+'/api/customer/signup';

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
      responseMessage = responseData['message'];
      print(responseMessage);
      RegisterFormState.errorMessage =responseMessage;

      if(responseData['error'] != null){
        throw HttpException(responseData['error']['message']);
      }

      if(response.statusCode==200){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
        dialog(context);
      }

    } catch (error) {
      RegisterFormState.errorMessage =error.toString();
      print (RegisterFormState.errorMessage);
      RegisterFormState().showErrorDialog(context, error.toString());
    }

    
      }






  Future<void> signInFetch(BuildContext context, String email, String password, bool fingerprint) async{

    userEmail = email;

    var resBody;
    final url = Constants.baseURL+'/api/customer/login';
    //const url_sly ='http://192.168.137.52:7070/api/customer/login';
    //const url_live = 'http://jacautoshop.3lineng.com:7080';

      try {

        final response = await http.post(
        url,
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
         HomePageState.username = firstName;
         HomePageState.userId = userID;
         CarRepairsPageFour.userID = userID;
         CarServicingPageOneState.userID = userID;
         CarServicingPageFour.userID = userID;
         CallEmergencyCenterDialog.customerId = userID.toString();
         saveUserDetails();

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
        }

      final responseData = json.decode(response.body.toString());
        responseMessage = responseData['message'];
        print(responseMessage);
        LoginScreenState.errorMessage =responseMessage;
      if(responseMessage != null){
          throw HttpException(responseMessage);
      }
      } catch (error) {

        throw error;
      }
  }





  Future<void> signInBioFetch(BuildContext context, String email, bool fingerprint) async{
    final url = Constants.baseURL+'/api/customer/login';
    var resBody;

    try {
      final response = await http.post(
        url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode({'email' : email, 'fingerprint': fingerprint},),
      );
      print(json.decode(response.body));
      print(json.decode(response.statusCode.toString()));

      if(response.statusCode==200){
        saveEmail();
        resBody = jsonDecode(response.body.toString());
        firstName = resBody['firstName'];
        userID = resBody['id'];
        HomePageState.username = firstName;

        HomePageState.userId = userID;
        CarRepairsPageFour.userID = userID;
        CarServicingPageOneState.userID = userID;
        CarServicingPageFour.userID = userID;
        CallEmergencyCenterDialog.customerId = userID.toString();
        saveUserDetails();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
      }

      final responseData = json.decode(response.body.toString());
      responseMessage = responseData['message'];
      print(responseMessage);
      LoginScreenState.errorMessage =responseMessage;
      if(responseMessage != null){
        throw HttpException(responseMessage);
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


    dialog(BuildContext context){
      Utils().openDialog(BeautifulAlertDialog(
        assetImage: 'assets/images/successimage.png',
        firstText:  'Registration Successfull',
        secondText:  'You would recieve a confirmation mail',
        confirmText: 'Okay',),

          context);


    }

}
