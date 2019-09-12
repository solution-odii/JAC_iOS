import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jac/Components/CarServicingComponents/CarServicingPageOne.dart';

class BookCarServiceBackend with ChangeNotifier{

  Future<void> mileageRecommendFetch(
      BuildContext context,
      int custid,
      String mileage) async{
    var url = 'http://10.2.2.47:7080/api/customer/${custid}/recommends/${mileage}/service';
    var respBody;
    try {
      final response = await http.get(
        url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},

      );
      print(json.decode(response.body));
      print(json.decode(response.statusCode.toString()));

      if(response.statusCode==200){
        respBody = jsonDecode(response.body.toString());

       CarServicingPageOneState.recommendedService =respBody['message'];
        print(CarServicingPageOneState.recommendedService);
      }


      final responseData = json.decode(response.body);

      if(responseData['error']!=null){
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }

  }






  Future<void> bookCarServicingFetch(
      int customerId,
      String date,
      int mileage,
      String typeOfServicing,
      String notificationTime,
      String serviceType,
      String serviceUsername,
      String vehicleBrand,
      String vehicleType) async {
    const url_test =
        "http://10.2.2.47:7080/api/customer/book";

    var response;
    var resp;

    try {
      response = await http.post(
        url_test,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode({
          'customerId': customerId,
          'date': date,
          'mileage': mileage,
          'typeOfServicing': typeOfServicing,
          'notificationTime': notificationTime,
          'serviceType': serviceType,
          'serviceUsername': serviceUsername,
          'vehicleBrand': vehicleBrand,
          'vehicleType': vehicleType,
        }),
      );
      print(json.decode(response.body));
      print(json.decode(response.statusCode.toString()));
    } on Exception catch (e) {
      print(e.toString());
    }

    if (response.statusCode == 200) {
      resp = jsonDecode(response.body);
    }

  }

}