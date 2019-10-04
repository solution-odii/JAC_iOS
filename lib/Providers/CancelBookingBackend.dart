
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jac/Constants/Constants.dart';


class CancelBookingBackend with ChangeNotifier{

  Future<void> fetchCancelBooking(int id) async{

    final url = Constants.baseURL+'/api/customer/${id}/book/cancel';
    var response;
    var resp;
    try {
      response = await http.get(
        url,
        headers: {'Accept' : 'application/json'},
      );

      print(jsonDecode(response.body));
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }

    if(response.statusCode==200){

    }


  }




}