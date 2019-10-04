import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jac/Constants/Constants.dart';
import 'package:jac/main.dart';
import 'package:jac/Screens/LoginScreen.dart';
import 'dart:convert';
import 'package:jac/Models/CarsList.dart';
import 'package:jac/Database/CarModelDB.dart';


class CarListFetchBackend with ChangeNotifier {


  static Future <CarListTypes> carListFetch(BuildContext context) async{
    final url = Constants.baseURL+'/api/customer/car/model';

    CarListTypes carListTypes;
    var response;
    var resp;


    try {
      response = await http.get(url, headers: {"Accept": "application/json"});

      print(response.body);
    } catch (error) {
      print(error.toString());
      SplashScreenState().showErrorDialog(context, error.toString());
    }

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));

      resp = jsonDecode(response.body);

      /// this is for parsing the response to a constants class
      carListTypes = CarListTypes.fromJson(resp);
      print(carListTypes.carListTypes.toString());
      Constants.carListType = carListTypes;

      /// this is for parsing the response into the sqlite database
      for (var carType in carListTypes.carListTypes){
        CarsDatabase.carsDatabase.addCarsToDatabase(carType);
      }


    }


    return carListTypes;
  }
}
